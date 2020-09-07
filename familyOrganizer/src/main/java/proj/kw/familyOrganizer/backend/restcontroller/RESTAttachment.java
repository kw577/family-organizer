package proj.kw.familyOrganizer.backend.restcontroller;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.AttachmentDAO;
import proj.kw.familyOrganizer.backend.dto.Attachment;




@Transactional
@Repository("attachmentDAO")
public class RESTAttachment implements AttachmentDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public boolean addAttachment(Attachment attachment) {
		try {			
			sessionFactory.getCurrentSession().persist(attachment);			
			return true;
		}
		catch(Exception ex) {
			return false;
		}
		
	}
	
	
	@Override
	public List<Attachment> getAttachmentsList(int event_id) {
		String query = "FROM attachment WHERE event_id = :event_id order by date_posted";
		
		return sessionFactory
				.getCurrentSession()
				.createQuery(query, Attachment.class)
				.setParameter("event_id", event_id)
				.getResultList();
	}


}