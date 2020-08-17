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






function fillModifyUserAccountForm(email, name, surname) {
	
	//console.log(email);

	oFormObject = document.forms['modifyUserAccountForm'];
	oFormObject.elements["email"].value = email;
	oFormObject.elements["name"].value = name;
	oFormObject.elements["surname"].value = surname;

}





$modifyUserAccountForm = $("#modifyUserAccountForm") 
if($modifyUserAccountForm.length) {
	$modifyUserAccountForm.validate({			
			rules: {
				name: {
					required: true,
					minlength: 3
				},
				surname: {
					required: true,
					minlength: 3
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




// Formularz tworzenia nowego wydarzenia - datepicker
$( function() {
    $( "#start_day" ).datepicker({
    	dateFormat: 'yy-mm-dd',
    	defaultDate: 0,
    	firstDay: 0, //sobota jako poczatek tygodnia w kalendarzu
    	minDate: 0, //nie mozna wybrac wczesniejszej daty niz dzisiejsza
    	showButtonPanel: false,
    	changeMonth: true,
    	changeYear: true
    	
    });
   
  } );



$( function() {
    $( "#end_day" ).datepicker({
    	dateFormat: 'yy-mm-dd',
    	defaultDate: 0,
    	firstDay: 0, //sobota jako poczatek tygodnia w kalendarzu
    	minDate: 0, //nie mozna wybrac wczesniejszej daty niz dzisiejsza
    	showButtonPanel: false
    	//changeMonth: true,
    	//changeYear: true
    	
    });
   
  } );




/* Time picker ver 1
$('#start_time').timepicker({
    timeFormat: 'HH:mm',
    interval: 15,
    minTime: '00:00',
    maxTime: '23:30',
    defaultTime: '11',
    startTime: '00:00',
    dynamic: false,
    dropdown: true,
    scrollbar: true
});
*/

//timepicker ver 2
$('#start_time').timepicker();

$('#end_time').timepicker();




$addNewEventForm = $("#addNewEventForm") 
if($addNewEventForm.length) {
	
	$.validator.addMethod('dateAfter', function (value, element, params) {
        // if start date is valid, validate it as well
		var start_time = $("#start_time").val();
        var end_time = $('#end_time').val();
		
        if(start_time != ""){
        	
        	var start_date = new Date($(params).val() + " " + start_time);
        	
        }
        
        if(end_time != ""){
        	
        	var end_date = new Date(value + " " + end_time);
        	
        }
		
        var start = $(params);

        return this.optional(element) || this.optional(start[0]) || end_date > start_date;

    }, 'Must be after corresponding start date');
	
	
	$addNewEventForm.validate({			
			rules: {
				title: {
					required: true,
					minlength: 3
				},
				start_day: {
					required: true
				},
				start_time: {
					required: true
				},
				end_day: {
					required: true,
					dateAfter: '#start_day'
				},
				end_time: {
					required: true
				},
				description: {
					required: true,
					minlength: 3
				},
				localization: {
					required: true,
					minlength: 3
				},
				
			},
			messages: {					
				title: {
					required: 'This field can not be empty!',
					minlength: 'This field must cantain at least 3 characters'
				},
				start_day: {
					required: 'This field can not be empty!',
				},
				start_time: {
					required: 'This field can not be empty!',
				},
				end_day: {
					required: 'This field can not be empty!',
				},
				end_time: {
					required: 'This field can not be empty!',
				},
				description: {
					required: 'This field can not be empty!',
					minlength: 'This field must cantain at least 3 characters'
				},
				localization: {
					required: 'This field can not be empty!',
					minlength: 'This field must cantain at least 3 characters'
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



























