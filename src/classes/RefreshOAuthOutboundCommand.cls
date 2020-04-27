/**
 * @see RefreshOAuthAccessToken
 * @author ercarval - topi
 */
public virtual class RefreshOAuthOutboundCommand extends AbstractUpdateableOutboundCommand {

    OAuthIntegrationBusConfiguration config;

    AccessToken accessToken;

    public RefreshOAuthOutboundCommand() {
    }

    override
    public void init (EventQueue event) {
        super.init(event);
        config = getPayload () ;
    }

    virtual
    protected OAuthIntegrationBusConfiguration getPayload () {
        return  (OAuthIntegrationBusConfiguration)
                JSON.deserialize( event.getPayload() , OAuthIntegrationBusConfiguration.class );

    }
    
    /**
     * Utilizado para application/x-www-form-urlencoded
     */
    override
    public BaseRestProxy getHttpRequestProxy (EventQueue event) {
        return new PostFormProxy (event);
    }

    override
    public Object transformToSend () {
        return 'client_id=' + config.clientKey
               + '&client_secret=' + config.clientSecret;
    }

    override
    public void processResult(Object responseObject) {
        this.accessToken = (AccessToken) JSON.deserialize( (String) responseObject, AccessToken.class);
    }

    override
    public void postUpdateExecute() {

        this.config.token = accessToken.access_token;
        this.config.save();

    }

}