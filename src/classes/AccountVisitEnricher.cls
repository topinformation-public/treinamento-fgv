public with sharing class AccountVisitEnricher {

    AccountRepository repository;

    VisitRespository visitRepository;

    public AccountVisitEnricher () {

        repository = new AccountRepository();
        visitRepository = new VisitRespository();
    
    }

    public List<Account> enrichWithTotalOfVisits (Set<String> accountIds) {

        List<Account> accounts = new List<Account>();
        
        List<AggregateResult> aggregatedResults = visitRepository.findByAccountIds(accountIds);
        
        System.debug( JSON.serialize(aggregatedResults) );

        for ( AggregateResult result :  aggregatedResults ) {

            accounts.add ( new Account ( Id = (String) result.get('Account__c')
                                        , TotalVisits__c = (Long) result.get('total') )); 

        }

        repository.save (accounts); // susbstituir pelo repository de account.
        
        return accounts;
    }

    // 4 test injection
    public void setVisitRepository (VisitRespository visitRepository) {
        this.visitRepository = visitRepository;
    }

    // 4 test injection
    public void setAccountRepository (AccountRepository repository) {
        this.repository = repository;
    }

}