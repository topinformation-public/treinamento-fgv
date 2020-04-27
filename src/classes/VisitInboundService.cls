global with sharing class VisitInboundService {

    webservice
    static Visit create (Visit visit) {
        Visit__c visitToCreate = visit.toVisit(); 
        insert visitToCreate;

        visit.id = visitToCreate.Id;

        return visit;
    }

    global class Visit {

        webservice String id;
        webservice String accountId;
        webservice Datetime checkIn;
        webservice Datetime checkout;
        webservice Datetime scheduleDate;

        public Visit__c toVisit () {

            return new Visit__c (
                id = id
                , Account__c = accountId
                , Checkin__c = checkIn
                , Checkout__c = checkout
                , ScheduleDate__c = scheduleDate
            );

        }

    }


}