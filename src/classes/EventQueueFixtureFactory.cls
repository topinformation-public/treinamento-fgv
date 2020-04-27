/**
 *
 * @author: Eduardo Ribeiro de Carvalho
 */
@isTest
public with sharing class EventQueueFixtureFactory {

    public static OAuthConfiguration__c createOAuthConfig (String name, String eventName, String scope,  String token ) {
        OAuthConfiguration__c oauth = new OAuthConfiguration__c( name = name,
                scope__c = scope,
                token__c = token,
                eventName__c = eventName,
                username__c = 'user',
                password__c = 'pass',
                grantType__c = 'GRANT',
                clientKey__c = 'KEY',
                clientSecret__c = 'SECRET',
                enabled__c = true  );

        insert oauth;

        return oauth;
    }

    public static void createEventConfigForEventWithOAuthConfig ( String name , String commandClassName, OAuthConfiguration__c oauth  ) {
        createEventConfig ( new EventConfiguration__c (name = name,
                            endPointUrl__c = 'endpointUrl',
                            method__c = 'POST',
                            oauthName__c = oauth.Name,
                            authType__c = 'OAUTH',
                            commandClassName__c = commandClassName));
    }


    public static void createOutboundEventConfigWithOAuthConfig ( String name , String commandClassName, String oauthName   ) {

        OAuthConfiguration__c oauth = createOAuthConfig (oauthName, 'REFRESH_' + oauthName , '/pedido', '12345');

        createEventConfigForEventWithOAuthConfig (name, commandClassName, oauth );

    }

    public static void createEventConfigForEvent ( String name , String commandClassName  ) {
        createEventConfig ( new  EventConfiguration__c (name = name,
                            endPointUrl__c = 'endpointUrl',
                            authType__c = 'BASIC',
                            method__c = 'POST',
                            commandClassName__c = commandClassName));
    }

    public static void createEventConfigForUnhandledEvent ( ) {
        createEventConfig ( new  EventConfiguration__c (name = 'SYNC_OUTBOUND',
                            endPointUrl__c = 'endpointUrl',
                            commandClassName__c = 'UnHandledCommand'));
    }

    public static void createConfigForMockCommandLogTrace() {
        createEventConfig ( new  EventConfiguration__c (name = 'PROCESS_MOCK_EVENT_TRACE'
                            , commandClassName__c = 'MockCommandLogTrace'));

    }

    public static void createConfigForMockExceptionCommand() {
        createEventConfig ( new  EventConfiguration__c (name = 'PROCESS_MOCK_EVENT_EXCEPTION'
                            , commandClassName__c = 'MockThrowsExeceptionCommand'));

    }

    public static void createEventConfig ( EventConfiguration__c config ) {
        insert config;
    }

    public static EventQueue createBaseEvent (String eventName) {
        EventBuilder builder = new EventBuilder();
        return builder.createEventFor( eventName )
               .withBusinessDocumentNumber ('BIZDOC')
               .withBusinessDocumentCorrelatedNumber( 'BIZDOC' )
               .withInternalID ('1234')
               .withSender ('SENDER')
               .withReceiver ('RECEIVER')
               .usingRetryStrategy ()
               .buildEvent();

    }

    public static EventQueue newB2dEventQueueFromJson() {

        String eventJson = '{"sender": "B2D","receiver": "SALESFORCE","internalId": "20170103122001","eventName": "B2D_CREATE_OPPORTUNITY_INBOUND","businessDocumentNumber": "CustomerPO-03012017","businessDocumentCorrelatedNumber": "CustomerPO-03012017"}';

        return (EventQueue) JSON.deserialize(eventJson, EventQueue.class);
    }

    public static EventQueue newB2bEventQueueFromJson() {

        String eventJson = '{"sender": "B2B","receiver": "SALESFORCE","internalId": "20170606120101","eventName": "B2B_CREATE_OPPORTUNITY_INBOUND","businessDocumentNumber": "4500510522","businessDocumentCorrelatedNumber": "4500510522"}';

        return (EventQueue) JSON.deserialize(eventJson, EventQueue.class);
    }

    public static String getOrderInboundResultFromJson() {
        return '{"returnRS":[{"messageType":"S","messageText":"SALES_HEADER_IN processado com Ãªxito","messageNumber":"233"},{"messageType":"S","messageText":"SALES_ITEM_IN processado com Ãªxito","messageNumber":"233"},{"messageType":"S","messageText":"SALES_CONDITIONS_IN processado com Ãªxito","messageNumber":"233"},{"messageType":"W","messageText":"Documento de vendas e distrib.ainda incompleto -> completar","messageNumber":"555"},{"messageType":"W","messageText":"Em item 000010 considerar a unidade de medida de remessa: 5,000 PC","messageNumber":"081"},{"messageType":"S","messageText":"DX OV Normal 2669678 foi gravado(a)","messageNumber":"311"}],"numberOfGeneratedDocument":"0002669678"}';
    }


}