package proj.kw.familyOrganizer.controller;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoField;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import proj.kw.familyOrganizer.backend.dao.AttachmentDAO;
import proj.kw.familyOrganizer.backend.dao.CommentDAO;
import proj.kw.familyOrganizer.backend.dao.EmailVerificationDAO;
import proj.kw.familyOrganizer.backend.dao.EventDAO;
import proj.kw.familyOrganizer.backend.dao.FamilyDAO;
import proj.kw.familyOrganizer.backend.dao.InvitationDAO;
import proj.kw.familyOrganizer.backend.dao.NotesDAO;
import proj.kw.familyOrganizer.backend.dao.UserDAO;
import proj.kw.familyOrganizer.backend.dto.Attachment;
import proj.kw.familyOrganizer.backend.dto.Comment;
import proj.kw.familyOrganizer.backend.dto.EmailVerification;
import proj.kw.familyOrganizer.backend.dto.Event;
import proj.kw.familyOrganizer.backend.dto.Family;
import proj.kw.familyOrganizer.backend.dto.Invitation;
import proj.kw.familyOrganizer.backend.dto.User;
import proj.kw.familyOrganizer.backend.mailSending.MailSenderService;
import proj.kw.familyOrganizer.backend.registerHandler.RegisterPasswordEncoder;
import proj.kw.familyOrganizer.model.AttachmentModel;
import proj.kw.familyOrganizer.model.CommentModel;
import proj.kw.familyOrganizer.model.EventModel;
import proj.kw.familyOrganizer.model.UserModel;
import proj.kw.familyOrganizer.tools.FileUploader;

@Controller
public class PageController {
	
	@Autowired
	private HttpSession session;

	@Autowired 
	private NotesDAO notesDAO;
	
	@Autowired 
	private UserDAO userDAO;
	
	@Autowired 
	private FamilyDAO familyDAO;
	
	@Autowired 
	private EventDAO eventDAO;
	
	@Autowired
	private InvitationDAO invitationDAO;
	
	@Autowired
	private CommentDAO commentDAO;
	
	@Autowired
	private AttachmentDAO attachmentDAO;
	
	@Autowired 
	private EmailVerificationDAO emailVerificationDAO;
	  
    @Autowired
    private MailSenderService emailService;
    
    @Autowired
    private RegisterPasswordEncoder passwordCoder;
         
	
	@RequestMapping(value = {"/", "/home", "/calendar"})
	public ModelAndView startPage() {
		
		ModelAndView mv = new ModelAndView("page");
		mv.addObject("title", "Home");
		mv.addObject("isMainPage", true);
		
		return mv;
		
		
	}
	
	
	//strona z regulaminem zakupow
	@RequestMapping(value = { "/notes" })
	public ModelAndView notesPage() {

		ModelAndView mv = new ModelAndView("page");

		mv.addObject("title", "Notes");
		mv.addObject("isNotesPage", true);
		
		
		//Test
		mv.addObject("notesList", notesDAO.list());
		
		return mv;

	}


	
	
	
	@RequestMapping(value = "register", method = RequestMethod.GET)
	public ModelAndView register() {

		ModelAndView mv = new ModelAndView("register");
		mv.addObject("title", "Registration");

		User nUser = new User();
		mv.addObject("newUser", nUser);

		return mv;


	}
	
	
	// dodawanie nowego uzytkownika
	@RequestMapping(value = "register", method = RequestMethod.POST) 
	public String handleProductSubmission(@ModelAttribute("newUser") User nUser, HttpServletRequest request) { 
		
		int familyAccountID;
			
		//Check if user with this email is not in data base already
		
		if(userDAO.checkEmail(nUser.getEmail())) {
			
			//Create email verification token
			String token = UUID.randomUUID().toString();
			int tokenId = emailVerificationDAO.createVerificationToken(token, nUser.getEmail());
					
			if(emailService.sendAdminWelcomeMessage(nUser, tokenId, token, request.getRequestURL().toString())) {
				
				//Create new Family Account with default name
				Family nFamily = new Family();
				nFamily.setName("Family Account");
				familyAccountID = familyDAO.createFamilyAccount(nFamily);
				
				
				//Add Admin for family account
				nUser.setRole("ADMIN");
				nUser.setEnabled(false);
				nUser.setFamily_id(familyAccountID);
				nUser.setPassword(passwordCoder.codePassword(nUser.getPassword()));
				
				
				 userDAO.addUser(nUser);
				
			} else {
				emailVerificationDAO.delete(emailVerificationDAO.get(tokenId));
				return "redirect:/register/error?mailError";
			}
				
		} else {
			
			System.out.println("\nEmail already in use !!! \n");
			return "redirect:/register/error?mailUsedAlready";
		}
		
		return "redirect:/login?registrationInfo";
	}
	
	
	
	
	@RequestMapping(value = "register/error", method = RequestMethod.GET)
	public ModelAndView registerError(@RequestParam(name="mailError", required=false)String mailError,
			@RequestParam(name="mailUsedAlready", required=false)String mailUsedAlready) {

		ModelAndView mv = new ModelAndView("registerError");
		mv.addObject("title", "RegistrationError");


		if(mailError!=null) {
			mv.addObject("message", "Registration failure: Could not send email message ! Account was not created. Please try again.");
			
		}
		
		if(mailUsedAlready!=null) {
			mv.addObject("message", "Registration failure: Account for given email address already exist. Please use another email address.");
			
		}
		

		return mv;


	}
	
	
	
