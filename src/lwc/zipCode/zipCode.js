import { LightningElement, api, track} from 'lwc';

import findAddressByZipCode from '@salesforce/apex/GetZipCodeAddressCtrl.findAddressByZipCode';
 
export default class ZipCode extends LightningElement {

    @api zipCode;

    @track _zipCode;

    @api label;

    @api required;

    @api disabled;

    constructor () {
        super();
        console.log ('constructor -------------- ZipCode');
        this.label = 'CEP';
    }
    
    connectedCallback () {
        console.log ('connectedCallback -------- ZipCode');
        this._zipCode = Object.assign ({}, this.zipCode);
    }

    renderedCallback () {
        console.log ('renderedCallback -------- ZipCode');
    }

    handleChanged (event) {
        console.log (event.target.value);

        event.target.value = this.format (event.target.value);
        
        if (event.target.value && event.target.value.length == 9) {
            this._zipCode = event.target.value;
            this.findAddress(this._zipCode);
        }

    }

    findAddress (_zipCode) {

        findAddressByZipCode({zipCode : _zipCode}).then ( response => {
            let address = response;
            this.dispatchAddressFound (address);
        }).catch (error => {
            console.log (JSON.stringify(error));
        });

    }

    dispatchAddressFound (_address) {

        const event = new CustomEvent ('addressfound', {
            detail : {address : _address}
        });

        this.dispatchEvent (event);

    }

    format(value) {
        if (!value) return ''; 
        return value.replace(/(\d{5})(\d)/,"$1-$2");
    }

}