@isTest
public with sharing class EventBuilderTest {

    testMethod
    public static void buildEvent() {

        EventBuilder builder = new EventBuilder();
        builder.createOutboundEventFor( 'SYNC_BACKORDER_OUTBOUND' )
        .forObjectId( '3213213112321')
        .withBusinessDocumentNumber ( 'XXXXXXXX' )
        .withBusinessDocumentCorrelatedNumber( 'XXXXXX' )
        .withInternalID ('XXXXXXXX')
        .forEvent('XXXXXXXXXX')
        .withPayload( 'XXXXXXXX' )
        .withSender ('EXECUTIVE_CRM')
        .withReceiver ('EPARTS-REVAMP')
        .usingRetryStrategy()
        .disablingRetryStrategy ()
        .build();



    }


    @isTest
    public static void buildEventWithSameIdentifiers() {

        EventBuilder builder = new EventBuilder();


        Queue__c eventQueue = builder.createOutboundEventFor( 'SYNC_BACKORDER_OUTBOUND' )
                              .withSameDocumentNumberForAllIdentifiers ( 'XXXXXXXX' )
                              .forEvent('XXXXXXXXXX')
                              .withPayload( 'XXXXXXXX' )
                              .withSender ('EXECUTIVE_CRM')
                              .withReceiver ('EPARTS-REVAMP')
                              .withStatus ('SUCCESS')
                              .withStatusMessage ('HELLO')
                              .disablingRetryStrategy ()
                              .build();





    }

}