	// login
	@RequestMapping(value = { "/login" })
	public ModelAndView login(@RequestParam(name="error", required=false)String error, 
			@RequestParam(name="logout", required=false)String logout,
			@RequestParam(name="activationSuccess", required=false)String activationSuccess,
			@RequestParam(name="activationFailure", required=false)String activationFailure,
			@RequestParam(name="registrationInfo", required=false)String registrationInfo) {


		ModelAndView mv = new ModelAndView("login");
		mv.addObject("title", "Login");
		
		//Check if information about unsuccessful login will be added
		if(error!=null) {
			mv.addObject("errorMessage", "Invalid Username or Password!");

		}
		
		if(logout!=null) {
			mv.addObject("logoutMessage", "You have successfully sign out!");

		}
		
		if(activationSuccess!=null) {
			mv.addObject("activationSuccessMessage", "Email verification completed. You can now login on your account!");

		}
		
		if(activationFailure!=null) {
			mv.addObject("activationFailureMessage", "Error while trying to activate your account. Please check your email and search for activation link.");

		}
		
		if(registrationInfo!=null) {
			mv.addObject("registrationMessage", "Your admin account was successfully created, but you can not login until you will verify your email address. Please check your email box, you should find activation link there.");

		}
		

		return mv;

	}

	
	
	// access denied page - when usser is not authorized to view page
	@RequestMapping(value = { "/access-denied" }) 
	public ModelAndView accessDenied() {

		ModelAndView mv = new ModelAndView("errorPage");

		mv.addObject("errorDescription", "403 - Access Denied! You are not authorized to view this page!");

		return mv;

	}
	
	
	
	@RequestMapping(value = { "/register/emailVerification" })
	public String activateAdminAccount(@RequestParam(name="emailCode", required=false)String emailCode, 
			@RequestParam(name="token", required=false)String token) {

				
		EmailVerification emailToken =  emailVerificationDAO.get(Integer.parseInt(emailCode));
		
		if(emailToken!=null) {
			
			if(emailToken.getToken().equals(token)) {
						
				//activate account
				User user = userDAO.getByEmail(emailToken.getEmail());
				user.setEnabled(true);
				userDAO.update(user);
				
				//delete token after activation
				emailVerificationDAO.delete(emailToken);
				
				return "redirect:/login?activationSuccess";
				
			} 
			
		}
		
		return "redirect:/login?activationFailure";

	}
	
	

	
	
	//add new event page
	@RequestMapping(value = { "/createNewEvent" })
	public ModelAndView addNewEventPage() {

		ModelAndView mv = new ModelAndView("page");

		mv.addObject("title", "Add new Event");
		mv.addObject("isAddNewEventPage", true);
						
		
		EventModel eventModel = new EventModel();
		mv.addObject("newEvent", eventModel);
		
		
			
		return mv;

	}
	
	
	
	
	
