public class IntegrationBusinessException extends Exception {


	public IntegrationBusinessException (IntegrationBusError e) {
		this (e.message);
	}



}