public class VisitCommand extends AbstractUpdateableOutboundCommand {

    override
    public Object transformToSend () {
        return null;
    }

    override
    public void processResult (Object responseObject) {
    }

    override
    public void postUpdateExecute() {
    }


}