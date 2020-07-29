package proj.kw.familyOrganizer.backend.restcontroller;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.EmailVerificationDAO;
import proj.kw.familyOrganizer.backend.dto.EmailVerification;


@Transactional
@Repository("emailVerificationDAO")
public class RESTEmailVerification implements EmailVerificationDAO {

	int newTokenId = -1;
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public int createVerificationToken(String token, String email) {
		
		EmailVerification emailToken = new EmailVerification();
		emailToken.setEmail(email);
		emailToken.setToken(token);
		
		try {		
			
			newTokenId = (int) sessionFactory.getCurrentSession().save(emailToken);		
			
			//sessionFactory.getCurrentSession().getTransaction().commit();

			return newTokenId;
		}
		catch(Exception ex) {
			System.out.println(ex);
			return -1;
		}
	}

	@Override
	public EmailVerification get(int tokenId) {
		
		try {			
			return sessionFactory
					.getCurrentSession()
						.get(EmailVerification.class,Integer.valueOf(tokenId));			
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}
		return null;
	}

	@Override
	public boolean delete(EmailVerification token) {
		try {			
			sessionFactory
					.getCurrentSession()
						.delete(token);
			return true;
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}		
		return false;		
	
	
	}


}