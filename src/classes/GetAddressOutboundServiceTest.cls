@isTest
public class GetAddressOutboundServiceTest {

    @isTest
    public static void getZipCodeTest () {

        String payload = '{ "cep": "12227-660", "logradouro": "Rua Uiramiris", "complemento": "", "bairro": "Jardim Uirá", "localidade": "São José dos Campos", "uf": "SP", "unidade": "", "ibge": "3549904", "gia": "6452" }';

        Test.setMock( HttpCalloutMock.class,  new GetAddressOutboundServiceSuccessMock(payload) );
        
        Test.startTest();
        
        GetAddressOutboundService service = new GetAddressOutboundService();
        
        Account account = service.getAddressFromZipCode('0015w000028rlZ3AAI', 'xxxxx');
    
        Test.stopTest();

        System.assert( account.id == '0015w000028rlZ3AAI' );
        System.assert( account.BillingPostalCode == '12227-660' );
    }


    public class GetAddressOutboundServiceSuccessMock implements HttpCalloutMock {

        public String payload;

        public GetAddressOutboundServiceSuccessMock (String payload) {
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request) {

            HttpResponse response = new HttpResponse();
            response.setStatus('OK');
            response.setStatusCode(200);
            response.setBody(payload);
            return response;
        }

    }

    public class GetAddressOutboundServiceErrorMock implements HttpCalloutMock {

        public String payload;

        public GetAddressOutboundServiceErrorMock (String payload) {
            this.payload = payload;
        }

        public HttpResponse respond (HttpRequest request) {

            HttpResponse response = new HttpResponse();
            response.setStatus('ERROR');
            response.setStatusCode(400);
            response.setBody(payload);
            return response;
        }

    }

}