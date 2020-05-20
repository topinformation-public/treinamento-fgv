public class HeaderRequestBuilder implements ProxyRequestBuilder {

    private HttpRequest request;

    public HeaderRequestBuilder() {
    }

    public HeaderRequestBuilder( HttpRequest request) {
        this.request = request;
    }

    public HttpRequest build (Object payload) {
        
        String url = this.request.getEndpoint();

        this.request.setEndpoint( url 
                + buildStartQueryStringUrl (url) 
                + buildQueryParameters ( deserializeToForm (payload) )   );
        
        return this.request;
    }


    public String buildQueryParameters (Map<String, String> parameters) {

        String queryParameters = '';
        
        for ( String paramName : parameters.keySet() ) {

            if (parameters.get( paramName ) == null) continue;

            queryParameters += paramName + '=' + EncodingUtil.urlEncode( parameters.get( paramName ), 'UTF-8') + '&';
        }

        return queryParameters;

    }

    private Map<String,String> deserializeToForm (Object obj) {
        
        Map<String,Object> deserializedParameter = (Map<String, Object>) JSON.deserializeUntyped( JSON.serialize (obj) );
        
        Map<String,String> parameters = new Map<String,String>();
        
        for ( String parameterName :  deserializedParameter.keySet()) {

            parameters.put ( parameterName , (String) + deserializedParameter.get( parameterName ) );

        }

        return parameters;

    }


    @TestVisible
    private String buildStartQueryStringUrl (String url) {
         
        if (url.indexOf('?') == -1) return '?';

        if (!url.endsWith('&')) return '&';

        return '';
    }


}