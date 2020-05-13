import { LightningElement, track} from 'lwc';
 
export default class Address extends LightningElement {

    @track address;

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
    }

    renderedCallback () {
        console.log ('renderedCallback -------- Address');
    }


    handleAddressFound (event) {

        this.address = Object.assign ( {} , event.detail.address);

    }

    handleChange (event) {
        this.address[event.target.name] = event.target.value;
    }

}