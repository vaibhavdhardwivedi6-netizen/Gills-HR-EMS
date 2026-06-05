package model;

import java.util.Date;
public class jobs {


	    private int jobId;
	    private String companyName;
	    private String jobTitle;
	    private int vacancies;
	    private String jobLocation;
	    private String qualification;
	    private String experience;
	    private String salary;
	    private String applicationStartDate;
	    private String applicationLastDate;


	    public jobs() {
			super();
			// TODO Auto-generated constructor stub
		}

		public jobs(int jobId, String companyName, String jobTitle, int vacancies, String jobLocation,
				String qualification, String experience, String salary, String applicationStartDate,
				String applicationLastDate) {
			super();
			this.jobId = jobId;
			this.companyName = companyName;
			this.jobTitle = jobTitle;
			this.vacancies = vacancies;
			this.jobLocation = jobLocation;
			this.qualification = qualification;
			this.experience = experience;
			this.salary = salary;
			this.applicationStartDate = applicationStartDate;
			this.applicationLastDate = applicationLastDate;
		}

		public jobs(String companyName, String jobTitle, int vacancies, String jobLocation, String qualification,
				String experience, String salary, String applicationStartDate, String applicationLastDate) {
			super();
			this.companyName = companyName;
			this.jobTitle = jobTitle;
			this.vacancies = vacancies;
			this.jobLocation = jobLocation;
			this.qualification = qualification;
			this.experience = experience;
			this.salary = salary;
			this.applicationStartDate = applicationStartDate;
			this.applicationLastDate = applicationLastDate;
		}

		public int getJobId() {
	        return jobId;
	    }

	    public void setJobId(int jobId) {
	        this.jobId = jobId;
	    }

	    public String getCompanyName() {
	        return companyName;
	    }

	    public void setCompanyName(String companyName) {
	        this.companyName = companyName;
	    }

	    public String getJobTitle() {
	        return jobTitle;
	    }

	    public void setJobTitle(String jobTitle) {
	        this.jobTitle = jobTitle;
	    }

	    public int getVacancies() {
	        return vacancies;
	    }

	    public void setVacancies(int vacancies) {
	        this.vacancies = vacancies;
	    }

	    public String getJobLocation() {
	        return jobLocation;
	    }

	    public void setJobLocation(String jobLocation) {
	        this.jobLocation = jobLocation;
	    }

	    public String getQualification() {
	        return qualification;
	    }

	    public void setQualification(String qualification) {
	        this.qualification = qualification;
	    }

	    public String getExperience() {
	        return experience;
	    }

	    public void setExperience(String experience) {
	        this.experience = experience;
	    }

	    public String getSalary() {
	        return salary;
	    }

	    public void setSalary(String salary) {
	        this.salary = salary;
	    }

	    public String getApplicationStartDate() {
	        return applicationStartDate;
	    }

	    public void setApplicationStartDate(String string) {
	        this.applicationStartDate = string;
	    }

	    public String getApplicationLastDate() {
	        return applicationLastDate;
	    }

	    public void setApplicationLastDate(String string) {
	        this.applicationLastDate = string;
	    }

		@Override
		public String toString() {
			return "jobs [jobId=" + jobId + ", companyName=" + companyName + ", jobTitle=" + jobTitle + ", vacancies="
					+ vacancies + ", jobLocation=" + jobLocation + ", qualification=" + qualification + ", experience="
					+ experience + ", salary=" + salary + ", applicationStartDate=" + applicationStartDate
					+ ", applicationLastDate=" + applicationLastDate + "]";
		}
	}