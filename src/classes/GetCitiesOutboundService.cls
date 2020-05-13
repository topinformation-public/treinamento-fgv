
/**
 * 
 */
public class GetCitiesOutboundService extends AbstractRestOutboundService {

    public GetCitiesOutboundService () {
        super();
    }

    public List<City> findCitiesByState (String state) {

        return City.toCity( findCities (state));

    }

    public List<IbgeCityResponse> findCities (String state) {

        setup( buildEvent(state) );

        return (List<IbgeCityResponse>) processResult( get ( state + '/distritos' ) );
        
    }

    override
    public Object processResult(String response) {
        return JSON.deserialize( response , List<IbgeCityResponse>.class);
    }

    public EventQueue buildEvent (String state) {

        return new EventBuilder().createSynchronousOutboundEvent('GET_CITIES_OUTBOUND')
                        .withReceiver('IBGE')
                        .withSameDocumentNumberForAllIdentifiers(state)    
                        .buildEvent();
        
    }


}