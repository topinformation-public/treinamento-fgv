/**
 * @author ercarval - Topi
 */
public class ZipCodeOutboundCommand  extends AbstractOutboundCommand {

    public ZipCodeOutboundCommand() {
    }


    override
    public Object send  () {

        String zipCode = this.event.getObjectId();

        zipCode = zipCode.replaceAll('[^0-9]+', '');

        return this.proxy.get (  zipCode + '/json/' );

    }

    override
    public void processResult (Object responseObject) {
    }

    override
    public Object transformToSend () {
        return '';
    }

    public static EventQueue enqueue (String zipCode) {
        return new EventBuilder().createEventFor ('GET_ADDRESS_INFO')
               .withSender('SALESFORCE')
               .withReceiver ('VIACEP')
               .forObjectId(zipCode)
               .withBusinessDocumentNumber (zipCode)
               .withBusinessDocumentCorrelatedNumber (zipCode)
               .buildAndSave();
    }

    public class ViaCepAddress {

        public String cep;
        public String logradouro;
        public String complemento;
        public String bairro;
        public String localidade;
        public String uf;
        public String unidade;
        public String ibge;
        public String gia;

        public boolean erro;
    }



}