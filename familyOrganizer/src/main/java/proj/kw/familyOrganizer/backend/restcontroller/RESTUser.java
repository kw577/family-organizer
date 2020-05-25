package proj.kw.familyOrganizer.backend.restcontroller;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.UserDAO;
import proj.kw.familyOrganizer.backend.dto.User;

@Transactional
@Repository("userDAO")
public class RESTUser implements UserDAO{

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public boolean addUser(User user) {
		try {			
			sessionFactory.getCurrentSession().persist(user);			
			return true;
		}
		catch(Exception ex) {
			return false;
		}
	}

	@Override
	public boolean checkEmail(String email) {
		

		String checkEmailQuery = "FROM user_account WHERE email = :email";

		Query query = sessionFactory.getCurrentSession().createQuery(checkEmailQuery);
		query.setParameter("email", email);

		return query.getResultList().isEmpty();
		
		
	}
	
	
	
	@Override
	public User getByEmail(String email) {
		
		String selectQuery = "FROM user_account WHERE email = :email";
		
		try {
			return sessionFactory.getCurrentSession()
					.createQuery(selectQuery, User.class)
					.setParameter("email", email)
					.getSingleResult();
		}
		catch (Exception ex) {

			return null;
			
		}
		
		
		
	}
	
	


}