import { LightningElement } from 'lwc';

import { subscribe, onError, setDebugFlag } from 'lightning/empApi';


export default class QueueErrors extends LightningElement {

    connectedCallback() {
        this.errorSubscription();
    }

    errorSubscription () {

        // Callback invoked whenever a new event message is received
        const messageCallback = function(response) {
            console.log('New message received : ', JSON.stringify(response));
        };

        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe('/topic/Queue__c', -1, messageCallback).then(response => {
            console.log('Successfully subscribed to : ', JSON.stringify(response.channel));
            this.subscription = response;
        });

    }


}