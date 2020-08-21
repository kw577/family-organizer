package proj.kw.familyOrganizer.backend.restcontroller;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.InvitationDAO;
import proj.kw.familyOrganizer.backend.dto.Event;
import proj.kw.familyOrganizer.backend.dto.Invitation;
import proj.kw.familyOrganizer.backend.dto.User;



@Transactional
@Repository("invitationDAO")
public class RESTInvitation implements InvitationDAO {

	@Autowired
	private SessionFactory sessionFactory;
	
	
	
	@Override
	public List<Invitation> getEventParticipants(int event_id) {
		String query = "FROM invitation WHERE event_id = :event_id";
		
		return sessionFactory
				.getCurrentSession()
				.createQuery(query,Invitation.class)
				.setParameter("event_id", event_id)
				.getResultList();
	}
	
	
	@Override
	public Invitation getInvitationById(int id) {
		
		try {			
			return sessionFactory
					.getCurrentSession()
						.get(Invitation.class,Integer.valueOf(id));			
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}
		return null;
	}
	
	
	
	
	@Override
	public boolean isInvited(int user_id, int event_id) {
		

		String checkEmailQuery = "FROM invitation WHERE user_id = :user_id AND event_id = :event_id";

		Query query = sessionFactory.getCurrentSession().createQuery(checkEmailQuery);
		query.setParameter("user_id", user_id);
		query.setParameter("event_id", event_id);

		return !query.getResultList().isEmpty();
		
		
	}
	
	
	
	
	@Override
	public boolean addInvitation(Invitation invitation) {
		try {			
			sessionFactory.getCurrentSession().persist(invitation);			
			return true;
		}
		catch(Exception ex) {
			return false;
		}
		
	}
	
	
	

}
