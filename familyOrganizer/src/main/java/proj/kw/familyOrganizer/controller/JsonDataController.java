package proj.kw.familyOrganizer.controller;

import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import proj.kw.familyOrganizer.backend.dao.EventDAO;
import proj.kw.familyOrganizer.backend.dto.Event;
import proj.kw.familyOrganizer.model.UserModel;


@Controller 
@RequestMapping("json/data")  
public class JsonDataController {

	@Autowired   
	private EventDAO eventDAO;

	@Autowired
	private HttpSession session;

	
	//return list of event from selected day in JSON
	@RequestMapping("/calendarDayView/getEvents")   
	@ResponseBody 
	public List<Event> getEventForDay(@RequestParam("year") Integer year, 
									@RequestParam("month") Integer month, 
									@RequestParam("day") Integer day) {

		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		//System.out.println("\n\n\n\nJsonDataController: " + year + "-" + month + "-" + day + "\n\n\n\n");
		
		
		LocalDateTime date_start = LocalDateTime.of(year, month + 1, day, 0, 0);
		//System.out.println(date_start);
		LocalDateTime date_end = LocalDateTime.of(year, month + 1, day, 23, 59);
		//System.out.println(date_end + " " + date_end.getMonth());

			
		return eventDAO.getEventsForDay(usrModel.getFamily_id(), date_start, date_end);
		
	}
	
	
	

} 