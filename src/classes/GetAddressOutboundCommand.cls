public class GetAddressOutboundCommand extends AbstractUpdateableOutboundCommand  {

    ViaCepZipAdress zipAddress;
    AccountRepository repository;

    public GetAddressOutboundCommand () {
        repository = new AccountRepository();
    }

    override
    public Object transformToSend () {
        return event.getBusinessDocumentNumber();
    }

    override
    public Object send  () {

        event.log( 'Target Object' +  targetObject);

        return proxy.get( targetObject + '/json' );
    }

    override
    public void processResult (Object responseObject) {
        zipAddress = (ViaCepZipAdress) JSON.deserialize( (String) responseObject, ViaCepZipAdress.class );
    }

    override
    public void postUpdateExecute() {

        repository.save (zipAddress.toAccount(event.getObjectId()));

    }
}