$(document).ready(function(){
	$("#role").change(function(){
		if($(this).val()=="user")
		{
		  $.ajax({
		    url: "/users/patients",
		    type: "GET",
		    data_type: 'js'
		  });
		}else{$("#patient_list").html("")}	
	})
})