	// create new event
	@RequestMapping(value = "/addNewEvent", method = RequestMethod.POST) 
	public String addNewEvent(@ModelAttribute("newEvent") EventModel eventModel) { 
		
				
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
		
		
		if(usrModel != null) {
			
			
			Event newEvent = new Event();
			
			newEvent.setFamily_id(usrModel.getFamily_id());
			newEvent.setOwner_id(usrModel.getId());
			newEvent.setTitle(eventModel.getTitle());
			
			String start_date = eventModel.getStart_day() + " " + eventModel.getStart_time();
			System.out.println("\n\n######################\nstart_date: " + start_date);
			String end_date = eventModel.getEnd_day() + " " + eventModel.getEnd_time();
			System.out.println("\nend_date: " + end_date);
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
			LocalDateTime start_date_object = LocalDateTime.parse(start_date, formatter);
			LocalDateTime end_date_object = LocalDateTime.parse(end_date, formatter);
			
			newEvent.setStart_date(start_date_object);
			newEvent.setEnd_date(end_date_object);

			newEvent.setDescription(eventModel.getDescription());
			newEvent.setLocalization(eventModel.getLocalization());
			
			
			//add new event to database
			if (end_date_object.isAfter(start_date_object)) {
				eventDAO.addEvent(newEvent);
			}
			
			
			
			
		}
		
		
		
		
		return "redirect:/home";
	}
	
	
	
	
	
	@RequestMapping(value = { "/eventsControlPanel" })
	public ModelAndView eventsControlPanel() {

		ModelAndView mv = new ModelAndView("page");

		mv.addObject("title", "Events Control Panel");
		mv.addObject("isEventsControlPanel", true);
		
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
				
		if(usrModel != null) {
		
			mv.addObject("userEventsList", eventDAO.getUserEvents(usrModel.getId()));
		
		
			Event dEvent = new Event();
			mv.addObject("delEvent", dEvent);
		
		
			Event mEvent = new Event();
			mv.addObject("modEvent", mEvent);
			
		
		}
		
					
		return mv;

	}
	
	
	
	
	
	
	
	
	// delete event
	@RequestMapping(value = "/deleteEvent", method = RequestMethod.POST) 
	public String deleteEvent(@ModelAttribute("delEvent") Event dEvent) { 

		
		//System.out.println("\n\n\n###################################\nDelete event witd id: " + dEvent.getId());
		//System.out.println("Owner id: " + dEvent.getOwner_id());
		
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {
			

			//delete only events only created by user - this if is probably not necessary
			if(usrModel.getId() == dEvent.getOwner_id()) {
				
				
				eventDAO.delete(eventDAO.getEventById(dEvent.getId()));

			}

		}
	

		return "redirect:/eventsControlPanel";
	}
	
	
	
	// edit event
	@RequestMapping(value = "/modifyEvent", method = RequestMethod.POST) 
	public String modifyEvent(@ModelAttribute("modEvent") Event mEvent) { 

		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {
			

			//modify only events only created by user - this if is probably not necessary
			if(usrModel.getId() == mEvent.getOwner_id()) {
				
				
				Event event = eventDAO.getEventById(mEvent.getId());
				
				event.setTitle(mEvent.getTitle());
				event.setDescription(mEvent.getDescription());
				event.setLocalization(mEvent.getLocalization());
				
				eventDAO.update(event);
				

			}

		}
	

		return "redirect:/eventsControlPanel";
	}
	
	
	
	
	
