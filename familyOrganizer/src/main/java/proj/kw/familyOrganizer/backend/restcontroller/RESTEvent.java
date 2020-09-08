package proj.kw.familyOrganizer.backend.restcontroller;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.EventDAO;
import proj.kw.familyOrganizer.backend.dto.EmailVerification;
import proj.kw.familyOrganizer.backend.dto.Event;
import proj.kw.familyOrganizer.backend.dto.User;


@Transactional
@Repository("eventDAO")
public class RESTEvent implements EventDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public boolean addEvent(Event event) {
		try {			
			sessionFactory.getCurrentSession().persist(event);			
			return true;
		}
		catch(Exception ex) {
			return false;
		}
		
	}

	
	
	@Override
	public List<Event> getUserEvents(int owner_id) {
		String query = "FROM event WHERE owner_id = :owner_id AND end_date >= now() order by start_date";
		
		return sessionFactory
				.getCurrentSession()
				.createQuery(query, Event.class)
				.setParameter("owner_id", owner_id)
				.getResultList();
	}
	
	
	
	
	@Override
	public boolean delete(Event event) {
		try {			
			sessionFactory
					.getCurrentSession()
						.delete(event);
			return true;
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}		
		return false;		


	}
	
		
	
	
	@Override
	public Event getEventById(int id) {
		
		try {			
			return sessionFactory
					.getCurrentSession()
						.get(Event.class,Integer.valueOf(id));			
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}
		return null;
	}
	
	
	
	
	@Override
	public Event getEventByIdAndOwner(int id, int owner_id) {
		String query = "FROM event WHERE id = :id AND owner_id = :owner_id";
		
		return sessionFactory
				.getCurrentSession()
				.createQuery(query, Event.class)
				.setParameter("id", id)
				.setParameter("owner_id", owner_id)
				.getSingleResult();
	}
	
	
	
	
	@Override
	public boolean update(Event event) {
		try {			
			sessionFactory
					.getCurrentSession()
						.update(event);
			return true;
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}		
		return false;		
	}
	
	
	
	
	
	
	@Override
	public List<Event> getEventsByFamily(int family_id) {
		String query = "FROM event WHERE family_id = :family_id AND end_date >= now() order by start_date";
		
		return sessionFactory
				.getCurrentSession()
				.createQuery(query, Event.class)
				.setParameter("family_id", family_id)
				.getResultList();
	}
	
	
	
	
	
	@Override
	public List<Event> searchEventsWithKeyword(int family_id, String searchPhrase) {

				
		String query = "FROM event WHERE family_id = :family_id AND (LOWER(title) LIKE LOWER(:searchPhrase) "
				+ "OR LOWER(description) LIKE LOWER(:searchPhrase) OR LOWER(localization) LIKE LOWER(:searchPhrase)) order by start_date";
		return sessionFactory
				.getCurrentSession()
					.createQuery(query,Event.class)
						.setParameter("family_id", family_id)
						.setParameter("searchPhrase", "%"+searchPhrase+"%")
							.getResultList();
		
	}
	
	
	
	
	
	
	


}