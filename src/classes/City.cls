public with sharing class City {
    
    @AuraEnabled
    public Long id {get;set;}

    @AuraEnabled
    public String name {get;set;}

    public City () {
    }

    public City (Long id, String name) {
        this.id = id;
        this.name = name;
    }

    public static List<City> toCity (List<IbgeCityResponse> ibgeCities) {

        List<City> cities = new List<City>();

        for ( IbgeCityResponse ibgeCity : ibgeCities ) {

            cities.add ( new City (ibgeCity.id, ibgeCity.nome) );

        }

        return cities;

    }


}