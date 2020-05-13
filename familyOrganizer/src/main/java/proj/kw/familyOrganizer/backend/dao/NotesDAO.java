package proj.kw.familyOrganizer.backend.dao;
import proj.kw.familyOrganizer.backend.dto.Notes;

import java.util.List;


public interface NotesDAO {


	//lista wszystkich aktywnych kategorii
	List<Notes> list();

	//zwraca pojedyncza kategorie
	Notes getSingleNote (int id);

} 