	//strona podgladu wydarzenia
	@RequestMapping(value = { "/viewEvent/{id}/detailView" })
	public ModelAndView viewEventPage(@PathVariable("id") String id) {

		ModelAndView mv = new ModelAndView("page");

		mv.addObject("title", "View Event");
		mv.addObject("viewEventPage", true);
					
		int eventId = -1;
		boolean dataFormatCorrect = true;
		
		try {
			eventId = Integer.parseInt(id);
			
		} catch(Exception ex) {
				
			System.err.print(ex);
			System.out.println("\n\n\nData fromat in not correct !!!");
			dataFormatCorrect = false;
		}
			
			
		UserModel usrModel = (UserModel) session.getAttribute("userModel");

		if(usrModel != null && dataFormatCorrect) {
			
			Event event = eventDAO.getEventById(eventId);
			
			if(event != null) {
				
				//Wydarzenie mo¿e zobaczyæ jego w³aœciciel lub zaproszone osoby
				if(usrModel.getId() == event.getOwner_id() || invitationDAO.isInvited(usrModel.getId(), eventId)) {
						
					mv.addObject("viewEvent", event);
							
					
					//List of invited people
					List<User> peopleInvited = new ArrayList<User>();
					//List of not invited people
					List<User> peopleNotInvited = new ArrayList<User>();
					
					
					List<User> familyMembers = userDAO.getFamilyMembers(usrModel.getFamily_id());
					List<Invitation> invitationList = invitationDAO.getEventParticipants(eventId);
					ArrayList<Integer> invitationsId = new ArrayList<Integer>();
					
					User eventOwner = new User();
					
					
					for (Invitation invitation : invitationList) {
						invitationsId.add(invitation.getUser_id());
						
					}
					
					
					/*
					System.out.println("\n\n\n##########################\nInvitation list:");
					for (Integer test : invitationsId) {
						System.out.println(" " + test);
						
					}
					*/
					for (User familyMember : familyMembers) {
						if(familyMember.getId() == event.getOwner_id()) {
							eventOwner = familyMember;
						}
						else if (invitationsId.contains(familyMember.getId())) {
							peopleInvited.add(familyMember);
						} else {
							peopleNotInvited.add(familyMember);
						}
						
					}
					
					
					/*
					System.out.println("\n\n\n##########################\nPeople invited:");
					for (User test : peopleInvited) {
						System.out.println(" " + test.getName() + " " + test.getSurname());
						
					}
					
					System.out.println("\n\n\n##########################\nPeople not invited:");
					for (User test : peopleNotInvited) {
						System.out.println(" " + test.getName() + " " + test.getSurname());
						
					}
					*/
					
					mv.addObject("eventOwner", eventOwner);
					mv.addObject("peopleInvited", peopleInvited);
					mv.addObject("peopleNotInvited", peopleNotInvited);
					
					
					//Add list of comments
					
					List<Comment> eventComments = commentDAO.getCommentsList(eventId);
					
					List<CommentModel> eventCommentsEdited = new ArrayList<CommentModel>();
					
					//System.out.println("Ilosc komentarzy: " + eventComments.size());
					HashMap<Integer, String> eventsCommentsHelper = new HashMap<Integer, String>();
					
					for (User familyMember : familyMembers) {
						eventsCommentsHelper.put(familyMember.getId(), familyMember.getName() + " " + familyMember.getSurname());
					}
					
					//System.out.println(eventsCommentsHelper);
					//System.out.println("\n\nTest: " + eventsCommentsHelper.get(39));
					
					for (Comment eventComment : eventComments) {
						
											
						eventCommentsEdited.add(new CommentModel(
								eventComment.getOwner_id(),
								eventsCommentsHelper.get(eventComment.getOwner_id()), 
								eventComment.getDate_posted().toString().replaceAll("T", " ").substring(0, 16), 
								eventComment.getDescription()));
						
					}
					
					
					
					/*
					for (CommentModel test : eventCommentsEdited) {
						System.out.println("\n" + test.getDate_posted() + " " + test.getOwner());
						
					}
					*/
					
					
					mv.addObject("listOfComments", eventCommentsEdited);
					
					
					
					
					//add list of attachments
					List<Attachment> eventAttachments = attachmentDAO.getAttachmentsList(eventId);	
					List<AttachmentModel> eventAttachmentsEdited = new ArrayList<AttachmentModel>();
					
					for (Attachment eventAttachment : eventAttachments) {
						
											
						eventAttachmentsEdited.add(new AttachmentModel(
						eventAttachment.getOwner_id(),
						eventsCommentsHelper.get(eventAttachment.getOwner_id()), 
						eventAttachment.getDate_posted().toString().replaceAll("T", " ").substring(0, 16), 
						eventAttachment.getCode()));
						
					}
					
										
					mv.addObject("listOfAttachments", eventAttachmentsEdited);
					
					
				}
					
			}

			
		}
		
		//Invitations
		Invitation nInvitation = new Invitation();
		mv.addObject("newInvitation", nInvitation);
		
		Invitation dInvitation = new Invitation();
		mv.addObject("delInvitation", dInvitation);
		
		//Comment
		Comment nComment = new Comment();
		mv.addObject("newComment", nComment);
		
		Event dEvent = new Event();
		mv.addObject("deleteEvent", dEvent);
		
		Event mEvent = new Event();
		mv.addObject("modifyEvent", mEvent);
		
		Attachment nAttachment = new Attachment();
		mv.addObject("newAttachment", nAttachment);
		
		
		
		return mv;

	}

	
	
	
	
	
	
	
	
	
	// new Invitation
	@RequestMapping(value = "/addNewInvitation", method = RequestMethod.POST) 
	public String createNewInvitation(@ModelAttribute("newInvitation") Invitation nInvitation) { 

	
		//System.out.println("\n\n\n######################\nInvitation for event id: " + nInvitation.getEvent_id());
		//System.out.println("user id: " + nInvitation.getUser_id() + "\n#########################\n\n\n");
		
		
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {

			if(usrModel.getId() == eventDAO.getEventById(nInvitation.getEvent_id()).getOwner_id()) {
				invitationDAO.addInvitation(nInvitation);
			}

		}



		return "redirect:/viewEvent/" + nInvitation.getEvent_id() + "/detailView";
	}
	
	
	
	
	
	
	// delete invitation
	@RequestMapping(value = "/deleteInvitation", method = RequestMethod.POST) 
	public String deleteInvitation(@ModelAttribute("delInvitation") Invitation dInvitation) { 


		System.out.println("\n\n\n###################################\nDelete invitation for user witd id: " + dInvitation.getUser_id());
		System.out.println("Event id: " + dInvitation.getEvent_id());


		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {


			if(usrModel.getId() == eventDAO.getEventById(dInvitation.getEvent_id()).getOwner_id()) {
				invitationDAO.delete(invitationDAO.getByEventIdAndOwner(dInvitation.getEvent_id(), dInvitation.getUser_id()));
			}

		}


		return "redirect:/viewEvent/" + dInvitation.getEvent_id() + "/detailView";
	}
	
	
	
	
	
	
	
