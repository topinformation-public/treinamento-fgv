import { LightningElement, api} from 'lwc';
 
export default class Address extends LightningElement {

    @api address;

    constructor () {
        super();
        console.log ('constructor -------------- Address');
        
        this.address = {
            zipCode : ''
            , street : ''    
            , streetNumber : ''    
            , streetAdditionalInfo : ''    
            , city : ''    
            , state : ''    
        };
    
    }
    
    connectedCallback () {
        console.log ('connectedCallback -------- Address');
        this.address = Object.assign ( {} , this.address);
    }

    renderedCallback () {
        console.log ('renderedCallback -------- Address');
    }


    handleAddressFound (event) {

        this.address = Object.assign ( {} , event.detail.address);
        console.log ('handleAddressFound  -------- ' + JSON.stringify(this.address));
    }

    handleChange (event) {
        console.log ('handleChange  -------- ' + event.target.value);
        this.address[event.target.name] = event.target.value;
        console.log ('handleChange  -------- ' + JSON.stringify(this.address));
    }

    handleStateSelected (event) {
        this.address.state = event.detail.state;
        console.log ('handleStateSelected  -------- ' + JSON.stringify(this.address));
    } 

    handleCitySelected (event) {
        this.address.city = event.detail.city;
        console.log ('handleCitySelected  -------- ' + JSON.stringify(this.address));
    }   

    @api 
    validateAll () {
        return this.validateLocalFields () || validateComponents();
    }
    
    validateComponents () {

       let isValid = true;
       this.template.querySelectorAll(".component-validable").forEach ( element => {
                isValid = element.validateAll();
        });
        return isValid;
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

}