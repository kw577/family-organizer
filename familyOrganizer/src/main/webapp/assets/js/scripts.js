$editFamilyAccountForm = $("#editFamilyAccountForm") 
if($editFamilyAccountForm.length) {
	$editFamilyAccountForm.validate({			
			rules: {
				name: {
					required: true,
					minlength: 3
				}
			},
			messages: {					
				name: {
					required: 'This field can not be empty!',
					minlength: 'Name field must cantain at least 3 characters'
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







function fillDeleteUserAccountForm(email, name, surname) {
	
	//window.alert(email);
	//console.log(email);
	document.getElementById("deleteUserAccountInfo").innerHTML = name + " " + surname;
	
	oFormObject = document.forms['deleteUserAccountForm'];
	oFormObject.elements["email"].value = email;
	
	
	
	
	
	

}



















