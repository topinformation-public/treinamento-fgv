/**
 * https://na172.salesforce.com/services/apexrest/api/visit
 * 
 * <url-org>/services/apexrest/api/visit
 */
@RestResource (urlMapping = '/api/visit')
global with sharing class VisitCtrl {

    @HttpGet
    global static List<Visit__c> findAll () {
        VisitRespository repository = new VisitRespository();
        return repository.findAll();
    }

    @HttpPost
    global static Visit__c create (Visit__c visit) {
        
        insert visit;
        return visit;
    }


}