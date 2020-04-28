
public class EnrollmentResponse {

	public Long enrollmentNumber;
	public List<Course> courses;
    public String status;

	public class Course {
		public String enrollmentStatus;
		public Long courseCode;
		public String statusMessage;
	}
}