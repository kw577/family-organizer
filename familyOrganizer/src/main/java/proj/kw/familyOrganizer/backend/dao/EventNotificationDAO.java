package proj.kw.familyOrganizer.backend.dao;

import proj.kw.familyOrganizer.backend.dto.EventNotification;

public interface EventNotificationDAO {

	// add notification
	boolean addNotification(EventNotification notification);
	
	// check if event has notification
	boolean checkEventForNotification(int event_id);
	
	EventNotification getNotificationForEvent(int event_id);
	
}
