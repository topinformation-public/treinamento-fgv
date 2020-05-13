public with sharing class ExploreCustomAccountController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts (String searchText) {
        searchText = '%' + searchText + '%';
        return [ SELECT id, name, accountNumber from Account where name like :searchText limit 10 ];
    }

}