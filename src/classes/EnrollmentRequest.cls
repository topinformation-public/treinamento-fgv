public class EnrollmentRequest {

	public Long enrollmentNumber;
	public Student student;
	public List<Course> courses;

	public class Course {
		public Long code;
		public Datetime startDate;
		public Datetime endDate;
		public Decimal ammount;
	}

	public class Student {
		public String name;
		public String document;
		public String phone;
	}
}