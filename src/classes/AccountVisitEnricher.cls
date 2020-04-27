public with sharing class AccountVisitEnricher {

    AccountRepository repository = new AccountRepository();

    VisitRespository visitRepository;

    public AccountVisitEnricher () {

        repository = new AccountRepository();
        visitRepository = new VisitRespository();
    
    }

    public List<Account> enrichWithTotalOfVisits (Set<String> accountIds) {

        List<Account> accounts = new List<Account>();
        
        List<AggregateResult> aggregatedResults = visitRepository.findByAccountIds(accountIds);
        
        for ( AggregateResult result :  aggregatedResults ) {

            accounts.add ( new Account ( Id = (String) result.get('Account__c')
                                        , TotalVisits__c = (Long) result.get('total') )); 

        }

        update accounts; // susbstituir pelo repository de account.
        
        return accounts;
    }

}