package proj.kw.familyOrganizer.backend.dao;

import proj.kw.familyOrganizer.backend.dto.EmailVerification;

public interface EmailVerificationDAO {

	// add new token
	int createVerificationToken(String token, String email);

	// get by id
	EmailVerification get(int tokenId);
	
	//delete token
	boolean delete(EmailVerification token);

} 