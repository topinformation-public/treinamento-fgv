public class ViaCepZipAdress {

    public String cep; 
    public String logradouro; 
    public String complemento; 
    public String bairro; 
    public String localidade; 
    public String uf; 
    public String unidade; 
    public String ibge; 
    public String gia; 

    public Account toAccount (String accountId) {
        Account account = new Account( Id = accountId );
        account.BillingStreet = logradouro + ' ' + complemento;
        account.BillingPostalCode = cep;
        account.BillingCity = localidade;
        account.BillingState = uf;
        return account;
    }

    public ZipCodeAddress toZipCodeAddress () {
        ZipCodeAddress address = new ZipCodeAddress();
        address.street = logradouro ;
        address.streetAdditionalInfo = complemento;
        address.state = uf;
        address.city = localidade;
        address.zipCode = cep;
        return address;
    }


}