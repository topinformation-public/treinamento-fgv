/**
 * How to Use
 *
 * Create Concrete Class extending AbstractInboundService and overriging eventHandler, setEventPayload methods by default.
 *
 * global CreateSalesOrderInboundService extends AbsractInboundService {
 *     //
 *     public CreateSalesOrderInboundService (EventQueue event, Order order) {
 *         super (event);
 *         this.order = order;
 *     }
 *
 *     override
 *     public void handleEvent() {
 *          //implement your logic here.
 *     }
 *
 *     override
 *     public void setEventPayload() {
 *         event.setPayload ( JSON.serialize (order) );
 *     }
 *
 *     webservice
 *     public static void create (EventQueue event, Order order) {
 *         CreateSalesOrderInboundService service = new CreateSalesOrderInboundService(event,contract);
 *         service.execute();
 *     }
 * }
 *
 * @author: Eduardo Ribeiro de Carvalho
 *
 */
public abstract class AbstractInboundService implements InboundService {

    protected EventQueue event;

    public AbstractInboundService () {
    }

    public AbstractInboundService (EventQueue event) {
        this();
        this.event = event;
    }

    virtual
    public void execute() {

        try {

            setEventPayload();

            event.save();

            handleEvent();

            event.successfullyProcessedEvent();

        } catch (DmlException e) {

            event.errorProcessingEvent(e);

        } catch (Exception e) {

            event.errorProcessingEvent(e);

        } finally {

            event.save();

        }
    }

    public EventQueue getEvent() {
        return event;
    }

    public abstract void handleEvent();

    public abstract void setEventPayload();

}