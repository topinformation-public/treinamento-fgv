public with sharing class GetCitiesCtrl {

    @AuraEnabled (cacheable=true)
    public static List<City> findCitiesByState( String state ){
        return new GetCitiesOutboundService().findCitiesByState(state);
    }

}