/**
 * @author ercarval
 */
public class IntegrationException extends Exception {

	public IntegrationException (HttpResponse httpResponse) {
		this ( httpResponse.getStatusCode() + ' : ' +  httpResponse.getStatus() + ' [ '+ httpResponse.getBody()  +' ] ' );
	}


}