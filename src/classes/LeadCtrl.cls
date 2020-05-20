
public with sharing class LeadCtrl {

    public static LeadRepository repository;

    static {
        repository = new LeadRepository();
    }

    @AuraEnabled
    public static Lead findLeadByDocumentNumber(String documentNumber) {
        return repository.findByDocumentNumber(documentNumber);
    }   

    @AuraEnabled
    public static Lead create (Lead lead) {

        insert lead;

        return lead;
    }

}