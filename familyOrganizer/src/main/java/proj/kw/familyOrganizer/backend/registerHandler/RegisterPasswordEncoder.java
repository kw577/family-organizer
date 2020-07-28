package proj.kw.familyOrganizer.backend.registerHandler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import proj.kw.familyOrganizer.backend.dto.User;

@Component("passwordCoder")
public class RegisterPasswordEncoder {

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	
	public String codePassword(String password) {
		
		return passwordEncoder.encode(password);	
		
	}
	
	
	
}
