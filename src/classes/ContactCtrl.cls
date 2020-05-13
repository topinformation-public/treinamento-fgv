public with sharing class ContactCtrl {

    @AuraEnabled
    public static List<Contact> findContacts () {
        return [ SELECT Id, FirstName, LastName, Email, AccountId 
                FROM Contact order by lastModifiedDate desc ];
    }

}