/**
 *
 * @author: Eduardo Ribeiro de Carvalho
 */
@isTest
public with sharing class EventQueueTest {

    testMethod
    public static void givenKnowEventWhenProcessThisYourStatusIsSucess () {
        //-- fixture
        EventQueueFixtureFactory.createConfigForMockCommandLogTrace () ;
        EventQueue event = EventQueueFixtureFactory.createBaseEvent ('PROCESS_MOCK_EVENT_TRACE' );

        //-- assertion
        event.process();
        System.debug (event.getStackTrace());
        System.assertEquals('DELIVERED', event.getStatus());

    }


    testMethod
    public static void givenUnknowEventWheIsProcessedThenYourStatusIsUnhandled() {

        EventQueue queuedEvent =  EventQueueFixtureFactory.createBaseEvent ('SYNC_XXXXX_OUTBOUND' );
        queuedEvent.process();
        System.assertEquals( 'UNHANDLED', queuedEvent.get().status__c);
    }

    testMethod
    public static void givenValidEventThenProcessThisEvent() {

        EventQueueFixtureFactory.createConfigForMockCommandLogTrace ();

        EventBuilder builder = new EventBuilder();

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('PROCESS_MOCK_EVENT_TRACE');

        Test.startTest();

        event.process();

        event.save();

        event.successfullyProcessedEvent( );
        event.save();

        //event.findAllQueuedEvents(new Set<String>{''+ event.get().id} );
        event.findOne( event.get().id );
        event.findLastEventsByNameAndBusinessDocumentNumber( 'SYNC_XXXX', '9832394328');

        Test.stopTest();


    }

    testmethod
    public static void publishNewEventSuccess() {

        EventQueueFixtureFactory.createConfigForMockCommandLogTrace ();


        EventQueue event = EventQueueFixtureFactory.createBaseEvent('PROCESS_MOCK_EVENT_TRACE');

        Test.startTest();

        event.save();

        System.debug('\n\n\n\n ------------------------------ ');

        System.debug(event);

        Test.stopTest();

    }

    testMethod
    public static void giveEventWithProcessingLogThenCreateAttachmentForThis () {

        EventQueueFixtureFactory.createEventConfigForEvent ('MOCK_LOG', 'MockCommandLogTrace');

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('MOCK_LOG');

        event.setPayload('MegaPayload');

        event.save();

        Test.startTest();

        event.process();

        event.save();

        String payload = event.getLastAttachedPayloadForEvent();

        System.assert( payload != null );

        System.assert( event.findAttachmentsForEvent(event.get().id ).size () > 0 );

        System.debug('\n\n\n\n ------------------------------ ');

        System.debug(event);

        Test.stopTest();

    }


    testMethod
    public static void whenEventThrowsExceptionThenCatchAndSaveWithError () {


        EventQueueFixtureFactory.createEventConfigForEvent ('PROCESS_MOCK_EVENT_EXCEPTION', 'MockThrowsExeceptionCommand');

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('PROCESS_MOCK_EVENT_EXCEPTION');

        event.save();

        Test.startTest();

        event.process();

        event.postExecute();

        System.debug('\n\n\n\n ------------------------------ ');

        System.assert( event.getStatus() == EventQueueStatusType.ERROR.name() );
        System.assert( event.getStackTrace() != null );

        Test.stopTest();


    }

    @isTest
    public static void whenEventThrowsIntegrationExceptionThenCatchAndSaveWithError () {


        EventQueueFixtureFactory.createEventConfigForEvent ('PROCESS_MOCK_EVENT_EXCEPTION', 'MockIntegrationExceptionCommand');

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('PROCESS_MOCK_EVENT_EXCEPTION');

        event.save();

        Test.startTest();

        event.process();

        event.postExecute();

        System.debug('\n\n\n\n ------------------------------ ');

        System.assert( event.getStatus() == EventQueueStatusType.ERROR.name() );
        System.assert( event.getStackTrace() != null );

        Test.stopTest();


    }

    @isTest
    public static void givenEventTypeWhenNewEventCreatedThenSetEventName () {

        EventQueue event = new EventQueue( EventType.BUSINESS_ACKNOWLEDGEMENT );

        System.assert( event.getEventName() ==  EventType.BUSINESS_ACKNOWLEDGEMENT.name() );

    }

    @isTest
    public static void givenListOfEventsWhenSaveThenCreateAllEventQueueEntriesSuccessfully () {

        EventQueue event = new EventQueue( EventType.BUSINESS_ACKNOWLEDGEMENT );

        event.createAllEvents ( new List<EventQueue> {event} );

    }




}