package proj.kw.familyOrganizer.backend.restcontroller;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import proj.kw.familyOrganizer.backend.dao.NotesDAO;
import proj.kw.familyOrganizer.backend.dto.Notes;


@Transactional
@Repository("notesDAO")
public class RESTNotes implements NotesDAO{

	@Autowired
	private SessionFactory sessionFactory;



	//zwraca liste wszssytkich aktywnych kategorii
	@Override
	public List<Notes> list() {

		String selectActiveCategory = "FROM Notes WHERE active = :active";

		Query query = sessionFactory.getCurrentSession().createQuery(selectActiveCategory);
		query.setParameter("active", true);

		return query.getResultList();
	}


	//zwraca pojedyncza kategorie
	@Override
	public Notes getSingleNote(int id) {

		return sessionFactory.getCurrentSession().get(Notes.class, Integer.valueOf(id));

	}






}