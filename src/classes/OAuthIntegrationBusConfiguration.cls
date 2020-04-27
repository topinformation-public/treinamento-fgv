/**
 * @author: Eduardo Ribeiro de Carvalho - ercarval
 */
public class OAuthIntegrationBusConfiguration {


	private static Map<String, OAuthConfiguration__c> oauths;

	static {

		oauths = OAuthConfiguration__c.getAll();

	}

	public String clientKey;
	public String clientSecret;

	public String name;
	public String scope;
	public String username;
	public String password;
	public String grantType;
	public String eventName;
	public boolean enabled;

	public String token;

	public static List<OAuthIntegrationBusConfiguration> getAllConfigurations () {
		List<OAuthIntegrationBusConfiguration> configs = new List<OAuthIntegrationBusConfiguration>();

		for (String name : oauths.keySet()) {
			configs.add (buidFromConfigName (name));
		}

		return configs;
	}


	public static OAuthIntegrationBusConfiguration buidFromConfigName (String oauthSettingName) {

		if (oauthSettingName == null) return null;


		OAuthConfiguration__c oauth = oauths.get(oauthSettingName);

		if (oauth == null) return null;

		return new OAuthIntegrationBusConfiguration()
		       .fromConfig(oauth);

	}


	private OAuthIntegrationBusConfiguration fromConfig (OAuthConfiguration__c oauth) {

		this.name = oauth.name;
		this.scope = oauth.scope__c;
		this.username = oauth.username__c;
		this.password = oauth.password__c;
		this.grantType = oauth.grantType__c;
		this.clientKey = oauth.clientKey__c;
		this.clientSecret = oauth.clientSecret__c;
		this.token = oauth.token__c;
		this.eventName = oauth.eventName__c;
		this.enabled = oauth.enabled__c;
		return this;

	}

	public void save() {

		OAuthConfiguration__c oauth = toOAuthConfig();
		oauth.token__c = this.token;
		update oauth;
	}

	private OAuthConfiguration__c toOAuthConfig() {

		OAuthConfiguration__c oauth = oauths.get(this.name);

		if (oauth == null) return null;

		return oauth;

	}

}