package proj.kw.familyOrganizer.model;

public class AttachmentModel {

	private int owner_id;
	private String owner;
	private String date_posted;
	private String code;
	
	
	public AttachmentModel(int owner_id, String owner, String date_posted, String code) {
		
		this.owner_id = owner_id;
		this.owner = owner;
		this.date_posted = date_posted;
		this.code = code;
		
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


	public String getCode() {
		return code;
	}


	public void setCode(String code) {
		this.code = code;
	}


	
	
	
}
