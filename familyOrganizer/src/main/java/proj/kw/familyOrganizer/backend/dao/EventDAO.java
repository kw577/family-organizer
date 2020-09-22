package proj.kw.familyOrganizer.backend.dao;

import java.time.LocalDateTime;
import java.util.List;

import proj.kw.familyOrganizer.backend.dto.Event;
import proj.kw.familyOrganizer.backend.dto.User;


public interface EventDAO {

	// add an user
	boolean addEvent(Event event);
	
	
	//get list of events started by certain user
	List<Event> getUserEvents(int owner_id);
	
	//get list of events for certain family
	List<Event> getEventsByFamily(int family_id);
	
	//delete event
	boolean delete(Event event);
	
	//get event by id
	Event getEventById(int id);
	
	//get event by id and owner
	Event getEventByIdAndOwner(int id, int owner_id);
	
	//update event
	boolean update(Event event);
	
	//get list of events started by certain user
	List<Event> searchEventsWithKeyword(int family_id, String keyword);
	
	
	//get list of events of certain family for selected day
	List<Event> getEventsForDay(int family_id, LocalDateTime start, LocalDateTime end);

	
	
}
