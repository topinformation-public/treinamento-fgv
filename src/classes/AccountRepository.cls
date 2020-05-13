/**
 * @author ercarval - Topi
 */
public virtual with sharing class AccountRepository {

    public List<Account> findByName (String name) {

        return  [ SELECT Id, Name FROM Account WHERE Name = :name ];
        
    }

    public Account findById (String id) {
        
        List<Account> accounts = [ SELECT Id, Name, TotalVisits__c FROM Account WHERE Id = :id ];
        
        return !accounts.isEmpty() ? accounts.get(0) : null;

    }

    virtual
    public Account save (Account account) {
        
        if (account.Id == null) {
            insert account;
        } else {
            update account;
        }

        return account;
    }

    virtual
    public List<Account> save (List<Account> accounts) {
        update accounts;
        return accounts;
    }

}