import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'
import { NavigationMixin } from 'lightning/navigation';
import { loadScript } from 'lightning/platformResourceLoader';
import moment from '@salesforce/resource/moment';

import findLeadByDocument from '@salesforce/apex/LeadCtrl.findLeadByDocumentNumber';
import create from '@salesforce/apex/LeadCtrl.create';
import { build } from "./builder";

export default class Enrollment extends NavigationMixin(LightningElement) {

    @track enrollment;

    @track courses;

    loading = false;

    showModal = false;

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
    
        this.courses = [
            {label : "Pós Graduação - TI", value : "00001"},
            {label : "Pós Graduação - Comércio Exterior", value : "00002"}
        ]
    }

    connectedCallback () {

        loadScript(this, moment).then( () => {
        }).catch(error => {
            this.error = error;
        });

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

        create( build(this.enrollment)).then( response => {
            
            this[NavigationMixin.Navigate]( {
                type: 'standard__recordPage',
                attributes: {
                    recordId: response.Id,
                    actionName: 'view',
                }
            });

        }).catch (error => {

            const toastEvent = new ShowToastEvent({
                title: "Error",
                variant : "error",
                message : "Não foi possível criar o lead {0} ",
                messageData : [ error.message ]
            });

        }) ;

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

    openModal (event) {
        this.showModal = true;
    }

    closeModal(event) {
        this.showModal = false;
    }

    handleCourseSelected (event) {
        console.log(event.detail.course);
        this.enrollment.course = Object.assign ({}, event.detail.course);
        this.closeModal();
    }

}