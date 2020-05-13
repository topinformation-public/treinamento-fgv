public class GetZipCodeAddressCtrl {


    @AuraEnabled
    public static ZipCodeAddress findAddressByZipCode (String zipCode) {

        GetAddressOutboundService service = new GetAddressOutboundService();
        return service.getAddress(zipCode);
        
    }


}