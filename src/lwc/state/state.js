import { LightningElement, api, track } from 'lwc';
 
export default class State extends LightningElement {

    @api state;

    @api required;

    @api label;

    @api disabled;

    @track selectedState;

    @track states = [];

    constructor () {
        super();

        this.states = [
            {value: "SP" , label: "São Paulo"},
            {value: "RJ" , label: "Rio de Janeiro"}
        ];

    }

    connectedCallback () {
        console.log ('connectedCallback -------- State');
        this.selectedState = Object.assign({}, this.state);
    }

    renderedCallback () {
        console.log ('renderedCallback -------- State');
    }

    handleChange (event) {

        this.selectedState = event.target.value;
        this.dispatchStateSelected ();
    }

    dispatchStateSelected () {
        const event = new CustomEvent ('stateselected', {
            detail : { state: this.selectedState } 
        });
        this.dispatchEvent (event);
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