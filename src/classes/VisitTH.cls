public with sharing class VisitTH extends TriggerHandler {

    List<Visit__c> newVisits;
    Map<Id, SObject> oldVisits;

    AccountVisitEnricher accountVisitEnricher;

    public VisitTH () {
        this( (List<Visit__c>) Trigger.new
        ,  (Map<Id, SObject>) Trigger.oldMap );
    }

    public VisitTH ( List<Visit__c> newVisits, Map<Id, SObject> oldVisits ) {
        this.newVisits = newVisits;
        this.oldVisits = oldVisits;

        accountVisitEnricher = new AccountVisitEnricher();
    }


    override
    public void afterInsert() {
        enrichAccountWithTotalOfVisits();
    }

    override
    public void afterUpdate() {
        enrichAccountWithTotalOfVisits();
    }

    public void enrichAccountWithTotalOfVisits () {
        Set<String> accountIds = FilterHelper.filterFieldIds('Account__c', newVisits );
        accountVisitEnricher.enrichWithTotalOfVisits( accountIds );
    }

}