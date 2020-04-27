/**
 * Provide template method for AbstractOutboundCommand and IUpdatableCommmads
 * @author: ercarval - topi
 */
public abstract class AbstractUpdateableOutboundCommand extends AbstractOutboundCommand implements IUpdatableCommmad {

    public AbstractUpdateableOutboundCommand() {
        super ();
    }

    virtual
    public void postUpdateExecute(EventQueue event) {

        if (acceptPostExecution()) return;

        Savepoint sp = Database.setSavepoint();

        try {

            postUpdateExecute();

        } catch (DmlException e) {

            Database.rollback(sp);
            throw e;

        } catch (Exception e) {
            Database.rollback(sp);
            throw e;
        }

    }

    virtual
    public boolean acceptPostExecution () {
        return this.event.hasError() || !accept();
    }

    /**
     * use this method to execute dml operations
     */
    public abstract void postUpdateExecute();


}