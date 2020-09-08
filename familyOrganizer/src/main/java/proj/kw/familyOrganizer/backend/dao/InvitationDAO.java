package proj.kw.familyOrganizer.backend.dao;

import java.util.List;

import proj.kw.familyOrganizer.backend.dto.Invitation;


public interface InvitationDAO {

	
	List<Invitation> getEventParticipants(int event_id);
	
	//get event by id
	Invitation getInvitationById(int id);
	
	//check if user is Invited
	boolean isInvited(int user_id, int event_id);
		
	// add new invitation
	boolean addInvitation(Invitation invitation);
	
	//delete invitation
	boolean delete(Invitation invitation);
	
	
	//get invitation by owner and event_id
	Invitation getByEventIdAndOwner(int event_id, int user_id);
	
	//get all invitations for selected user
	List<Invitation> getUserInvitations(int user_id);
	
	
}
