public with sharing class ContactPdfCtrl {

    public Contact contact;

    public List<Contact> contacts {get;set;}

    public ContactPdfCtrl (  ) {
        contact = new Contact();
    }

    public ContactPdfCtrl ( ApexPages.StandardController standardController  ) {

        SObject record = standardController.getRecord();
        contact = (Contact) record;
        
        loadContacts();
    }


    public void loadContacts () {
        this.contacts = [Select Id, FirstName, LastName, Email from Contact];
    }

    public Contact getContact () {
        return this.contact;
    }

    public void setContact (Contact contact) {
        this.contact = contact;
    }

    public Pagereference save () {
        return null;
    }

}