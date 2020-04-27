public with sharing class EventChainBuilder {

    public void enqueue (String accountId, String zipCode) {

        EventQueue event = new EventBuilder().createOutboundEventFor('GET_ADDRESS_OUTBOUND')
                    .withStatus(EventQueueStatusType.WORKFLOW.name())
                    .forObjectId(accountId)
                    .withReceiver('GATEWAY')
                    .withBusinessDocumentNumber (zipCode)
                    .buildAndSave();

        System.enqueueJob( new EventExecutor ( event.get() )  );

    }


}