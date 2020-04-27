/**
 * @author: Eduardo Ribeiro de Carvalho - ercarval
 */
@isTest
public class RefreshOAuthOutboundCommandTest {

    @isTest
    public static void givenValidClientKeyAndSecretWhenGetTokenThenReceiceValidToken () {        
        
        OAuthConfiguration__c oauthConfig = EventQueueFixtureFactory.createOAuthConfig ('OAUTH', 'REFRESHTOKEN', 'ORDER',  '122132132' );
        
        EventQueueFixtureFactory.createEventConfigForEvent ('OAUTH', 'RefreshOAuthOutboundCommand' );

        EventQueue event = new EventBuilder()
                         .createEventFor('OAUTH')
                         .withSameDocumentNumberForAllIdentifiers ('oauth.scope')
                         .withPayload( JSON.serialize (oauthConfig) )
                         .withStatus ('INVALID')
                         .buildAndSave();
        
        Test.startTest();

        Test.setMock( HttpCalloutMock.class , new HttpMock ( new AccessToken ('132131223123').toString() , true ) );


        RefreshOAuthOutboundCommand command = new RefreshOAuthOutboundCommand();
        command.execute (event);
        command.postUpdateExecute (event);
        
        Test.stopTest();
    }

}