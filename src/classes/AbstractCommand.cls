/**
 * Provide template method for ICommand executions
 *
 * How to Use 
 *   	
 *  class PurchaseApprovedCommand extends AbstractCommand {
 *		private Order salesOrder;
 *		
 *      // rewrite init method to initialize attributes	
 *      override
 *		public void init (EventQueue event) {
 *			super.init(event);
 *			salesOrder = (Order) event.getPayloadFromJson( Order.class ); 
 *		}
 *		
 *      // principal execution method
 *		public void execute () {
 *			// implement you logic here
 *		}
 *
 *  } 
 * 
 * @author: ercarval
 */
public abstract with sharing class AbstractCommand implements ICommand {

	protected EventQueue event;

	public AbstractCommand() {	
	}

	/**
	 * Template execution for default actions 
	 */
	public void execute(EventQueue event) {
	
		init(event);

		preExecute();

		execute();

		postExecute();

	}	

	virtual
	protected void init (EventQueue event) {
		this.event = event;
	}

	/**
	 * Decorate execution process
	 */ 
	virtual
	public void preExecute(){
	}

	/**
	 * Decorate execution process
	 */
	virtual
	public void postExecute(){
	}


	public abstract void execute();

}