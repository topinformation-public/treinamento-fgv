public with sharing class EnrollmentEventPublisher {

    public List<EventQueue> publish (List<Lead> leads) {

        List<EventQueue> events = new List<EventQueue>();

        for (Lead lead : leads) {
            
            events.add ( new EventBuilder().createOutboundEventFor('GET_ADDRESS_OUTBOUND')
                    .forObjectId(lead.Id)
                    .withReceiver('GATEWAY')
                    .withBusinessDocumentNumber (lead.Name)    
                    .buildEvent() );

        }
        
        new EventQueue().createAllEvents(events);
        return events;

    }

}