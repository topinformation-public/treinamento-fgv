/**
 * @author: ercarval
 */
public virtual class BaseRestProxy {

    private static final String JSON_CONTENT_TYPE = 'application/json; charset=UTF-8';

    private Http http = new Http();

    protected HttpRequest httpRequest {get; set;}

    protected HttpResponse httpResponse {get; set;}

    private HttpAuthentication authentication;

    private String url;

    private String method;

    private EventConfiguration__c config;

    public BaseRestProxy() {
        http = new Http();
        httpRequest = new HttpRequest();
        httpRequest.setTimeout(120000);
    }


    public BaseRestProxy(EventConfiguration__c config) {
        this();
        url = config.endPointUrl__c;
        method = config.method__c;
        authentication = HttpAuthentication.build(config);
    }

    virtual
    protected void setup( ) {

        System.debug(' --------- Setup Https to  ' + url );

        this.httpRequest.setEndpoint( url );
        this.httpRequest.setMethod( method );
        this.httpRequest.setHeader('Content-Type', JSON_CONTENT_TYPE);

        setupConfigHeaders ();

        setupAuthorization();
    }

    virtual
    public void setupConfigHeaders () {

        if (config == null || config.headers__c == null) return;

        Map<String, String> headers = loadCofiguredHeaders(config.headers__c);

        for (String headerKey : headers.keySet()) {
            this.httpRequest.setHeader( headerKey , headers.get(headerKey) );
        }

    }

    private Map<String, String> loadCofiguredHeaders (String headersJsonPayload) {

        Map<String, String> headers = new Map<String, String>();

        try {

            headers = (Map<String, String>) JSON.deserialize( headersJsonPayload ,  Map<String, String>.class);

        } catch (JsonException e) {
        }

        return headers;

    }


    virtual
    protected void setupAuthorization () {

        if ( !this.authentication.needAuthentication() ) return;

        this.httpRequest.setHeader('Authorization', authentication.getHttpHeader());

    }

    virtual
    public String get( Map<String, String> uriParameters) {
        return get ( setUriParameters ( uriParameters ) );
    }

    virtual
    public String get ( String urlComplement ) {

        setup();
        
        if (!String.isEmpty(urlComplement)) url += urlComplement;

        this.httpRequest.setEndpoint( url );

        httpResponse = tryToSend (this.httpRequest);

        return httpResponse.getBody();

    }

    virtual
    public String send( Object obj ) {

        setup();

        setBody (obj);

        httpResponse = tryToSend (this.httpRequest);

        return httpResponse.getBody();

    }

    private HttpResponse tryToSend (HttpRequest request) {

        for (Integer i = 0 ; i < 3; i++) {

            try {

                this.httpResponse = http.send(this.httpRequest);
                break;

            } catch (CalloutException e) {

                System.debug('  --------- Error [ retry ' + i + ' ] - ' + e.getMessage());

                if (i == 2) throw e;
            }

        }

        postSend();

        handleResponseStatus(this.httpResponse);

        return this.httpResponse;
    }

    /**
     * Use this method to collect httpResponse value
     */
    virtual
    public void postSend() {
        System.debug('  --------- RESPONSE CODE : ' + httpResponse.getStatusCode());
        System.debug('  --------- RESPONSE Status : ' + httpResponse.getStatus());
        System.debug('  --------- RESPONSE BODY : ' + httpResponse.getBody());
    }

    virtual
    public void setBody (Object obj) {

        this.httpRequest.setBody (JSON.serialize(obj));

    }

    public String setUriParameters( Map<String, String> uriParameters ) {

        String urlQueryString = buildStartQueryStringUrl ();

        for ( String paramName : uriParameters.keySet() ) {

            if (uriParameters.get( paramName ) == null) continue;

            urlQueryString += paramName + '=' + uriParameters.get( paramName ) + '&';
        }

        return urlQueryString;
    }

    @TestVisible
    private String buildStartQueryStringUrl () {

        if (url.indexOf('?') == -1) return '?';

        if (!url.endsWith('&')) return '&';

        return '';
    }

    virtual
    public void handleResponseStatus( HttpResponse response ) {

        if (response.getStatusCode() == 200) return;

        handleIntegrationErrorResponse(response);

    }

    virtual
    public void handleIntegrationErrorResponse ( HttpResponse response  ) {

        throw new IntegrationException (response);

    }

}