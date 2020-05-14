import { LightningElement, track } from 'lwc';
import findLeadByDocument from '@salesforce/apex/LeadCtrl.findLeadByDocumentNumber';

export default class Enrollment extends LightningElement {

    @track enrollment;

    @track courses;

    loading = false;

    constructor () {
        super();
 
        this.enrollment = {
              name : ""
            , documentNumber : ""
            , phone : ""
            , email : ""
            , course : {
                code : ""
                , name : ""
                , date : ""
            }
            , address : {
                zipCode : ""
                , street : ""    
                , streetNumber : ""    
                , streetAdditionalInfo : ""    
                , city : ""
                , state : ""
            }
        };
    }

    connectedCallback () {
    }


    renderedCallback () {
    }

    handleChange (event) {
        this.enrollment[event.target.name] = event.target.value;
    }

    handleDocument (event) {    

        this.enrollment.documentNumber = event.target.value;
        
        this.loading = true;

        findLeadByDocument({documentNumber : event.target.value }).then (response =>{
            this.enrollment.name = response.Name;
            this.enrollment.documentNumber = response.DocumentNumber__c;
            this.enrollment.phone = response.Phone;
            this.enrollment.email = response.Email;
            this.enrollment.address.street = response.Street;
            this.enrollment.address.zipCode = response.PostalCode;
            this.enrollment.address.city = response.City;
            this.enrollment.address.state = response.State;
        }).finally(() => {
            this.loading = false;
        });
    }

    handleCreate (event) {

        if (!this.validateAll()) return;

    }

    validateAll () {
       return this.validateLocalFields () || this.validateComponents ();
    }

    validateLocalFields () {
        let valid = true;
        this.template.querySelectorAll(".validable").forEach ( element => {
            if ( !element.checkValidity () ) {
                element.reportValidity();
                valid = false;
            }   
        });
        return valid;
    }


    validateComponents () {
        let valid = true;
        this.template.querySelectorAll(".component-validable").forEach ( element => {
            valid = element.validateAll ();    
        });
        return valid;
    }

}