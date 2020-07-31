package proj.kw.familyOrganizer.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import proj.kw.familyOrganizer.backend.dao.FamilyDAO;
import proj.kw.familyOrganizer.backend.dao.UserDAO;
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
		
		
		




		return mv;
			
		
	}
}