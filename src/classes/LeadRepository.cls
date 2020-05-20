public virtual with sharing class LeadRepository {

    public Lead findById (String id) {
        return [ SELECT id, Name, Phone
                , ( SELECT id, Name, startDate__c, endDate__c, ammount__c from Courses__r) 
            FROM Lead
            WHERE id = :id ];
    }

    public virtual Lead findByDocumentNumber (String documentNumber) {

        return [ SELECT Id, Name, FirstName, LastName, Email, Phone, DocumentNumber__c
        , Street, State, PostalCode, City
            FROM Lead WHERE DocumentNumber__c =:documentNumber 
            Order by CreatedDate desc LIMIT 1];
    } 

    public virtual Lead save (Lead lead) {
        if (lead.id == null) {
            insert lead;
        } else {
            update lead;
        }
        return lead;
    }        
    
}