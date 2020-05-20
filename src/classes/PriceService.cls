public with sharing class PriceService implements PricePolice {

    Map<String, PricePolice> policies = new Map<String, PricePolice> {

         'STANDARD' => new StandardPrice ()
         ,'CLAM'    => new ClamPolicy ()
         ,'SERVICE' => new ServicePolice ()
         
    };

    String serviceType;

    public PriceService () {
    }

    public Object applyPolice () {
        return policies.get (serviceType).applyPolice();
    }

}