	// new comment
	@RequestMapping(value = "/addComment", method = RequestMethod.POST) 
	public String addNewComment(@ModelAttribute("newComment") Comment nComment) { 

	
		//System.out.println("\n\n\n######################\nComment for event id: " + nComment.getEvent_id());
		//System.out.println("comment: " + nComment.getDescription() + "\n#########################\n\n\n");
		
		
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {

			
			if(usrModel.getId() == eventDAO.getEventById(nComment.getEvent_id()).getOwner_id() || invitationDAO.isInvited(usrModel.getId(), nComment.getEvent_id())) {
				
				Comment comment = new Comment();
				comment.setOwner_id(usrModel.getId());
				comment.setEvent_id(nComment.getEvent_id());
				comment.setDescription(nComment.getDescription());		
				comment.setDate_posted(LocalDateTime.now());
				
						
				commentDAO.addComment(comment);
				
				
			}

		}



		return "redirect:/viewEvent/" + nComment.getEvent_id() + "/detailView";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// delete event via event detail page
	@RequestMapping(value = "/viewEvent/deleteEvent", method = RequestMethod.POST) 
	public String deleteEvent2(@ModelAttribute("deleteEvent") Event dEvent) { 

	
		UserModel usrModel = (UserModel) session.getAttribute("userModel");

		if(usrModel != null) {

			//delete only events only created by user - this if is probably not necessary
			if(usrModel.getId() == dEvent.getOwner_id()) {

				eventDAO.delete(eventDAO.getEventById(dEvent.getId()));

			}

		}

		return "redirect:/home";
	}
	
	
	
	
	
	
	
	
	
	
	// edit event via event detail page
	@RequestMapping(value = "/viewEvent/modifyEvent", method = RequestMethod.POST) 
	public String modifyEvent2(@ModelAttribute("modifyEvent") Event mEvent) { 


		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {


			//modify only events only created by user - this if is probably not necessary
			if(usrModel.getId() == mEvent.getOwner_id()) {


				Event event = eventDAO.getEventById(mEvent.getId());

				event.setTitle(mEvent.getTitle());
				event.setDescription(mEvent.getDescription());
				event.setLocalization(mEvent.getLocalization());

				eventDAO.update(event);


			}

		}


		return "redirect:/viewEvent/" + mEvent.getId() + "/detailView";
	}
	
	
	
	
	// delete event via timeline page
	@RequestMapping(value = "/timeline/deleteEvent", method = RequestMethod.POST) 
	public String deleteEvent3(@ModelAttribute("deleteEvent") Event dEvent) { 

	
		UserModel usrModel = (UserModel) session.getAttribute("userModel");

		if(usrModel != null) {

			//delete only events only created by user - this if is probably not necessary
			if(usrModel.getId() == dEvent.getOwner_id()) {

				eventDAO.delete(eventDAO.getEventById(dEvent.getId()));

			}

		}

		return "redirect:/timeline/";
	}
	
	
	
	
	
	
	
	// edit event via event detail page
	@RequestMapping(value = "/timeline/modifyEvent", method = RequestMethod.POST) 
	public String modifyEvent3(@ModelAttribute("modifyEvent") Event mEvent) { 


		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {


			//modify only events only created by user - this if is probably not necessary
			if(usrModel.getId() == mEvent.getOwner_id()) {


				Event event = eventDAO.getEventById(mEvent.getId());

				event.setTitle(mEvent.getTitle());
				event.setDescription(mEvent.getDescription());
				event.setLocalization(mEvent.getLocalization());

				eventDAO.update(event);


			}

		}


		return "redirect:/timeline";
	}
	
	
	
	
	
	// new attachment
	@RequestMapping(value = "/addAttachment", method = RequestMethod.POST) 
	public String addNewAttachment(@ModelAttribute("newAttachment") Attachment nAttachment, HttpServletRequest request) { 

	
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {
			
			
			if(usrModel.getId() == eventDAO.getEventById(nAttachment.getEvent_id()).getOwner_id() || invitationDAO.isInvited(usrModel.getId(), nAttachment.getEvent_id())) {
				
				
				
				LocalDateTime now = LocalDateTime.now();
				Instant instant = now.atZone(ZoneId.systemDefault()).toInstant();	
				long timeInMillis = instant.toEpochMilli();
						
				String code = nAttachment.getEvent_id() + "_" + usrModel.getId() + "_" + timeInMillis;	
				
				if(!nAttachment.getFile().getOriginalFilename().equals("")) {
					
					if(FileUploader.uploadFile(request, nAttachment.getFile(), code)) {
						
						Attachment attachment = new Attachment();				
						
						attachment.setEvent_id(nAttachment.getEvent_id());
						attachment.setOwner_id(usrModel.getId());
						attachment.setDate_posted(now);
						attachment.setCode(code);
					
											
						attachmentDAO.addAttachment(attachment);
						
						
					}
				}
				
				
			}

		}



		return "redirect:/viewEvent/" + nAttachment.getEvent_id() + "/detailView";
	}
	
	
	
	
	
	@RequestMapping(value = { "/timeline" })
	public ModelAndView timelinePage() {

		ModelAndView mv = new ModelAndView("page");

		mv.addObject("title", "Timeline Page");
		mv.addObject("isTimelinePage", true);
		
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");
				
		if(usrModel != null) {
		
			
			
			List<Event> allEventsList = eventDAO.getEventsByFamily(usrModel.getFamily_id());
			List<Event> finalEventsList = new ArrayList<Event>();	
			List<Invitation> userInvitationsList = invitationDAO.getUserInvitations(usrModel.getId());
					
			ArrayList<Integer> eventsWithInvitation = new ArrayList<Integer>();	
			
			for (Invitation invitation : userInvitationsList) {
				eventsWithInvitation.add(invitation.getEvent_id());
				
			}
			
	
			for (Event nextEvent : allEventsList) {
				if(nextEvent.getOwner_id() == usrModel.getId() || eventsWithInvitation.contains(nextEvent.getId())) {
					finalEventsList.add(nextEvent);
				}
					
			}
			
			
					
			mv.addObject("listOfUserEvents", finalEventsList);
			
				
				
			Event dEvent = new Event();
			mv.addObject("delEvent", dEvent);
			
			
			Event mEvent = new Event();
			mv.addObject("modEvent", mEvent);
			
		
		}
		
					
		return mv;

	}
	
	
	
	
	
	// edit event via event detail page
	@RequestMapping(value = "/searchEvent") 
	public ModelAndView searchEventByKeyword(@RequestParam("searchPhrase") String searchPhrase) { 

		ModelAndView mv = new ModelAndView("page");
		
		mv.addObject("title", "Search Event Page");
		mv.addObject("isSearchEventPage", true);
		
		//System.out.println("\n\n\nKeyword: " + searchPhrase + "\n\n\n\n");
		
		UserModel usrModel = (UserModel) session.getAttribute("userModel");


		if(usrModel != null) {
			
			
			
			List<Event> allEventsList = eventDAO.searchEventsWithKeyword(usrModel.getFamily_id(), searchPhrase);
			List<Event> finalEventsList = new ArrayList<Event>();	
			List<Invitation> userInvitationsList = invitationDAO.getUserInvitations(usrModel.getId());
					
			ArrayList<Integer> eventsWithInvitation = new ArrayList<Integer>();	
			
			for (Invitation invitation : userInvitationsList) {
				eventsWithInvitation.add(invitation.getEvent_id());
				
			}
			
	
			for (Event nextEvent : allEventsList) {
				if(nextEvent.getOwner_id() == usrModel.getId() || eventsWithInvitation.contains(nextEvent.getId())) {
					finalEventsList.add(nextEvent);
				}
					
			}
			
			
					
			mv.addObject("listOfUserEvents", finalEventsList);
			
			
			
			
			Event dEvent = new Event();
			mv.addObject("delEvent", dEvent);
			
			
			Event mEvent = new Event();
			mv.addObject("modEvent", mEvent);

		}


		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
