public class ZipCodeAddress {

    @AuraEnabled
    public String street {get;set;}
    
    @AuraEnabled
    public String streetNumber {get;set;}
    
    @AuraEnabled
    public String streetAdditionalInfo {get;set;}
    
    @AuraEnabled
    public String zipCode {get;set;}
    
    @AuraEnabled
    public String city {get;set;}
    
    @AuraEnabled
    public String state {get;set;}

}