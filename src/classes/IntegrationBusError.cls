public with sharing class IntegrationBusError {
    public String cod;
    public String message;
    public String mensagem;

    public IntegrationBusError() {
    }

    public IntegrationBusError(String cod, String message ) {
        this.cod = cod;
        this.message = message;
    }

    public boolean isEmpty () {
        return message == null || cod == null;
    }

}