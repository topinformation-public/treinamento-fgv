/**
 * @author: ercarval - topi
 */
@isTest
private class AbsractInboundServiceTest {

    @isTest
    static void givenInboundServiceWhenExecutedProcessEventSuccessfully() {

        EventQueue event = EventQueueFixtureFactory.createBaseEvent('INBOUND EVENT');

        String expectedPayload = '{"message" : "success"}';

        InboundServiceMock service = new InboundServiceMock ( event , expectedPayload );

        service.execute();

        EventQueue eventProcessed = service.getEvent();

        System.assert( eventProcessed.getEventId () != null );

        // Implement test code
    }

    public class InboundServiceMock extends AbstractInboundService {

        String payload;

        public InboundServiceMock (EventQueue event, String payload) {
            super (event);
            this.payload = payload;
        }

        override
        public void handleEvent() {
        }

        override
        public void setEventPayload () {
            getEvent().setPayload (payload);
        }

    }


}