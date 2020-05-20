import { LightningElement, api, track, wire } from 'lwc';

import findCitiesByState from '@salesforce/apex/GetCitiesCtrl.findCitiesByState';

export default class Cities extends LightningElement {

    @api state;

    @api city;

    @api required;

    @api label;

    @api disabled;

    @track selectedCity;

    @track cities = [];

    connectedCallback () {
        console.log ('connectedCallback -------- Cities');
        this.selectedCity = Object.assign ({}, this.city);
    }

    renderedCallback () {
        console.log ('renderedCallback -------- Cities');
        console.log ('renderedCallback -------- ' + this.state );
        console.log ('renderedCallback -------- ' + this.city );
    }

    handleChange(event){
        this.selectedCity = event.target.value;
        this.dispatchSelectedCity();
    }

    @wire ( findCitiesByState, { state : '$state' } )
    findCities ({error,data}) {

        console.log (data);

        if (!data) return;

        this.cities = [];

        for ( let i = 0; i < data.length; i++ ) {
            this.cities.push ( { label : data[i].name, value : data[i].name } );
        }
    
    }

    dispatchSelectedCity () {
        const selectedEvent = new CustomEvent ( 'selectedcity', {
            detail : { city : this.selectedCity }
        });
        this.dispatchEvent (selectedEvent);
    }

    @api
    validateAll () {

       let isValid = true;
       this.template.querySelectorAll(".component-validable").forEach ( element => {
            if (!element.checkValidity() ) {
                element.reportValidity();
                isValid = false; 
            }
        });
        return isValid;
    }

}