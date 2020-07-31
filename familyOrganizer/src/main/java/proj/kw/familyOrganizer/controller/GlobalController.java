package proj.kw.familyOrganizer.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import proj.kw.familyOrganizer.backend.dao.UserDAO;
import proj.kw.familyOrganizer.backend.dto.User;
import proj.kw.familyOrganizer.model.UserModel;


@ControllerAdvice
public class GlobalController {


	@Autowired
	private UserDAO userDAO;

	@Autowired
	private HttpSession session;

	private UserModel userModel = null;
	private User user = null;	


	@ModelAttribute("userModel")
	public UserModel getUserModel() {		
		if(session.getAttribute("userModel")==null) {
			
			Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

			//if(!authentication.getPrincipal().equals("anonymousUser")){
				// get the user from the database
				user = userDAO.getByEmail(authentication.getName());

				if(user!=null) {

					userModel = new UserModel();

					userModel.setId(user.getId());
					userModel.setName(user.getName());
					userModel.setSurname(user.getSurname());
					userModel.setEmail(user.getEmail());
					userModel.setRole(user.getRole());
					userModel.setFamily_id(user.getFamily_id());				

					//set the userModel in the session
					session.setAttribute("userModel", userModel);
					return userModel;
				}			
			//}
		}

		return (UserModel) session.getAttribute("userModel");		
	}

}