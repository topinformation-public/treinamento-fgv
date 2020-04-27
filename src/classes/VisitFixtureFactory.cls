@isTest
public class VisitFixtureFactory {

    public static Visit__c newVisit (Account account, Datetime scheduleDate) {
        return  new Visit__c ( Account__c = account.Id
            , ScheduleDate__c = scheduleDate);
    }

    public static Visit__c createVisit (Account account, Datetime scheduleDate) {
        return createVisit( newVisit ( account , scheduleDate));
    }

    public static Visit__c createVisit (Visit__c visit) {
        return createVisits ( new List<Visit__c> {visit} ).get(0);
    }

    public static List<Visit__c> createVisits (List<Visit__c> visits) {
        insert visits;
        return visits;
    }

    public static Map<String, SObject> setupFull () {

        Map<String, SObject> records = new Map<String, SObject>();
        
        Account account = AccountFixtureFactory.createAccount('One');

        records.put( 'account-one' , account);
        
        Visit__c visit = VisitFixtureFactory.createVisit(account, Datetime.newInstance(2020, 04, 22));
        
        records.put( 'visit' , visit);
                                        
        return records;
    } 



}