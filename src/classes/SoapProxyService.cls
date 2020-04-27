/**
 * @author: ercarval - topi
 */
public interface SoapProxyService {

    String getEndPoint ();

    void setEndPoint (String url);

    void addAuthenticationHeader(String headerValue);

    void setClientCertName (String clientCertName);

    void setClientCert( String clientCert );

    void setClientCertPassword( String clientCertPasswd );

    void setTimeout( Integer timeout );

}