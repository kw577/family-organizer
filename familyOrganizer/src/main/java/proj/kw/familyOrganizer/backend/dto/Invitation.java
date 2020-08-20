package proj.kw.familyOrganizer.backend.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


@Entity(name = "invitation")
public class Invitation {

	//Uwaga !!! dodac Delete On Cascade do kluczy obcych w bazie danych dla tej encji
	
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private int id;
	
	private boolean seen;
	private int user_id;
	private int event_id;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public boolean isSeen() {
		return seen;
	}
	public void setSeen(boolean seen) {
		this.seen = seen;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public int getEvent_id() {
		return event_id;
	}
	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}
	
	
	

} 