package proj.kw.familyOrganizer.controller;

import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import proj.kw.familyOrganizer.backend.dao.EmailVerificationDAO;
import proj.kw.familyOrganizer.backend.dao.FamilyDAO;
import proj.kw.familyOrganizer.backend.dao.NotesDAO;
import proj.kw.familyOrganizer.backend.dao.UserDAO;
import proj.kw.familyOrganizer.backend.dto.EmailVerification;
import proj.kw.familyOrganizer.backend.dto.Family;
import proj.kw.familyOrganizer.backend.dto.User;
import proj.kw.familyOrganizer.backend.mailSending.MailSenderService;
import proj.kw.familyOrganizer.backend.registerHandler.RegisterPasswordEncoder;

@Controller
public class PageController {
	

	@Autowired 
	private NotesDAO notesDAO;
	
	@Autowired 
	private UserDAO userDAO;
	
	@Autowired 
	private FamilyDAO familyDAO;
	
	@Autowired 
	private EmailVerificationDAO emailVerificationDAO;
	  
    @Autowired
    private MailSenderService emailService;
    
    @Autowired
    private RegisterPasswordEncoder passwordCoder;
         
	
	@RequestMapping(value = {"/", "/home", "/calendar"})
	public ModelAndView startPage() {
		
		ModelAndView mv = new ModelAndView("page");
		mv.addObject("title", "Home");
		mv.addObject("isMainPage", true);
		
		return mv;
		
		
	}
	
	
	//strona z regulaminem zakupow
	@RequestMapping(value = { "/notes" })
	public ModelAndView notesPage() {

		ModelAndView mv = new ModelAndView("page");

		mv.addObject("title", "Notes");
		mv.addObject("isNotesPage", true);
		
		
		//Test
		mv.addObject("notesList", notesDAO.list());
		
		return mv;

	}


	
	
	
	@RequestMapping(value = "register", method = RequestMethod.GET)
	public ModelAndView register() {

		ModelAndView mv = new ModelAndView("register");
		mv.addObject("title", "Registration");

		User nUser = new User();
		mv.addObject("newUser", nUser);

		return mv;


	}
	
	
	// dodawanie nowego uzytkownika
	@RequestMapping(value = "register", method = RequestMethod.POST) 
	public String handleProductSubmission(@ModelAttribute("newUser") User nUser, HttpServletRequest request) { 
		
		int familyAccountID;
			
		//Check if user with this email is not in data base already
		
		if(userDAO.checkEmail(nUser.getEmail())) {
			
			//Create email verification token
			String token = UUID.randomUUID().toString();
			int tokenId = emailVerificationDAO.createVerificationToken(token, nUser.getEmail());
					
			if(emailService.sendAdminWelcomeMessage(nUser, tokenId, token, request.getRequestURL().toString())) {
				
				//Create new Family Account with default name
				Family nFamily = new Family();
				nFamily.setName("Family Account");
				familyAccountID = familyDAO.createFamilyAccount(nFamily);
				
				
				//Add Admin for family account
				nUser.setRole("ADMIN");
				nUser.setEnabled(false);
				nUser.setFamily_id(familyAccountID);
				nUser.setPassword(passwordCoder.codePassword(nUser.getPassword()));
				
				
				 userDAO.addUser(nUser);
				
			} else {
				emailVerificationDAO.delete(emailVerificationDAO.get(tokenId));
				return "redirect:/register/error?mailError";
			}
				
		} else {
			
			System.out.println("\nEmail already in use !!! \n");
			return "redirect:/register/error?mailUsedAlready";
		}
		
		return "redirect:/login?registrationInfo";
	}
	
	
	
	
	@RequestMapping(value = "register/error", method = RequestMethod.GET)
	public ModelAndView registerError(@RequestParam(name="mailError", required=false)String mailError,
			@RequestParam(name="mailUsedAlready", required=false)String mailUsedAlready) {

		ModelAndView mv = new ModelAndView("registerError");
		mv.addObject("title", "RegistrationError");


		if(mailError!=null) {
			mv.addObject("message", "Registration failure: Could not send email message ! Account was not created. Please try again.");
			
		}
		
		if(mailUsedAlready!=null) {
			mv.addObject("message", "Registration failure: Account for given email address already exist. Please use another email address.");
			
		}
		

		return mv;


	}
	
	
	
	// login
	@RequestMapping(value = { "/login" })
	public ModelAndView login(@RequestParam(name="error", required=false)String error, 
			@RequestParam(name="logout", required=false)String logout,
			@RequestParam(name="activationSuccess", required=false)String activationSuccess,
			@RequestParam(name="activationFailure", required=false)String activationFailure,
			@RequestParam(name="registrationInfo", required=false)String registrationInfo) {


		ModelAndView mv = new ModelAndView("login");
		mv.addObject("title", "Login");
		
		//Check if information about unsuccessful login will be added
		if(error!=null) {
			mv.addObject("errorMessage", "Invalid Username or Password!");

		}
		
		if(logout!=null) {
			mv.addObject("logoutMessage", "You have successfully sign out!");

		}
		
		if(activationSuccess!=null) {
			mv.addObject("activationSuccessMessage", "Email verification completed. You can now login on your account!");

		}
		
		if(activationFailure!=null) {
			mv.addObject("activationFailureMessage", "Error while trying to activate your account. Please check your email and search for activation link.");

		}
		
		if(registrationInfo!=null) {
			mv.addObject("registrationMessage", "Your admin account was successfully created, but you can not login until you will verify your email address. Please check your email box, you should find activation link there.");

		}
		

		return mv;

	}

	
	
	// access denied page - when usser is not authorized to view page
	@RequestMapping(value = { "/access-denied" }) 
	public ModelAndView accessDenied() {

		ModelAndView mv = new ModelAndView("errorPage");

		mv.addObject("errorDescription", "403 - Access Denied! You are not authorized to view this page!");

		return mv;

	}
	
	
	
	@RequestMapping(value = { "/register/emailVerification" })
	public String activateAdminAccount(@RequestParam(name="emailCode", required=false)String emailCode, 
			@RequestParam(name="token", required=false)String token) {

				
		EmailVerification emailToken =  emailVerificationDAO.get(Integer.parseInt(emailCode));
		
		if(emailToken!=null) {
			
			if(emailToken.getToken().equals(token)) {
						
				//activate account
				User user = userDAO.getByEmail(emailToken.getEmail());
				user.setEnabled(true);
				userDAO.update(user);
				
				//delete token after activation
				emailVerificationDAO.delete(emailToken);
				
				return "redirect:/login?activationSuccess";
				
			} 
			
		}
		
		return "redirect:/login?activationFailure";

	}
	
	

	
	
	//add new event page
	@RequestMapping(value = { "/createNewEvent" })
	public ModelAndView addNewEventPage() {

		ModelAndView mv = new ModelAndView("page");

		mv.addObject("title", "Add new Event");
		mv.addObject("isAddNewEventPage", true);
						
			
		return mv;

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
