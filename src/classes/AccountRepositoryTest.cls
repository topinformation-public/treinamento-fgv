@isTest
public class AccountRepositoryTest {

    @TestSetup
    public static void setup() {

    }
    
    @isTest
    public static void findByNameTest () {

        Account account = AccountFixtureFactory.createAccount('One');

        AccountRepository repository = new AccountRepository();

        String expectedName = 'One';

        List<Account> accounts = repository.findByName(expectedName);

        System.assert( !accounts.isEmpty() );
        System.assert( accounts.size() == 1 );
        System.assertEquals( expectedName, accounts.get(0).Name) ;

       
        
    }


    
}