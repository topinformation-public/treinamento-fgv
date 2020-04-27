/**
 * Provide Mock Command for handle exception execution
 * @author ercarval
 */
@isTest
public class MockThrowsExeceptionCommand implements ICommand, IUpdatableCommmad {

    public void execute(EventQueue event) {

        event.log ('executed');

        throw new CalloutException ('Unable to process Request');

    }

    public void postUpdateExecute(EventQueue event) {
    }



}