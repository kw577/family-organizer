package proj.kw.familyOrganizer.backend.restcontroller;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.EventNotificationDAO;
import proj.kw.familyOrganizer.backend.dto.Event;
import proj.kw.familyOrganizer.backend.dto.EventNotification;




@Transactional
@Repository("eventNotificationDAO")
public class RESTEventNotification implements EventNotificationDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public boolean addNotification(EventNotification notification) {
		try {			
			sessionFactory.getCurrentSession().persist(notification);			
			return true;
		}
		catch(Exception ex) {
			return false;
		}
		
	}
	
	
	
	
	@Override
	public boolean checkEventForNotification(int event_id) {
		

		String checkEmailQuery = "FROM event_notification WHERE event_id = :event_id";

		Query query = sessionFactory.getCurrentSession().createQuery(checkEmailQuery);
		query.setParameter("event_id", event_id);

		return query.getResultList().isEmpty();
		
		
	}
	
	

	
	@Override
	public EventNotification getNotificationForEvent(int event_id) {
		String query = "FROM event_notification WHERE event_id = :event_id";	
		
		try {			
			return sessionFactory
					.getCurrentSession()
					.createQuery(query, EventNotification.class)
					.setParameter("event_id", event_id)
					.getSingleResult();			
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}
		return null;
		
		

		
	}
	
	
		
	
	
	
}