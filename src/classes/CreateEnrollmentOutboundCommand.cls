public with sharing class CreateEnrollmentOutboundCommand extends AbstractUpdateableOutboundCommand  {

    EnrollmentRequest enrollment;
    LeadRepository leadRepository;
    EnrollmentResponse enrollmentResponse;
    Lead lead;

    public CreateEnrollmentOutboundCommand () {
        enrollment = new EnrollmentRequest();
        leadRepository = new LeadRepository();
    }

    override
    public Object transformToSend () {
        
        lead = leadRepository.findById(event.getObjectId());

        return new EnrollmentTransformer().toEnrollmentRequest(lead);
    }

    override
    public void processResult (Object responseObject) {
        enrollmentResponse = (EnrollmentResponse) JSON.deserialize( (String) responseObject, EnrollmentResponse.class );
    }

    override
    public void postUpdateExecute() {
        lead.enrollmentStatus__c = enrollmentResponse.status;
        leadRepository.save(lead);
    }

}