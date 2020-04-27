public class VisitRespository {

    public List<Visit__c> findAll () {
        return  [ SELECT Id, Name, ScheduleDate__c
        , Account__c, Account__r.Name
        , Lead__c, Lead__r.Name, Checkin__c, Checkout__c
        , Rescheduled__c 
        FROM Visit__c];
    }

    public List<Visit__c> findByAccount (String accountId) {
        return  [ SELECT Id, Name, ScheduleDate__c
        , Account__c, Account__r.Name
        , Lead__c, Lead__r.Name, Checkin__c, Checkout__c
        , Rescheduled__c 
        FROM Visit__c WHERE Account__c =: accountId];
    }


    public List<AggregateResult> findByAccountIds (Set<String> accountIds) {
        return  [ SELECT Account__c , COUNT (Id) total
            FROM Visit__c 
            WHERE Account__c in : accountIds  GROUP BY Account__c ];
    }

    public List<Visit__c> findByScheduleDate (Datetime scheduleDate) {
        return [ SELECT Id, Name, ScheduleDate__c
            , Account__c, Account__r.Name
            , Lead__c, Lead__r.Name, Checkin__c, Checkout__c
            , Rescheduled__c 
            FROM Visit__c WHERE  day_only(ScheduleDate__c) = :scheduleDate.date() ];
    }

}