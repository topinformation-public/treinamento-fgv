/**
 * @see RefreshOAuthAccessToken
 * @author ercarval - topi
 */
public class AccessToken {

    public String refresh_token_expires_in;
    public String api_product_list;
    public String token_type;
    public String issued_at;
    public String client_id;
    public String access_token;
    public String scope;
    public String expires_in;
    public String refresh_count;
    public String status;

    public AccessToken () {
    }

    //4 test injection
    public AccessToken (String access_token) {
        this.access_token = access_token;
    }

    override
    public String toString () {
        return JSON.serialize (this, true);
    }

}