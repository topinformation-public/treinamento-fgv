import { LightningElement, api } from 'lwc';
 
export default class Modal extends LightningElement {

    @api title;

    @api closeLabel;

    handleDialogClose() {
        this.dispatchEvent(new CustomEvent('closemodal', {}));
    }

}