package proj.kw.familyOrganizer.model;

import java.time.LocalDateTime;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

public class CommentModel {

	private int owner_id;
	private String owner;
	private String date_posted;
	private String description;
	
	
	public CommentModel(int owner_id, String owner, String date_posted, String description) {
		
		this.owner_id = owner_id;
		this.owner = owner;
		this.date_posted = date_posted;
		this.description = description;
		
	}


	public int getOwner_id() {
		return owner_id;
	}


	public void setOwner_id(int owner_id) {
		this.owner_id = owner_id;
	}


	public String getOwner() {
		return owner;
	}


	public void setOwner(String owner) {
		this.owner = owner;
	}


	public String getDate_posted() {
		return date_posted;
	}


	public void setDate_posted(String date_posted) {
		this.date_posted = date_posted;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}
	
	
	
	
}
