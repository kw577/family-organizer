package proj.kw.familyOrganizer.backend.dao;

import proj.kw.familyOrganizer.backend.dto.Family;

public interface FamilyDAO {

	// add an user
	int createFamilyAccount(Family family);

	
	// get by id
	Family get(int id);
	
	

} 