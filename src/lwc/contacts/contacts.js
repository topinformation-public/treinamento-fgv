import { LightningElement, track } from 'lwc';

import findContacts from '@salesforce/apex/ContactCtrl.findContacts';
 
const dataTableColumns = [
    { label: 'AccountId', fieldName: 'AccountId' },
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Email', fieldName: 'Email' }
];

export default class Contacts extends LightningElement {

    @track contacts = [];

    columns = dataTableColumns;

    @track selectedRows = [];

    @track contact;

    connectedCallback() {
        this.loadContacts ();
    }

    loadContacts () {

        findContacts().then (response => {
            this.contacts = response; 
        }).catch (error => {
            console.log (JSON.stringify(error));
        })

    }

    handleRowsSelected (event) {
        console.log (event.detail.selectedRows);
        this.contact = event.detail.selectedRows[0];
    }

    handleContactChanged (event) {
        
        console.log('event' + JSON.stringify(event.detail));

        this.contact = null;

        this.selectedRows = [];

        this.loadContacts ();
    
    }

}