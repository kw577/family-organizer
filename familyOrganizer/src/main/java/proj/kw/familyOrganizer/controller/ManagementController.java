package proj.kw.familyOrganizer.controller;

import java.time.LocalDateTime;
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
import proj.kw.familyOrganizer.backend.dao.EventNotificationDAO;
import proj.kw.familyOrganizer.backend.dao.FamilyDAO;
import proj.kw.familyOrganizer.backend.dao.UserDAO;
import proj.kw.familyOrganizer.backend.dto.EmailVerification;
import proj.kw.familyOrganizer.backend.dto.EventNotification;
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
	private EventNotificationDAO eventNotificationDAO;
	
	
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

		User dUser = new User();
		mv.addObject("delUser", dUser);
		
		User mUser = new User();
		mv.addObject("modUser", mUser);

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
	
	
	
	
	
	
	
	
	// delete user's family account
	@RequestMapping(value = "familyAccount/deleteUser/", method = RequestMethod.POST) 
	public String deleteUserAccount(@ModelAttribute("delUser") User dUser) { 
		
		//System.out.println("\nZmieniono nazwe konta na: " + nFamily.getName());
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		
		
		if(usrModel != null) {
			
			System.out.println("\n\n\n\n\n\n\nDelete account with email: " + dUser.getEmail());
			
			//delete only account in Admin's family - this if is probably not necessary
			if(usrModel.getFamily_id() == userDAO.getByEmail(dUser.getEmail()).getFamily_id()) {
			userDAO.delete(userDAO.getByEmail(dUser.getEmail()));
			
			
				//Sprawdzenie czy dla tego adresu email jest niewykorzystony token weryfikacyjny email - konto nie zostalo jeszcze aktywowane
				//Usuniecie tokenu jesli jest taki w bazie danych
				if(emailVerificationDAO.getByEmail(dUser.getEmail()) != null) {
					
					emailVerificationDAO.delete(emailVerificationDAO.getByEmail(dUser.getEmail()));
					
					
				}
			
			
			
			
			
			}
		
		}
		
			
		return "redirect:/manage/familyAccount";
	}
	
	
	
	
	
	
	
	
	
	// modify user's account
	@RequestMapping(value = "familyAccount/modifyUser/", method = RequestMethod.POST) 
	public String modifyUserAccount(@ModelAttribute("modUser") User mUser) { 
		
		//System.out.println("\n\n\nModyfikacja konta dla email: " + mUser.getEmail());
		//System.out.println("\nPole name: " + mUser.getName());
		//System.out.println("\nPole surname: " + mUser.getSurname());
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		
		
		if(usrModel != null) {
			
			
			
			//delete only account in Admin's family - this if is probably not necessary
			if(usrModel.getFamily_id() == userDAO.getByEmail(mUser.getEmail()).getFamily_id()) {
				
				User user = userDAO.getByEmail(mUser.getEmail());
				user.setName(mUser.getName());
				user.setSurname(mUser.getSurname());
				userDAO.update(user);
			
			}
		
		}
		
		
			
		return "redirect:/manage/familyAccount";
	}
	
	
	
	
	
	
	
	// modify user's account
	@RequestMapping(value = "/addNotification/", method = RequestMethod.POST) 
	public String addNotification(@ModelAttribute("newNotification") EventNotification nNotification) { 
		
		//System.out.println("\n\n\nTyp notyfikacji: " + nNotification.getType());
		//System.out.println("\nOpis: " + nNotification.getDescription());
		
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		
		
		if(usrModel != null) {
			
			
			if(eventNotificationDAO.checkEventForNotification(nNotification.getEvent_id())) {
				
				nNotification.setOwner_id(usrModel.getId());
				nNotification.setFamily_id(usrModel.getFamily_id());
				nNotification.setDate_posted(LocalDateTime.now());
				
				eventNotificationDAO.addNotification(nNotification);
			}
		
		}
		
		
			
		return "redirect:/viewEvent/" + nNotification.getEvent_id() + "/basicView";
	}
	
	
	
	
	
	
	
}