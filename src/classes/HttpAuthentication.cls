/**
 *
 * @author: ercarval
 */
public with sharing class HttpAuthentication {

	public String type;

	public String user;

	public String password;

	public String token;

	public HttpAuthentication() {
	}

	public boolean needAuthentication () {
		return  type == 'BASIC' || type == 'OAUTH';
	}

	public String getHttpHeader () {

		if (type == 'BASIC')
			return basicAuthentication();

		if (type == 'OAUTH')
			return oauthAuthentication();

		return null;

	}


	private String basicAuthentication () {

		String header = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf( user + ':' + password ));

		System.debug('\n --------- Auth Header : ' + header );

		return  header;
	}

	private String oauthAuthentication () {



		String header =  'Bearer ' + token;

		System.debug(' --------- Auth Header : ' + header );

		return  header;
	}

	/**
	 * TO-DO :  tratar variação como config mesmo ou  especializar a implementação ?
	 */
	public static HttpAuthentication build (EventConfiguration__c config) {

		OAuthIntegrationBusConfiguration oathConfig = OAuthIntegrationBusConfiguration.buidFromConfigName(config.oauthName__c) ;

		HttpAuthentication auth = new HttpAuthentication();
		auth.user = config.username__c;
		auth.password = config.password__c;
		auth.type = config.authType__c;

		if (oathConfig != null)  auth.token = oathConfig.token;

		return auth;
	}

}