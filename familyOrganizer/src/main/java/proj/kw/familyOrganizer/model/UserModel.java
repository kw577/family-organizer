package proj.kw.familyOrganizer.model;

import java.io.Serializable;

public class UserModel implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	private int id;
	private String name;
	private String surname;
	private String email;
	private String role;
	private int family_id;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSurname() {
		return surname;
	}
	public void setSurname(String surname) {
		this.surname = surname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
		
	public int getFamily_id() {
		return family_id;
	}
	public void setFamily_id(int family_id) {
		this.family_id = family_id;
	}
	
	@Override
	public String toString() {
		return "UserModel [id=" + id + ", name=" + name + ", surname=" + surname + ", email=" + email + ", role=" + role
				+ "]";
	}

	
	
}
