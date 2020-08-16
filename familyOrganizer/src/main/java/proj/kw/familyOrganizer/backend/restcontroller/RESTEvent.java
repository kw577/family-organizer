package proj.kw.familyOrganizer.backend.restcontroller;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.EventDAO;
import proj.kw.familyOrganizer.backend.dto.Event;


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



}