@isTest
public class AccountVisitEnricherTest {

    // BDD
    // given
    // when 
    // then
    @isTest
    public static void givenSomeVisitsThenEnrichAccount () {

        String visitAggregatedResultsPayload = '[{"attributes":{"type":"AggregateResult"}, "Account__c":"0015w000028rlZ6AAI","total":1}, {"attributes":{"type":"AggregateResult"}, "Account__c":"0015w000028rlZ4AAI","total":4}]';

        AccountVisitEnricher enricher = new AccountVisitEnricher();
        enricher.setVisitRepository( new VisitRespositoryTest.VisitRespositoryMock(visitAggregatedResultsPayload) );
        enricher.setAccountRepository( new AccountRepositoryMock('[{"id":"0015w000028rlZ6AAI", "TotalVisits__c" : 1}, {"id" : "0015w000028rlZ4AAI", "TotalVisits__c" : 4}]') );
                
        Set<String> accountIds = new Set<String> {'0015w000028rlZ6AAI','0015w000028rlZ4AAI'};

        List<Account> accounts = enricher.enrichWithTotalOfVisits(accountIds);

        System.assert ( !accounts.isEmpty() );
        System.assert ( accounts.get(0).TotalVisits__c == 1 );
        System.assert ( accounts.get(1).TotalVisits__c == 4 );

    }

    public class AccountRepositoryMock extends AccountRepository {

        String payload;

        public AccountRepositoryMock (String payload) {
            this.payload = payload;
        }

        override
        public List<Account> save (List<Account> accounts) {
            return (List<Account>) JSON.deserialize(payload, List<Account>.class);
        }

    } 


}