public with sharing class SalesPriceService {

    public PriceService service;

    public SalesPriceService () {
        
    }

    public SalesPriceService ( PriceService service) {
        this.service = service;
    }

    public PriceList applyPolice () {
        return convertToPriceList ( service.applyPolice() );
    }

    public PriceList convertToPriceList (Object police) {

        return new PriceList ();

    }
    
    public class PriceList {

    }

}