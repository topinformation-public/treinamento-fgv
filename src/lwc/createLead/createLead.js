import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import findByDocumentNumber from '@salesforce/apex/LeadCtrl.findLeadByDocumentNumber';
 
export default class CreateLead extends LightningElement {

    leadId;

    @track lead = {
        FirstName : '',
        LastName  : ''
    };

    handleSubmit(event){
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        fields.Company = '32 Prince Street';
        this.template.querySelector('lightning-record-edit-form').submit(fields);
     }

     handleDocumentNumber (event) {

        findByDocumentNumber({documentNumber : event.target.value}).then(response =>{
            this.leadId = response.Id;
        });

     }

     handleSuccess (event) {
        this.leadId = event.detail.id; 

        console.log( 'handleSuccess ' + this.leadId );

        const toastEvent = new ShowToastEvent({
            title: "Success",
            variant : "success",
            message : "Lead Criado com Sucesso {0} ",
            messageData : [ this.leadId ]
        });

        this.dispatchEvent(toastEvent);

     }


}