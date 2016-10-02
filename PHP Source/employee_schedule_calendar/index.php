<?php

 require_once('../loadFiles.php');
 $logged = $c->checkUserLogin();
 $access = $c->checkAccessType();
 if ($access == 'PATIENT')
 {
 		echo "<script type='text/javascript'>alert('";
			echo "ACCESS DEINED!";
			echo "'); window.location='../index.php';</script>";
 }
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
			var calendarDisplayed = 1;
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
		
			
		</script>
	</head>
	
	<body > 
	<!-- Once the page loads, it will call the "initializeListOfUsers" function to populate the table with records -->
	
	
	<script>
	
	function getData(start, end)
	{
		var noAccess = "Appointment";
		

			if (calendarDisplayed == 1)
			{
				var xhttp = new XMLHttpRequest();
				
				
				//REQUEST TO WEBSERVICE
				
				xhttp.open("GET", "../webservice/webservice.php?method=getEmpl&start=" + start + "&end=" + end, false);
				xhttp.send();
				var response = JSON.parse(xhttp.responseText);
				
				//Check if the success returned was false
				if (!response.success)
					alert(response.message); //Displays the error message returned from the server
				else //If everything was okay
				{
					//Generate the html that contains the users' information
					var test = [];
					for (var index in response.data) 	//response.data contains the array of user objects
														//each userObject contain the id and name of a user
					{
						var userObject = response.data[index]; //Get the user at a specific index
						var add = {id : userObject.pid, title : userObject.comment, start: userObject.time, end: userObject.end};
						test.push(add);
						
					}
				
					return test;
				}
			}

			else
			{
var xhttp = new XMLHttpRequest();
				
				
				//REQUEST TO WEBSERVICE
				
				
				xhttp.open("GET", "../webservice/webservice.php?method=getAllEmpl&start=" + start + "&end=" + end, false);
				xhttp.send();
				var response = JSON.parse(xhttp.responseText);
				
				//Check if the success returned was false
				if (!response.success)
					alert(response.message); //Displays the error message returned from the server
				else //If everything was okay
				{
					//Generate the html that contains the users' information
					var test = [];
					for (var index in response.data) 	//response.data contains the array of user objects
														//each userObject contain the id and name of a user
					{
						var userObject = response.data[index]; //Get the user at a specific index
						var add = {id : userObject.pid, title : userObject.comment, start: userObject.time, end: userObject.end};
						test.push(add);
						
					}
					
					return test;
				}

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
		
		$('#calendar').fullCalendar('removeEvents');
		$('#calendar').fullCalendar('addEventSource', events);
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
				  height: 560,
				  customButtons: {
				        My_Schedule: {
				            text: 'My Schedule',
				            click: function(){
				            	calendarDisplayed = 1;
				            	var startDate = moment(getCalendarDateRange().start).format('YYYY-MM-DD');
				            	var endDate = moment(getCalendarDateRange().end).format('YYYY-MM-DD');

				            	refresh(startDate, endDate);
				            }
				            
				        },
			  
					  all_employees: {
				            text: 'Full Schedule',
				            click: function(){
				            	calendarDisplayed = 2;
				            	var startDate = moment(getCalendarDateRange().start).format('YYYY-MM-DD');
				            	var endDate = moment(getCalendarDateRange().end).format('YYYY-MM-DD');

				            	refresh(startDate, endDate);
				            }
				            
				        }
				    },
			    header: {
			      left: 'prev,next today My_Schedule all_employees',
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
			    events: events
			    
			  });
			   	
			  
			
			  
			});
		
		</script>
		<center>
		<h3>
		<a href="../index.php">Home</a>
		</h3>
		</center>
		
		<div id="calendar"></div>
		


  

		
		<!-- END USER LIST SECTION -->
		
		
	</body>
</html>