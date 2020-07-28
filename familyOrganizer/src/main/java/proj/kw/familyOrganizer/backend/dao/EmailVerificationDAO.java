package proj.kw.familyOrganizer.backend.dao;

public interface EmailVerificationDAO {

	// add an user
	int createVerificationToken(String token, String email);


} 