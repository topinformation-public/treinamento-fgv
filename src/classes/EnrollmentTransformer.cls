public with sharing class EnrollmentTransformer {


    public EnrollmentRequest toEnrollmentRequest(Lead lead){

        EnrollmentRequest enrollment = new EnrollmentRequest();
        enrollment.student.name = lead.Name;
        enrollment.student.document = lead.id;
        enrollment.student.phone = lead.phone;

        for (Course__c course : lead.Courses__r ) {

            EnrollmentRequest.Course courseRequest = new EnrollmentRequest.Course();
            courseRequest.code = Long.valueOf(course.name);
            courseRequest.startDate = course.startDate__c;
            courseRequest.endDate = course.endDate__c;
            courseRequest.ammount = course.ammount__c;
            enrollment.courses.add(courseRequest);
        
        }

        return enrollment;
        
    }
}