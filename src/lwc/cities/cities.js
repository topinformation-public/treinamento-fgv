import { LightningElement, api, track } from 'lwc';

//import findCitiesByState from '@salesforce/apex/CitiesCtrl.findCitiesByState';

export default class Cities extends LightningElement {

    @api city;

    @api required;

    @api label;

    @api disabled;

    @track selectedCity;

    connectedCallback () {
        console.log ('connectedCallback -------- Cities');
        this.selectedCity = Object.assign ({}, this.city);
    }

    renderedCallback () {
        console.log ('renderedCallback -------- Cities');
    }

    handleChange(event){
    }

    findCities () {

    }

    dispatchSelectedCities (event) {

    }

}