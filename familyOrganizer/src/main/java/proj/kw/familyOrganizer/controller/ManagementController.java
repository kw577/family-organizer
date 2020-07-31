package proj.kw.familyOrganizer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

//Family admin controller

@Controller
@RequestMapping("/manage") 
public class ManagementController {

	@RequestMapping(value = "/familyAccount", method = RequestMethod.GET)  
	public ModelAndView showAccountSettings() {
		
		
		ModelAndView mv = new ModelAndView("page");

		mv.addObject("familyAdminPage", true); 
		mv.addObject("title", "Manage Family Account");



		return mv;
			
		
	}
}