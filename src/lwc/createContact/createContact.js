import { LightningElement, api, track, wire} from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent'

export default class CreateContact extends LightningElement {

    @api contact = {};

    contactId;

    connectedCallback() {
    }

    recordCreated (event) {
        
        this.contactId = event.detail.id;

        console.log ('recordCreated' + event.detail.id);

        this.dispatchContactChanged ();
        
        const toastEvent = new ShowToastEvent({
            title: 'Contact Changed',
            message: 'Contact Successful Changed'
        });

        this.dispatchEvent(toastEvent);
        



    }

    dispatchContactChanged () {
        const changedEvent = new CustomEvent ( 'contactchanged' , {
             detail : { contactId : this.contactId } 
        }); 
        this.dispatchEvent (changedEvent);
    }


}