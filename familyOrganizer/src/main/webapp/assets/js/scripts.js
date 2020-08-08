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
