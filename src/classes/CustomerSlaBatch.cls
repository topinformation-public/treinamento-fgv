global class CustomerSlaBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start( Database.BatchableContext context) {
        return Database.getQueryLocator('Select id, ShippingPostalCode from account');
    }

    global void execute (Database.BatchableContext context , List<SObject> records ) {

        List<Account> accounts = ( List<Account> ) records;
        
        System.debug( JSON.serialize(accounts) );

        Integer i = 0;
        
        for (Account account : accounts ) {
            account.ShippingPostalCode = 'PST' + (++i);
        }

        update accounts;

    }

    global void finish (Database.BatchableContext context) {
        System.debug('Finish ' + JSON.serialize(context) );

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setToAddresses( new String[] { 'ercarval@gmail.com', 'eduardo.carvalho@topi.io'} );
        message.setSubject( 'Job SLA [ ' + context.getJobId() + '] Encerrado'  );
        message.setPlainTextBody( 'Fechou !!! '  );

        Messaging.sendEmail( new Messaging.SingleEmailMessage[] {message}  );

    }


}