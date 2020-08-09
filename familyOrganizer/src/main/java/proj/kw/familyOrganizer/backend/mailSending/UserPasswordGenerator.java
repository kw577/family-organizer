package proj.kw.familyOrganizer.backend.mailSending;

import java.util.Random;

public class UserPasswordGenerator {

	public static String generateUserPassword() {
		
		int passwordLength = 10;
	    Random random = new Random();		
		
	    int leftLimit = 48; 
	    int rightLimit = 122; 
	    	    
	    
	    StringBuilder buffer = new StringBuilder(passwordLength);
	    
	    
	    for (int i = 0; i < passwordLength; i++) {
	        int randomLimitedInt = leftLimit + (int) 
	          (random.nextFloat() * (rightLimit - leftLimit + 1));
	        buffer.append((char) randomLimitedInt);
	    }
	    
	    String password = buffer.toString();
	 

		return password;
		
	}
	
}
