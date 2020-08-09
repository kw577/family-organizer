package proj.kw.familyOrganizer.backend.mailSending;

import javax.servlet.ServletContext;


import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import proj.kw.familyOrganizer.backend.dto.User;

@Component("emailService")
public class MailSenderService {
 
    @Autowired
    private JavaMailSender mailSender;
    
    public boolean sendAdminWelcomeMessage(User user, int tokenId, String token, String pageUrl) {
    	
    	//String activationLink = appContext
    	String activationLink = pageUrl + "/emailVerification?emailCode=" + tokenId + "&token=" + token;
    	  	
    	SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(user.getEmail());
        email.setSubject("New Account - Family Organizer");
        email.setText("Your Admin account was successfully created. You can activate your account by clicking this link:\n" + activationLink);
    	
        try {
        	mailSender.send(email);
        } catch (Exception ex) {
        	
        	System.out.println("\n\nCan not send email !!!");
        	System.err.print(ex);
        	System.out.println("\nCheck email configuration in dispatcher-servlet !!!\n");
        	return false;
        }
        
        
    	return true;
    }

	
    
    
    
    public boolean sendUserWelcomeMessage(User user, int tokenId, String token, String pageUrl, String password) {
    	
    	//String activationLink = appContext
    	String activationLink = pageUrl + "/register/emailVerification?emailCode=" + tokenId + "&token=" + token;
    	  	
    	SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(user.getEmail());
        email.setSubject("New User Account - Family Organizer");
        email.setText("Your account was successfully created by your Family Admin. \nYou can activate account by clicking this link: " 
        		+ activationLink + "\nAfter that you can login to your account with this credentials: " 
        		+ "\nlogin: " + user.getEmail() + "\npassword: " + password);
    	
        try {
        	mailSender.send(email);
        } catch (Exception ex) {
        	
        	System.out.println("\n\nCan not send email !!!");
        	System.err.print(ex);

        	return false;
        }
        
        
    	return true;
	}
    
    
	
}
