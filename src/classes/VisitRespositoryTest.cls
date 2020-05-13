@isTest
public class VisitRespositoryTest {

    @TestSetup
    public static void setup() {
 
    }

    @isTest
    public static void findByAccountTest () {

        Map<String, SObject> records = VisitFixtureFactory.setupFull();

        Account account = (Account) records.get('account-one');

        Test.startTest();

        VisitRespository repository = new VisitRespository();

        List<Visit__c> visits = repository.findByAccount(account.id);

        Test.stopTest();

        System.assert(!visits.isEmpty());
        System.assert(visits.size() == 1 );
        System.assertEquals(account.Id,  visits.get(0).Account__c );

    }

    @isTest
    public static void findByScheduleDateTest () {

        Account account = AccountFixtureFactory.createAccount('One');

        Datetime expected = Datetime.newInstance(2020, 04, 22, 12, 0, 0);

        Visit__c visit = VisitFixtureFactory.createVisit(account
                                        ,  expected );

        Test.startTest();
        
        VisitRespository repository = new VisitRespository();
        
        List<Visit__c> visits = repository.findByScheduleDate(expected);
        
        Test.stopTest();
        
        System.assert(!visits.isEmpty());
        System.assert(visits.size() == 1 );
        System.assertEquals( expected ,  visits.get(0).ScheduleDate__c );

    }

    //BDD
    // given
    // When
    // Then 

    @isTest
    public static void givenNewVisitWhenCreateThisThenChangeAccountToCollectTotalOfVisits () {

        Map<String,SObject> records = VisitFixtureFactory.setupFull();
        
        Account expectedAccount = (Account) records.get('account-one');
        
        Account account = new AccountRepository().findById(expectedAccount.Id);

        System.assert(account != null );
        System.assertEquals(expectedAccount.Id, account.Id );
        System.assert(account.TotalVisits__c == 1 );

    }

    @isTest
    public static void givenSeveralVisitsWhenCreateAllThenChangeAccountToCollectTotalOfVisits () {

        Account expectedAccount = AccountFixtureFactory.createAccount('One');

        Test.startTest();

        List<Visit__c> visits = new List<Visit__c> {
             VisitFixtureFactory.newVisit(expectedAccount, Datetime.newInstance(2020, 04, 22) )
            , VisitFixtureFactory.newVisit(expectedAccount, Datetime.newInstance(2020, 04, 23) )
        };

        VisitFixtureFactory.createVisits(visits);
        
        Test.stopTest();

        Account account = new AccountRepository().findById(expectedAccount.Id);

        System.assert(account != null );
        System.assertEquals(expectedAccount.Id, account.Id );
        System.assert(account.TotalVisits__c == 2 );

    }


    public class VisitRespositoryMock extends VisitRespository {

        String payload;

        public VisitRespositoryMock(String payload) {
            this.payload = payload;
        }

        override
        public List<AggregateResult> findByAccountIds(Set<String> accountIds) {
            return (List<AggregateResult>) JSON.deserialize(payload , List<SObject>.class);
        }

    }


}