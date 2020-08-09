//Admin Panel - edit famiily account
$(document).ready(function() {
	$("#editFamilyAccountButton").on("click", function(event) {
		var modal = bootbox.dialog({
			message : $("#editFamilyAccountForm-content").html(),
			size: 'medium',
			//centerVertical: true,
			title : "Edit your Family Account",
			buttons : [ {
				label : "Save",
				className : "btn btn-primary pull-left",
				callback : function() {

					//$.post(activationUrl, function(data) {
					//	bootbox.alert({
					//		size: 'medium',
					//		title: 'Information',
					//		message: activationUrl
					//	});
					//})
					document.getElementById("editFamilyAccountForm-content").innerHTML = "";
					document.getElementById("editFamilyAccountForm").submit();
					
					console.log("User submitted the changes");
					
				}
			}, {
				label : "Close",
				className : "btn btn-default pull-left",
				callback : function() {
					console.log("User cancelled the changes");
				}
			} ],
			show : false,
			onEscape : function() {
				modal.modal("hide");
			}
		});

		modal.modal("show");
	});

});


$addNewUserForm = $("#addNewUserForm") 
if($addNewUserForm.length) {
	$addNewUserForm.validate({			
			rules: {
				name: {
					required: true,
					minlength: 3
				},
				surname: {
					required: true,
					minlength: 3
				},
				email: { 
					required: true,
					email: true,
					minlength: 5					
				}
			},
			messages: {					
				name: {
					required: 'This field can not be empty!',
					minlength: 'Name field must cantain at least 3 characters'
				},
				surname: {
					required: 'This field can not be empty!',
					minlength: 'Surname field must cantain at least 3 characters'
				},
				email: {
					required: 'This field can not be empty!',
					minlength: 'Enter a valid email address!',
					email: 'Enter a valid email address!'
				}	
										
			},
			errorElement : "em",
			errorPlacement : function(error, element) {
				error.addClass('formAlerts');
					
				error.insertBefore(element);
					
					
			}				
		}
	);
}

