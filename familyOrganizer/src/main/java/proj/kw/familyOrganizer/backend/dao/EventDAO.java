package proj.kw.familyOrganizer.backend.dao;

import java.util.List;

import proj.kw.familyOrganizer.backend.dto.Event;


public interface EventDAO {

	// add an user
	boolean addEvent(Event event);
	
	
	//get list of events started by certain user
	List<Event> getUserEvents(int owner_id);
	
	
}
