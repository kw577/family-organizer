package proj.kw.familyOrganizer.backend.dao;

import java.util.List;

import proj.kw.familyOrganizer.backend.dto.Attachment;


public interface AttachmentDAO {

	// add a comment
	boolean addAttachment(Attachment attachment);
	
	//get all attachments for selected event
	List<Attachment> getAttachmentsList(int event_id);
	
} 