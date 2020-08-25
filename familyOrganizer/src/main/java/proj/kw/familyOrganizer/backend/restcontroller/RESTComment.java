package proj.kw.familyOrganizer.backend.restcontroller;

import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.CommentDAO;
import proj.kw.familyOrganizer.backend.dto.Comment;
import proj.kw.familyOrganizer.backend.dto.Event;



@Transactional
@Repository("commentDAO")
public class RESTComment implements CommentDAO {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public boolean addComment(Comment comment) {
		try {			
			sessionFactory.getCurrentSession().persist(comment);			
			return true;
		}
		catch(Exception ex) {
			return false;
		}
		
	}

	
	@Override
	public List<Comment> getCommentsList(int event_id) {
		String query = "FROM comment WHERE event_id = :event_id order by date_posted";
		
		return sessionFactory
				.getCurrentSession()
				.createQuery(query, Comment.class)
				.setParameter("event_id", event_id)
				.getResultList();
	}
	
	


}