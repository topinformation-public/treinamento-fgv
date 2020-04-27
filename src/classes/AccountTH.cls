public class AccountTH extends TriggerHandler {

    List<Account> newAccounts;
    Map<Id, SObject> oldAccounts;

    public AccountTH () {
        this ( (List<Account>) Trigger.new, (Map<Id, SObject>) Trigger.oldMap );
    }

    public AccountTH (List<Account> newAccounts
        ,  Map<Id, SObject> oldAccounts ) {
        this.newAccounts = newAccounts;
        this.oldAccounts = oldAccounts;
    }

    override
    public void afterInsert() {
        enrichAccountWithAddress();
    }

    override
    public void afterUpdate() {
        enrichAccountWithAddress ();
    }

    public void enrichAccountWithAddress () {
        
        List<EventQueue> events = new List<EventQueue>();
        for (Account account : newAccounts) {
            events.add ( new EventBuilder().createOutboundEventFor('GET_ADDRESS_OUTBOUND')
                    .forObjectId(account.Id)
                    .withReceiver('GATEWAY')
                    .withBusinessDocumentNumber (account.BillingPostalCode)
                    .buildEvent()
            );
        }

        new EventQueue().createAllEvents(events);
    }

}