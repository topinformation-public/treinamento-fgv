global class CustomerLatLongJob implements Schedulable {

    global void execute (SchedulableContext context) {
        findAccountWithoutGeoLocation();
    }

    public List<Account> findAccountWithoutGeoLocation () {

        List<Account> accounts = [ SELECT Id
            FROM Account 
            WHERE BillingLatitude = null
            AND BillingLongitude = null LIMIT 10 ];

        System.debug( JSON.serialize(accounts) );

        sendAccountToGenerateLatLong( FilterHelper.filterFieldIds('Id', accounts)  );
        
        return accounts;
    }

    @future (callout=true)
    public static void sendAccountToGenerateLatLong ( Set<String> accountIds ) {

        List<Account> accounts = [ SELECT Id, BillingLatitude, BillingLongitude
        FROM Account 
        WHERE Id in : accountIds ];

        System.debug( JSON.serialize(accounts) );

    }

}