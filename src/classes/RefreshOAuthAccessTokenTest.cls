/**
 * @author ercarval
 */
@isTest
private class RefreshOAuthAccessTokenTest {

    @isTest
    public static void givenOAuthConfigWhenScheduledThenAuthenticate () {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig ('OAUTH', 'MockCommandLogTrace', 'OAUTH');

        RefreshOAuthAccessToken.start();

        RefreshOAuthAccessToken.abort();

        new RefreshOAuthAccessToken().execute(null);

    }

}