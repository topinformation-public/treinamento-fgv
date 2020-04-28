// Add URL remote settings
public class GetAddressOutboundService extends AbstractRestOutboundService {

    public Account getAddressFromZipCode ( String accountId, String zipCode) {

        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://viacep.com.br/ws/' + zipCode + '/json/');
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('GET');

        Http http = new Http();
        HttpResponse response = http.send(request);

        System.debug( response.getStatus() );
        System.debug( response.getStatusCode() );
        System.debug( response.getBody() );

        ViaCepZipAdress zipAddress = (ViaCepZipAdress) JSON.deserialize( response.getBody() , ViaCepZipAdress.class);

        return zipAddress.toAccount(accountId);
    }


    public Account getAddress (String accountId, String zipCode) {
        
        setup(buildEvent(accountId, zipCode));

        ViaCepZipAdress address;

        try {
        
            String response = get(  zipCode + '/json/');
        
            address = (ViaCepZipAdress) processResult(response);
            
            return address.toAccount(accountId);
        
        } catch (Exception e) {
            // do nothing
        } finally  {
            publishEventLog();
        }

        return null;
    }

    override
    public Object processResult(String response) {
        return JSON.deserialize( response, ViaCepZipAdress.class);
    }

    public EventQueue buildEvent (String accountId, String zipCode) {

        return new EventBuilder().createSynchronousOutboundEvent('GET_ADDRESS_OUTBOUND')
                    .forObjectId(accountId)
                    .withReceiver('GATEWAY')
                    .withBusinessDocumentNumber (zipCode)    
                    .buildEvent();

    }


}