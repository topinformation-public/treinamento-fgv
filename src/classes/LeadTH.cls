public with sharing class LeadTH  extends TriggerHandler {

    List<Lead> newLeads;
    Map<Id, SObject> oldLeads;

    public LeadTH () {
        this( (List<Lead>) Trigger.new, (Map<Id, SObject>) Trigger.oldMap );
    }

    public LeadTH (List<Lead> newLeads, Map<Id, SObject> oldLeads) {
        this.newLeads = newLeads;
        this.oldLeads = oldLeads;
    }   

    override
    public void afterUpdate(){
        enqueueEnrollment ();
    }

    public void enqueueEnrollment () {

        List<Lead> convertedLeads = new Filter().relevantChangeRecordsFilter(newLeads, oldLeads, 'Status', 'Closed - Converted');

        new EnrollmentEventPublisher().publish(convertedLeads) ;

    }


}