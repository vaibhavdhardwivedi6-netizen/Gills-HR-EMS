package empdao;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import model.jobs;
import db.DatabaseConnection;

	public class jobdao {

		 public static Connection getConnection() {
		        return DatabaseConnection.getConnection();
		    }
		     public int insertJob(jobs job)  {
		    	 
		    	 int i=0;
		     
		         try {
		         Connection conn = getConnection();
		         PreparedStatement ps = conn.prepareStatement( "INSERT INTO jobs (company_name, job_title, vacancies, job_location, qualification, experience, salary, application_start_date, application_last_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");

		         ps.setString(1, job.getCompanyName());
		         ps.setString(2, job.getJobTitle());
		         ps.setInt(3, job.getVacancies());
		         ps.setString(4, job.getJobLocation());
		         ps.setString(5, job.getQualification());
		         ps.setString(6, job.getExperience());
		         ps.setString(7, job.getSalary());
		         ps.setDate(8, Date.valueOf(job.getApplicationStartDate()));
		         ps.setDate(9, Date.valueOf(job.getApplicationLastDate()));

		       
		         i= ps.executeUpdate();
		         
		         } catch (Exception e) {
		             e.printStackTrace();
		         }

		         return i;
		     }


		     public int deleteJob(int jobId)  {
		     int i=0;
		      
		     try {
		    	
		     Connection conn = getConnection();

		     PreparedStatement ps = conn.prepareStatement( "DELETE FROM jobs WHERE jobs_id = ?");
     
		     ps.setInt(1, jobId);
		         
		     i= ps.executeUpdate();
		        
		       } 
		     catch(Exception e) {
		    	
		     e.printStackTrace();
		    	 
		     }
	        return i;
		     
		     }

		     public int updatejob(jobs job)  {
		
		     int i =0;
		  
		     try {
		 
		     Connection conn = getConnection();

		     PreparedStatement ps = conn.prepareStatement("UPDATE jobs SET company_name=?, job_title=?, vacancies=?, job_location=?, qualification=?,"
		     
		     + " experience=?, salary=?, application_start_date=?, application_last_date=? WHERE jobs_id=?");
		        
		         ps.setString(1, job.getCompanyName());
		         ps.setString(2, job.getJobTitle());
		         ps.setInt(3, job.getVacancies());
		         ps.setString(4, job.getJobLocation());
		         ps.setString(5, job.getQualification());
		         ps.setString(6, job.getExperience());
		         ps.setString(7, job.getSalary());

		         ps.setDate(8, Date.valueOf(job.getApplicationStartDate()));
		         ps.setDate(9, Date.valueOf(job.getApplicationLastDate()));

		         ps.setInt(10, job.getJobId());

		         i = ps.executeUpdate();
		   
		    	 } catch(Exception e) {
		    		 e.printStackTrace();
		    	 }
		    	 
		    	 return i;
		        }

		     public List<jobs> searchByJobTitle(String title){
		      
		     List<jobs> list = new ArrayList<>();
		         
		     try {
 
		     Connection conn = getConnection();

		     PreparedStatement ps = conn.prepareStatement( "SELECT * FROM jobs WHERE job_title LIKE ?");
	
		     ps.setString(1, "%" + title + "%");

		     ResultSet rs = ps.executeQuery();

             while (rs.next()) {
	
             jobs job = new jobs();
		     
             job.setJobId(rs.getInt("jobs_id"));
		     
             job.setCompanyName(rs.getString("company_name"));
		     
             job.setJobTitle(rs.getString("job_title"));
		     
             job.setVacancies(rs.getInt("vacancies"));
		     
             job.setJobLocation(rs.getString("job_location"));
		     
             job.setQualification(rs.getString("qualification"));
		     
             job.setExperience(rs.getString("experience"));
		     
             job.setSalary(rs.getString("salary"));

		     
             job.setApplicationStartDate(rs.getDate("application_start_date") != null ? rs.getDate("application_start_date").toString() : "");
		     
             job.setApplicationLastDate(rs.getDate("application_last_date") != null ? rs.getDate("application_last_date").toString() : "");

		     
             list.add(job);
		     
             }
		         
		     
		     } catch(Exception e) {
		     
		    	 e.printStackTrace();		         }

		         
		     return list;
		     
		     }
		     
		     
		     public List<jobs> getAllJobs()  {
		    
		     List<jobs> list = new ArrayList<>();

	    	 try {
	    	 	Connection conn = getConnection();
				
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM jobs ORDER BY jobs_id DESC");
					
		    ResultSet rs = ps.executeQuery();

	  	    while (rs.next()) {
	
	  	    	jobs job = new jobs();
		    	
	  	    	job.setJobId(rs.getInt("jobs_id"));
		    	
	  	    	job.setCompanyName(rs.getString("company_name"));
		    	
	  	    	job.setJobTitle(rs.getString("job_title"));
		    	
	  	    	job.setVacancies(rs.getInt("vacancies"));
		    	        
	  	    	job.setJobLocation(rs.getString("job_location"));
		    	
	  	    	job.setQualification(rs.getString("qualification"));
		    	
	  	    	job.setExperience(rs.getString("experience"));
		    	
	  	    	job.setSalary(rs.getString("salary"));

	  	    	job.setApplicationStartDate(rs.getDate("application_start_date") != null ? rs.getDate("application_start_date").toString() : "");
		    	
	  	    	job.setApplicationLastDate(rs.getDate("application_last_date") != null ? rs.getDate("application_last_date").toString() : "");

	  	    	list.add(job);
	  	    }
		    
	    	 } catch(Exception e) {
			
	    		 e.printStackTrace();
			
	    	 }
	    	 
	    	 return list;
		     }

		     // Active jobs only (for non-admin users — respects application deadline)
		     public List<jobs> getAllActiveJobs()  {
		    
		     List<jobs> list = new ArrayList<>();

	    	 try {
	    	 	Connection conn = getConnection();
				
			PreparedStatement ps = conn.prepareStatement("SELECT * FROM jobs WHERE application_last_date >= CURRENT_DATE ORDER BY jobs_id DESC");
					
		    ResultSet rs = ps.executeQuery();

	  	    while (rs.next()) {
	
	  	    	jobs job = new jobs();
		    	
	  	    	job.setJobId(rs.getInt("jobs_id"));
		    	
	  	    	job.setCompanyName(rs.getString("company_name"));
		    	
	  	    	job.setJobTitle(rs.getString("job_title"));
		    	
	  	    	job.setVacancies(rs.getInt("vacancies"));
		    	        
	  	    	job.setJobLocation(rs.getString("job_location"));
		    	
	  	    	job.setQualification(rs.getString("qualification"));
		    	
	  	    	job.setExperience(rs.getString("experience"));
		    	
	  	    	job.setSalary(rs.getString("salary"));

	  	    	job.setApplicationStartDate(rs.getDate("application_start_date") != null ? rs.getDate("application_start_date").toString() : "");
		    	
	  	    	job.setApplicationLastDate(rs.getDate("application_last_date") != null ? rs.getDate("application_last_date").toString() : "");

	  	    	list.add(job);
	  	    }
		    
	    	 } catch(Exception e) {
			
	    		 e.printStackTrace();
			
	    	 }
	    	 
	    	 return list;
		     }
		     
		     public jobs getJobById(int id) {
 
		    jobs job = null;

		    try {
		    
		    	Connection conn= getConnection();
		    	
		    	String sql = "SELECT * FROM jobs WHERE jobs_id=?";
		    	
		    	PreparedStatement ps = conn.prepareStatement(sql);
		    	  
		    	ps.setInt(1, id);

		    	
		    	ResultSet rs = ps.executeQuery();

		    	
		    	 while(rs.next()) {
		    	
		    		job = new jobs();
		    	    
		    		job.setJobId(rs.getInt("jobs_id"));
		    	    
		    		job.setCompanyName(rs.getString("company_name"));
		    	    
		    		job.setJobTitle(rs.getString("job_title"));
		    	    
		    		job.setVacancies(rs.getInt("vacancies"));
		    	    
		    		job.setJobLocation(rs.getString("job_location"));
		    	    
		    		job.setQualification(rs.getString("qualification"));
		    	    
		    		job.setExperience(rs.getString("experience"));
		    	    
		    		job.setSalary(rs.getString("salary"));

		    		job.setApplicationStartDate(rs.getDate("application_start_date") != null ? rs.getDate("application_start_date").toString() : "");
		    	        
		    		job.setApplicationLastDate(rs.getDate("application_last_date") != null ? rs.getDate("application_last_date").toString() : "");
		    	    
		    	}
		    } catch (Exception e) {
		    	e.printStackTrace();
		    }
		    return job;
		}

		public int getCount() {
		    int count = 0;
		    try (Connection conn = getConnection();
		         PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM jobs");
		         ResultSet rs = ps.executeQuery()) {
		        if (rs.next()) {
		            count = rs.getInt(1);
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return count;
		}

		public List<jobs> getRecentJobs(int limit) {
			List<jobs> list = new ArrayList<>();
			try {
				Connection conn = getConnection();
				PreparedStatement ps = conn.prepareStatement("SELECT * FROM jobs WHERE application_last_date >= CURRENT_DATE ORDER BY jobs_id DESC LIMIT ?");
				ps.setInt(1, limit);
				ResultSet rs = ps.executeQuery();
				while (rs.next()) {
					jobs job = new jobs();
					job.setJobId(rs.getInt("jobs_id"));
					job.setCompanyName(rs.getString("company_name"));
					job.setJobTitle(rs.getString("job_title"));
					job.setVacancies(rs.getInt("vacancies"));
					job.setJobLocation(rs.getString("job_location"));
					job.setQualification(rs.getString("qualification"));
					job.setExperience(rs.getString("experience"));
					job.setSalary(rs.getString("salary"));
					job.setApplicationStartDate(rs.getDate("application_start_date") != null ? rs.getDate("application_start_date").toString() : "");
					job.setApplicationLastDate(rs.getDate("application_last_date") != null ? rs.getDate("application_last_date").toString() : "");
					list.add(job);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return list;
		}
	}