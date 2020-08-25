package proj.kw.familyOrganizer.backend.dao;

import java.util.List;

import proj.kw.familyOrganizer.backend.dto.Comment;
import proj.kw.familyOrganizer.backend.dto.Event;



public interface CommentDAO {

	// add a comment
	boolean addComment(Comment comment);
	
	//get all comments about selected event
	List<Comment> getCommentsList(int event_id);

} 