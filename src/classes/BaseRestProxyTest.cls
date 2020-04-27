/**
 * @author: ercarval - topi
 */
@isTest
private class BaseRestProxyTest {

    @isTest
    static void sendPostRequest() {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig('SYNC_OUT', 'CommandName', 'OAUTH'  );

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUT');

        Test.setMock( HttpCalloutMock.class , new HttpMock ('{"response":"ok"}', true) );
        Test.startTest();


        RestProxy proxy = new RestProxy(event);

        String reponse = proxy.send ('request');

        proxy = new RestProxy();

        Test.stopTest();


    }

    @isTest
    static void sendGetRequest() {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig('SYNC_OUT', 'CommandName', 'OAUTH'  );

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUT');

        Test.setMock( HttpCalloutMock.class , new HttpMock ('{"response":"ok"}', true) );
        Test.startTest();

        RestProxy proxy = new RestProxy(event);

        String reponse = proxy.get ( new Map<String, String> {'key' => 'value'});
        Test.stopTest();

    }


    @isTest
    static void sendPostRequestFail() {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig('SYNC_OUT', 'CommandName', 'OAUTH'  );

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUT');

        Test.setMock( HttpCalloutMock.class , new HttpMock ('{"returnRS":[{"messageType":"E","messageNumber":"200","messageText":"Para o cliente não existe nenhum mestre de cliente","messageLog":"000000"},{"messageType":"E","messageNumber":"219","messageText":"O doc.vendas não será modificado","messageLog":"000000"}]}', false) );
        Test.startTest();


        RestProxy proxy = new RestProxy(event);

        try {
            String reponse = proxy.send ('request');
        } catch (Exception e) {}


        proxy = new RestProxy();

        Test.stopTest();


    }

    @isTest
    static void sendPostFormRequest() {

        EventQueueFixtureFactory.createOutboundEventConfigWithOAuthConfig('SYNC_OUT', 'CommandName', 'OAUTH'  );

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('SYNC_OUT');

        String expectedResponse = '{"returnRS":[{"messageType":"E","messageNumber":"200","messageText":"Para o cliente não existe nenhum mestre de cliente","messageLog":"000000"},{"messageType":"E","messageNumber":"219","messageText":"O doc.vendas não será modificado","messageLog":"000000"}]}';

        Test.setMock( HttpCalloutMock.class , new HttpMock (expectedResponse) );

        Test.startTest();

        // 4 coverage
        new PostFormProxy();

        // 4 coverage
        new PostFormProxy(event.config);

        PostFormProxy proxy = new PostFormProxy(event);

        try {

            String reponse = proxy.send ('request');

            System.assert( reponse == expectedResponse );

        } catch (Exception e) {

            System.assert( false , e.getMessage() );
        }

        Test.stopTest();

    }


}