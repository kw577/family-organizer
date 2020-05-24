package proj.kw.familyOrganizer.backend.dao;

import proj.kw.familyOrganizer.backend.dto.User;

public interface UserDAO {

	// add an user
	boolean addUser(User user);

	//check if any user from database has this email, email can be used only once
	boolean checkEmail(String email);
	
	
} 