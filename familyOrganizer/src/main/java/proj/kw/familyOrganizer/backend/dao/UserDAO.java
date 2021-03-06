package proj.kw.familyOrganizer.backend.dao;

import java.util.List;

import proj.kw.familyOrganizer.backend.dto.User;

public interface UserDAO {

	// add an user
	boolean addUser(User user);

	//check if any user from database has this email, email can be used only once
	boolean checkEmail(String email);
	
	//get user by email address
	User getByEmail(String email);
	
	//update User account
	boolean update(User user);
	
	//get list of family members
	List<User> getFamilyMembers(int family_id);
	
	
	//delete user account
	boolean delete(User user);
	
	//get user by id
	User getUserById(int id);
	
} 