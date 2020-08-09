package proj.kw.familyOrganizer.controller;

import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import proj.kw.familyOrganizer.backend.dao.EmailVerificationDAO;
import proj.kw.familyOrganizer.backend.dao.FamilyDAO;
import proj.kw.familyOrganizer.backend.dao.UserDAO;
import proj.kw.familyOrganizer.backend.dto.EmailVerification;
import proj.kw.familyOrganizer.backend.dto.Family;
import proj.kw.familyOrganizer.backend.dto.User;
import proj.kw.familyOrganizer.backend.mailSending.MailSenderService;
import proj.kw.familyOrganizer.backend.mailSending.UserPasswordGenerator;
import proj.kw.familyOrganizer.backend.registerHandler.RegisterPasswordEncoder;
import proj.kw.familyOrganizer.model.UserModel;

//Family admin controller

@Controller
@RequestMapping("/manage") 
public class ManagementController {
	
	
	@Autowired
	private HttpSession session;
	
	@Autowired 
	private FamilyDAO familyDAO;
	
	@Autowired 
	private UserDAO userDAO;
	
	@Autowired 
	private EmailVerificationDAO emailVerificationDAO;
	  
    @Autowired
    private MailSenderService emailService;
    
    @Autowired
    private RegisterPasswordEncoder passwordCoder;
    

	@RequestMapping(value = "/familyAccount", method = RequestMethod.GET)  
	public ModelAndView showAccountSettings() {
		
		ModelAndView mv = new ModelAndView("page");

		mv.addObject("familyAdminPage", true); 
		mv.addObject("title", "Manage Family Account");
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		
		
		if(usrModel != null) {
			
			mv.addObject("family", familyDAO.get(usrModel.getFamily_id()));
			mv.addObject("familyMembers", userDAO.getFamilyMembers(usrModel.getFamily_id()));
			
		}
		
		

		Family nFamily = new Family();
		mv.addObject("newFamily", nFamily);
		
		User nUser = new User();
		mv.addObject("addUser", nUser);



		return mv;
			
		
	}
	
	
	
	
	
	
	
	
	// edit family account name
	@RequestMapping(value = "familyAccount/edit/", method = RequestMethod.POST) 
	public String changeFamilyAccountName(@ModelAttribute("newFamily") Family nFamily) { 
		
		//System.out.println("\nZmieniono nazwe konta na: " + nFamily.getName());
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		
		
		if(usrModel != null) {
			
			
			nFamily.setId(usrModel.getFamily_id());
			familyDAO.update(nFamily);
			
			
		}
		
			
		return "redirect:/manage/familyAccount";
	}
	
	
	
	
	
	// add new user account by admin
	@RequestMapping(value = "familyAccount/addUser", method = RequestMethod.POST) 
	public String addNewUserByAdmin(@ModelAttribute("addUser") User nUser, HttpServletRequest request) { 
		
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		
		
		if(usrModel != null) {
			
				
			//Check if user with this email is not in data base already
			if(userDAO.checkEmail(nUser.getEmail())) {
				
				//Create email verification token
				String token = UUID.randomUUID().toString();
				int tokenId = emailVerificationDAO.createVerificationToken(token, nUser.getEmail());
				
				
				String randomPassword = UserPasswordGenerator.generateUserPassword();
								
				String contextUrl = request.getRequestURL().toString().replaceAll(request.getServletPath(), "");
				System.out.println("Context URL: " + contextUrl);
				
				
				if(emailService.sendUserWelcomeMessage(nUser, tokenId, token, contextUrl, randomPassword)) {
					
			
					//Add Admin for family account
					nUser.setRole("USER");
					nUser.setEnabled(false);
					nUser.setFamily_id(usrModel.getFamily_id());									
					
					nUser.setPassword(passwordCoder.codePassword(randomPassword));
					
					
					
					 userDAO.addUser(nUser);
					
				} else {
					emailVerificationDAO.delete(emailVerificationDAO.get(tokenId));
					return "redirect:/register/error?mailError";
				}
					
			} else {
				
				//System.out.println("\nEmail already in use !!! \n");
				return "redirect:/register/error?mailUsedAlready";
			}
			
			
			
		}
		
		
		//return "redirect:/login?registrationInfo";	
		return "redirect:/manage/familyAccount";
	
	}
	
	
	
	
	
	
	
}