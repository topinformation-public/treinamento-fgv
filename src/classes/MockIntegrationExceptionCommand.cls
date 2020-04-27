/**
 * Provide Mock Command for handle exception execution
 * @author ercarval
 */
@isTest
public class MockIntegrationExceptionCommand implements ICommand, IUpdatableCommmad {

    public void execute(EventQueue event) {

        event.log ('executed');

        throw new IntegrationBusinessException ('Unable to process Request');

    }

    public void postUpdateExecute(EventQueue event) {
        throw new IntegrationBusinessException ('Unable to process Request');
    }


}