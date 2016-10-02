<?php

 require_once('../loadFiles.php');
 $logged = $c->checkUserLogin();
?>
<html>
	<head>
	<link href='fullcalendar.css' rel='stylesheet' />
<link href='scheduler.css' rel='stylesheet' />
<script src='jquery.min.js'></script>
<script src='moment.min.js'></script>
<script src='bootstrap.min.js'></script>
<script src='fullcalendar.js'></script>
<script src='scheduler.js'></script>
	<style>
	
	div.tables {
		float: left;
		border: 1px solid black;
		margin: 70px;
	
	}
	
	div.login {
		float: right;
		margin:30px;
	}
	
	.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    padding-top: 100px; /* Location of the box */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: rgb(0,0,0); /* Fallback color */
    background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

.modal-body	 {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    //border: 1px solid #888;
    width: 30%;
}
.modal-header	 {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    //border: 1px solid #888;
    width: 30%;
}

.modal-footer	 {
    background-color: #fefefe;
    margin: auto;
    padding: 20px;
    //border: 1px solid #888;
    width: 30%;
}
	
	</style>
	
	
		<script>
		
			var userType = 0;
			var userID = -1;
			var doctorDisplayed = 1;
			var events;
			var success;
			
			//The URL for the webservice requests
			var Webservice_URL = window.location.host; 
			var port = location.port;
			if (port == "")
				var redirectPath = Webservice_URL;
			else
				var redirectPath = Webservice_URL+":"+port;
			console.log(redirectPath);
		
			//Populates the table with users' records
			function initializeListOfUsers()
			{					
				//AJAX Request
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() { //Callback
				
					//REPLY FROM WEBSERVICE
					if (xhttp.readyState == 4 && xhttp.status == 200) {
						
						//Receive and decode the response to JSON object
						var response = JSON.parse(xhttp.responseText);
						
						//Check if the success returned was false
						if (!response.success)
							alert(response.message); //Displays the error message returned from the server
						else //If everything was okay
						{
							//Generate the html that contains the users' information
							var html = "";
							for (var index in response.data) 	//response.data contains the array of user objects
																//each userObject contain the id and name of a user
							{
								var userObject = response.data[index]; //Get the user at a specific index
								html += "<tr>";
									html += "<td>" + userObject.time + "</td>";
									html += "<td>" + userObject.pid + "</td>";
									html += "<td>" + userObject.comment + "</td>";
								html += "</tr>";
								
							}
							
							//Populate the table body rows with the html generated
							//console.log(html);
							document.getElementById("listOfPatientsTable").innerHTML = html;
						}
					}
				};
				
				//REQUEST TO WEBSERVICE
				
				//xhttp.open("GET", Webservice_URL + "?method=getUsers", true);
				//console.log("got ");
				xhttp.open("GET", "../webservice/webservice.php?method=getUsers", true);
				xhttp.send();
				
			}
		
			
			
			function addAppt(comment,start,did)
			{
				//Gets the name of the user to be added
				
				success = false;
				
				//AJAX Request
				var xhttp = new XMLHttpRequest();
				xhttp.onreadystatechange = function() { //Callback
				
					//REPLY FROM WEBSERVICE
					if (xhttp.readyState == 4 && xhttp.status == 200) {
					
						//Receive and decode the response to JSON object
						var response = JSON.parse(xhttp.responseText);
						
						//Check if the success returned was false
						if (!response.success)
							{
							success = false;
							alert(response.message);
							
							}//Displays the error message returned from the server
						else //If everything was okay
						{	
							//Clears the textbox
							
							//Displays the message returned from the server
							success = true;
							alert(response.message);
							
							
							//Refreshes the list in the table to include the new user
							//initializeListOfUsers();
							
						}
					}
				}
				
				
				//REQUEST TO WEBSERVICE
				xhttp.open("GET", "../webservice/webservice.php?method=addAppt&comment=" + comment + "&start="+start + "&did="+did, false);
				xhttp.send();

			}
			

			
		</script>
	</head>
	
	<body> 
	<!-- Once the page loads, it will call the "initializeListOfUsers" function to populate the table with records -->
	
	
	<script>
	
	function getData(start, end)
	{
		var noAccess = "Appointment";
		
			var xhttp = new XMLHttpRequest();
			
			
			//REQUEST TO WEBSERVICE
			
			console.log("start:" + start);
			console.log("end: " + end);
			xhttp.open("GET", "../webservice/webservice.php?method=getApptPatient&start=" + start + "&end=" + end+"&did=" + doctorDisplayed, false);
			xhttp.send();
			console.log(xhttp.responseText);
			var response = JSON.parse(xhttp.responseText);
			
			//Check if the success returned was false
			if (!response.success)
				alert("Can't fetch schedule"); //Displays the error message returned from the server
			else //If everything was okay
			{
				//Generate the html that contains the users' information
				var test = [];
				for (var index in response.data) 	//response.data contains the array of user objects
													//each userObject contain the id and name of a user
				{
					var userObject = response.data[index]; //Get the user at a specific index
					
						var add = {id : userObject.pid, title : userObject.comment, start: userObject.time};
					test.push(add);
					
				}

				return test;
			}
			

		
	}

	function getOffData(start, end)
	{
		var noAccess = "Appointment";
		
		var xhttp = new XMLHttpRequest();
		
		
		//REQUEST TO WEBSERVICE
		
		
		xhttp.open("GET", "../webservice/webservice.php?method=getNotWorking&start=" + start + "&end=" + end+"&did=" + doctorDisplayed, false);
		xhttp.send();
		console.log(xhttp.responseText);
		var response = JSON.parse(xhttp.responseText);
		
		//Check if the success returned was false
		if (!response.success)
			alert("Error: Appointment not added" ); //Displays the error message returned from the server
		else //If everything was okay
		{
			//Generate the html that contains the users' information
			var test = [];
			for (var index in response.data) 	//response.data contains the array of user objects
												//each userObject contain the id and name of a user
			{
				var userObject = response.data[index]; //Get the user at a specific index

				var start = userObject.time;
				var splitter = start.split(" ");
				var end = splitter[0] + " 18:00:00";
				var add = {id: 'N/A', title : userObject.comment, start: userObject.time, end: end, color: 'rgb(200,0,0)'};
				test.push(add);
				
			}
			
			return test;
		

		}
	}
	
	function getCalendarDateRange() {
        var calendar = $('#calendar').fullCalendar('getCalendar');
        var view = calendar.view;
        var start = view.start._d;
        var end = view.end._d;
        var dates = { start: start, end: end };
        return dates;
    }
	
	function refresh(start,end) { // document ready
		
		
		
		events = getData(start,end);
		offDays = getOffData(start,end);
		
		$('#calendar').fullCalendar('removeEvents');
		$('#calendar').fullCalendar('addEventSource', events);
		$('#calendar').fullCalendar('addEventSource', offDays);
		$('#calendar').fullCalendar( 'rerenderEvents' );

				
		
		  
		};
		
		$(function() { // document ready
			  
			
			
			events = getData();
			
			var d = new Date();
			var month = d.getMonth() + 1;
			
			var date = d.getFullYear() + "-" + month + "-" + d.getDate();
			
					
			  $('#calendar').fullCalendar({
				  defaultTimedEventDuration: '00:30:00',
			      forceEventDuration: true,
				  minTime: "09:00:00",
				  maxTime: "18:00:00",
				  height: 520,
				  allDaySlot: false,
				  customButtons: {
				        Doctor1: {
				            text: 'Doctor 1',
				            click: function(){
				            	doctorDisplayed = 1;
				            	var startDate = moment(getCalendarDateRange().start).format('YYYY-MM-DD');
				            	var endDate = moment(getCalendarDateRange().end).format('YYYY-MM-DD');

				            	refresh(startDate, endDate);
				            }
				            
				        },
			  
					  Doctor2: {
				            text: 'Doctor 2',
				            click: function(){
				            	doctorDisplayed = 2;
				            	var startDate = moment(getCalendarDateRange().start).format('YYYY-MM-DD');
				            	var endDate = moment(getCalendarDateRange().end).format('YYYY-MM-DD');

				            	refresh(startDate, endDate);
				            }
				            
				        }
				    },
			    header: {
			      left: 'prev,next today Doctor1 Doctor2',
			      center: 'title',
			      right: 'month,agendaWeek,agendaDay'
			    },
			    viewRender: function (view,element) {
				    var startDate = moment(getCalendarDateRange().start).format('YYYY-MM-DD');
            		var endDate = moment(getCalendarDateRange().end).format('YYYY-MM-DD');

            		refresh(startDate, endDate);
			    },
			    defaultDate: $('#calendar').fullCalendar('today'),
			    defaultView: 'agendaWeek',
			    selectable: true,
			    editable: false,
			    eventLimit: true, // allow "more" link when too many events
			    events: events,
			    select: function(start, end, allDay) {
			    	  var endtime;
			    	  var starttime;
			          endtime = moment(end).format('h:mm a');//$.fullCalendar.formatDate(end,'h:mm tt');
			          starttime = moment(start).format('ddd,MMM D, h:mm a');//$.fullCalendar.formatDate(start,'ddd, MMM d, h:mm tt');
			          var mywhen = starttime + ' - ' + endtime;
			          
			          $('#createEventModal #apptStartTime').val(start);
			          $('#createEventModal #apptEndTime').val(end);
			          $('#createEventModal #apptAllDay').val(allDay);
			          $('#createEventModal #when').text(mywhen);
			          $('#createEventModal').modal('show');
			       }
			  });
			   	
			  $('#submitButton').on('click', function(e){
				    e.preventDefault();

				    doSubmit();
			  });
			  
			  function doSubmit(){
				    $("#createEventModal").modal('hide');
				    
				    var startDate = new Date($('#apptStartTime').val());
				    startDate.setTime( startDate.getTime() + startDate.getTimezoneOffset()*60*1000 );
				    var year = startDate.getFullYear();
				    var month = startDate.getMonth() + 1;
				    var day = startDate.getDate();
				    var hour = startDate.getHours();
				    var minute = startDate.getMinutes();
				    if (minute < 10)
				    	minute = "0"+minute;
				    if (day < 10)
				    	day = "0"+day;
				    if (hour < 10)
				    	hour = "0"+hour;
				    if (month < 10)
				    	month = "0"+month;
				    	var date = year+"-"+month+"-"+day+"/"+hour+":"+minute+":00";
				    var endDate = new Date($('#apptEndTime').val());
				    endDate.setTime( endDate.getTime() + endDate.getTimezoneOffset()*60*1000 );
				        
				    addAppt($('#comment').val(),date,doctorDisplayed);
				    if (success == true)
				    {
				    	$("#calendar").fullCalendar('renderEvent',
						        {
						            title: $('#comment').val(),
						            start: startDate,
						            end: endDate,
						            allDay: ($('#apptAllDay').val() == "false"),
						            
						        },
						        true);
				    }
				   }
			  
			
			  
			});
		
		</script>
		<center>
		<h3>
		<a href="../index.php">Home</a>
		</h3>
		</center>
		<div id="calendar"></div>

<div id="createEventModal" class="modal hide" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
        <h3 id="myModalLabel1">Create Appointment</h3>
    </div>
    <div class="modal-body">
    <form id="createAppointmentForm" class="form-horizontal">
        <div class="control-group">
            <label class="control-label" for="inputPatient">Reason:</label>
            <div class="controls">
                <input type="text" name="comment" id="comment" tyle="margin: 0 auto;" data-provide="typeahead" data-items="4" data-source="[&quot;Value 1&quot;,&quot;Value 2&quot;,&quot;Value 3&quot;]">
                  <input type="hidden" id="apptStartTime"/>
                  <input type="hidden" id="apptEndTime"/>
                  <input type="hidden" id="apptAllDay" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="when">When:</label>
            <div class="controls controls-row" id="when" style="margin-top:5px;">
            </div>
        </div>
    </form>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button type="submit" class="btn btn-primary" id="submitButton">Save</button>
    </div>
</div>
  

		
		<!-- END USER LIST SECTION -->
		
		
	</body>
</html>