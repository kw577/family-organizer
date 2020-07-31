package proj.kw.familyOrganizer.backend.restcontroller;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.FamilyDAO;
import proj.kw.familyOrganizer.backend.dto.Family;


//Add new family account and return it's Id number
@Transactional
@Repository("familyDAO")
public class RESTFamily implements FamilyDAO {

	int newAccountId = -1;
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public int createFamilyAccount(Family family) {
		try {		
			
			newAccountId = (int) sessionFactory.getCurrentSession().save(family);		
			
			//sessionFactory.getCurrentSession().getTransaction().commit();

			return newAccountId;
		}
		catch(Exception ex) {
			System.out.println(ex);
			return -1;
		}
	}

	@Override
	public Family get(int id) {
		
		try {			
			return sessionFactory
					.getCurrentSession()
						.get(Family.class,Integer.valueOf(id));			
		}
		catch(Exception ex) {		
			ex.printStackTrace();			
		}
		return null;
		
	}


}