package proj.kw.familyOrganizer.model;

public class EventNotificationModel {

	private int id;
	private int type;
	private String owner;
	private String date_posted;
	private String description;
	
	
	public EventNotificationModel(int id, int type, String owner, String date_posted, String description) {
		
		this.id = id;
		this.type = type;
		this.owner = owner;
		this.date_posted = date_posted;
		this.description = description;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public int getType() {
		return type;
	}


	public void setType(int type) {
		this.type = type;
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
