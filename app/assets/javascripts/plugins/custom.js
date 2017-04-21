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

  $(".notice").addClass("notice_show");
   $(".cross").click(function(){
     $(".notice").fadeOut(500);
   });
 // setInterval(function(){ $(".notice").fadeOut(100) }, 3000);
  $(".notice").fadeOut(10000)
})