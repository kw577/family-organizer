package proj.kw.familyOrganizer.backend.dao;

import java.util.List;

import proj.kw.familyOrganizer.backend.dto.Comment;



public interface CommentDAO {

	// add a comment
	boolean addComment(Comment comment);

} 