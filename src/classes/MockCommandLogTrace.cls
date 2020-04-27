/**
 * @author: Eduardo Ribeiro de Carvalho
 */
@isTest
public class MockCommandLogTrace implements ICommand {

    public void execute(EventQueue event) {
        event.log ('executed');
    }

}