import { LightningElement, api, track } from 'lwc';

export default class ErrorPanel extends LightningElement {

    @api errorTitle;

    @track viewDetails = false;

    @api errorMessage;

    @api actionMessage;

    constructor () {

        super();

        this.errorTitle = ':/ Opss... serviço fora do ar!';
        this.errorMessage = 'No momento o serviço necessário para completar esta etapa está fora do ar.';
        this.actionMessage = 'Tente novamente mais tarde.';

    }

    handleCheckboxChange(event) {
        this.viewDetails = event.target.checked;
    }

    handleDialogClose() {
        const closeModalEvent = new CustomEvent('closemodal', {});
        this.dispatchEvent(closeModalEvent);
    }
}