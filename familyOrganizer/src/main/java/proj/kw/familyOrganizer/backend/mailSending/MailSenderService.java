package proj.kw.familyOrganizer.backend.mailSending;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import proj.kw.familyOrganizer.backend.dto.User;

@Component("emailService")
public class MailSenderService {

    @Autowired
    private JavaMailSender mailSender;


    public boolean sendAdminWelcomeMessage(User user) {
    	
    	SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(user.getEmail());
        email.setSubject("Account - Family Organizer");
        email.setText("Your Admin account was successfully created. You can now add other members of your family in Admin panel");
    	
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
    
    
	
}
