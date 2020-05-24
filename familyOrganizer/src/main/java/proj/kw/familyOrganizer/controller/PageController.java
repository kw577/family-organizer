package proj.kw.familyOrganizer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import proj.kw.familyOrganizer.backend.dao.FamilyDAO;
import proj.kw.familyOrganizer.backend.dao.NotesDAO;
import proj.kw.familyOrganizer.backend.dao.UserDAO;
import proj.kw.familyOrganizer.backend.dto.Family;
import proj.kw.familyOrganizer.backend.dto.User;

@Controller
public class PageController {
	

	@Autowired 
	private NotesDAO notesDAO;
	
	@Autowired 
	private UserDAO userDAO;
	
	@Autowired 
	private FamilyDAO familyDAO;
	
    @Autowired
    private JavaMailSender mailSender;

	
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
	public String handleProductSubmission(@ModelAttribute("newUser") User nUser) { 
		
		int familyAccountID;
		
		//Create new Family Account with default name
		Family nFamily = new Family();
		nFamily.setName("Family Account");
		familyAccountID = familyDAO.createFamilyAccount(nFamily);
		
		
		//Add Admin for family account
		nUser.setRole("ADMIN");
		nUser.setEnabled(true);
		nUser.setFamily_id(familyAccountID);

		userDAO.addUser(nUser);
		
		
		///////email-test////////
		
	       // creates a simple e-mail object
        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo("kw577@wp.pl");
        email.setSubject("Account - Family Organizer");
        email.setText("Account was successfully created");
         
        // sends the e-mail
        mailSender.send(email);
		
		
		/////////////////////////
		
	
		
		return "redirect:/home";
	}
	
	
	
	
}
