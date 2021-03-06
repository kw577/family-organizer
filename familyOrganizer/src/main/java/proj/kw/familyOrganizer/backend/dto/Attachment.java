package proj.kw.familyOrganizer.backend.dto;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;


@Entity(name = "attachment")
public class Attachment {


	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private int id;
		
	private int event_id;
	private int owner_id;
	private LocalDateTime date_posted;
	private String code;
		
	@Transient
	private MultipartFile file;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getEvent_id() {
		return event_id;
	}

	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}

	public int getOwner_id() {
		return owner_id;
	}

	public void setOwner_id(int owner_id) {
		this.owner_id = owner_id;
	}

	public LocalDateTime getDate_posted() {
		return date_posted;
	}

	public void setDate_posted(LocalDateTime date_posted) {
		this.date_posted = date_posted;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	
	
	
	

} 