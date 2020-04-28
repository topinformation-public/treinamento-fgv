public with sharing class LeadRepository {

    public Lead findById (String id) {
        return [ SELECT id, Name, Phone
                , ( SELECT id, Name, startDate__c, endDate__c, ammount__c from Courses__r) 
            FROM Lead
            WHERE id = :id ];
    }

    public Lead save (Lead lead) {
        if (lead.id == null) {
            insert lead;
        } else {
            update lead;
        }
        return lead;
    }        
    
}