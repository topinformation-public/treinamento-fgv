trigger Visits on Visit__c (after insert, after update) {
    new VisitTH().run();
}