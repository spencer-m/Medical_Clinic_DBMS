<?php
	// The following code is a modified version of the code presented in the tutorial video:
 // https://www.youtube.com/watch?v=X6RNprqUPQc
 // The source can subsequently be found on: http://www.johnmorrisonline.com/lesson/how-to-create-an-advanced-login-system/
	require_once('loadFiles.php');
	$logged = $c->checkUserLogin();
	
	/*if ( $logged == false ) {
		//Build our redirect
  $url = "http" . ((!empty($_SERVER['HTTPS'])) ? "s" : "") . "://".$_SERVER['HTTP_HOST'].$_SERVER['REQUEST_URI'];
	//	$url = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
		
		//$url = "http://" . 'localhost/' . 'index.php';
		$redirect = str_replace('index.php', 'login.php', $url);
		
		//Redirect to the home page
		//header("Location: $redirect?msg=login");
		header("Location: http://localhost/login/login.php?msg=login");
		exit;
	} 
	else {*/
		//Grab our authorization cookie array
		$cookie = $_COOKIE['cliniclogauth'];

		//Set our user and authID variables
		$user = $cookie['user'];
		$authID = $cookie['authID'];

		// First we find out if the user logging in, is a Doctor or Employee
		$sql = "SELECT User_type
												FROM Clinic_user
											WHERE Username = '" . $user . "'";
  										
		$results = $hcdb->select($sql);
		$r = mysqli_fetch_assoc( $results );
		
			// If the username does not exist, kill the script
		if (!$results) {
			die('Sorry, that username does not exist!');
		}
		
		$userType = $r['User_type'];
  
		//echo $user;
		//Query the database for the selected user
		if ($userType == 'PATIENT')
		{
					$sql = "SELECT concat(p.First_name, ' ', p.Last_name) as Name
																			,c.Username
																			,c.User_email
																			,c.Date_registered 
															FROM Clinic_user as c
																				inner join Patient as p
																											on c.Patient_id = p.ID
														WHERE Username = '" . $user . "'";
					$results = $hcdb->select($sql);
		}
		elseif ($userType == 'DOCTOR' or $userType == 'NURSE' or $userType == 'RECEPTION')
		{
				 $sql = "SELECT concat(e.First_name, ' ', e.Last_name) as Name
																			,c.Username
																			,c.User_email
																			,c.Date_registered 
															FROM Clinic_user as c
																				inner join Employee as e
																											on c.Employee_id = e.Employee_id
														WHERE Username = '" . $user . "'";
					$results = $hcdb->select($sql);
		}	
		else {
					die('Invalid userType retrieved from database');
		}
		
		//Fetch our results into an associative array
		$results = mysqli_fetch_assoc( $results );
		
		// We have to check if the user which is logged in, is a Doctor
		$sql = "select a.Access_type
												from Clinic_user as c
																	inner join Access_rule as a
																										on c.Access_rule_id = a.ID
								 		where c.Username = '" . $user . "'";
		$results2 = $hcdb->select($sql);
		$r2 = mysqli_fetch_assoc( $results2 );
		$userAccess = $r2['Access_type'];
?>
<script type="text/javascript">
//modified from http://www.w3schools.com/howto/howto_js_dropdown.asp
function dropdownFunc() {
    document.getElementById("myDropdown").classList.toggle("show");
}


window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
</script>

<html>
<style>

//modified from http://www.w3schools.com/howto/howto_js_dropdown.asp
/* Dropdown Button */
.dropbtn {
    background-color: #808080;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

/* Dropdown button on hover & focus */
.dropbtn:hover, .dropbtn:focus {
    background-color: #dcdcdc;
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
    position: relative;
    display: inline-block;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

/* Links inside the dropdown */
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {background-color: #f1f1f1}

/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
.show {display:block;}
</style>
	<head>
		<title>Clinic Home</title>
		<style type="text/css">
			body { background: #c7c7c7;}
		</style>
	</head>

	<body>
		<div style="width: 960px; background: #fff; border: 1px solid #e4e4e4; padding: 20px; margin: 10px auto;">
			<div>
	
				<h3>
				 
				 
				 <?php if($userAccess == 'DOCTOR'): ?>
				 <div class="dropdown">
  <button onclick="dropdownFunc()" class="dropbtn">Go To:</button>
  <div id="myDropdown" class="dropdown-content">
    <a href="/employee_appointment_calendar/index.php">	Clinic Schedule </a> 
				 	<a href ="/employee_schedule_calendar/index.php">  Employee Schedule</a>
				 	<a href="/inventory/supplies_index.php">	Clinic Inventory </a>
				 	<a href="/billing/billing_unpaid.php">	Billing Management </a>
				 	<a href="/people/patients.php"> People Management	</a>
				 	<a href="/appointment/my_appointments.php"> My Appointments	</a> 
  </div>
</div>
				 	<!-- <a href="/employee_appointment_calendar/index.php"><	Clinic Schedule ></a> 
				 	<a href ="/employee_schedule_calendar/index.php"> < Employee Schedule></a>
				 	<a href="/inventory/supplies_index.php"><	Clinic Inventory ></a>
				 	<a href="/billing/billing_unpaid.php"><	Billing Management ></a>
				 	<a href="/people/patients.php">< People Management	></a>
				 	<a href="/appointment/my_appointments.php">< My Appointments	></a> -->
				 <?php endif;?>
				 
				 <?php if($userType == 'NURSE' or $userType == 'RECEPTION'): ?>
				 		<div class="dropdown">
        <button onclick="dropdownFunc()" class="dropbtn">Go To:</button>
        <div id="myDropdown" class="dropdown-content">
        <a href="/employee_appointment_calendar/index.php">	Clinic Schedule </a> 
				 	  <a href ="/employee_schedule_calendar/index.php">  Employee Schedule</a>
				   	<a href="/inventory/supplies_index.php">	Clinic Inventory </a>
				   	<a href="/billing/billing_unpaid.php">	Billing Management </a>
				   	<a href="/people/patients.php"> People Management	</a>
				   	 
      </div>
     </div>
				 <?php endif;?>
				 
				 <?php if($userAccess == 'PATIENT'): ?>
				 
				 <div class="dropdown">
  <button onclick="dropdownFunc()" class="dropbtn">Go To:</button>
  <div id="myDropdown" class="dropdown-content">
   <a href="/calendar/index.php">	Clinic Schedule </a> 
				 	<a href="/appointment/my_appointments.php"> My Appointments	</a> 
  </div>
</div>
				 	<!-- <a href="/calendar/index.php"><	Clinic Schedule ></a> 
				 	<a href="/appointment/my_appointments.php">< My Appointments	></a> -->
				 <?php endif;?>
				 
				</h3>
			</div>
	
			<h3>Clinic Home</h3>
			<p><b>User Info</b></p>
			<table>
				<tr>
					<td>Name: </td>
					<td><?php echo $results['Name']; ?></td>
				</tr>
				
				<tr>
					<td>Username: </td>
					<td><?php echo $results['Username']; ?></td>
				</tr>
				
				<tr>
					<td>Email: </td>
					<td><?php echo $results['User_email']; ?></td>
				</tr>
				
				<tr>
					<td>Registered: </td>
					<td><?php echo date('l, F jS, Y', $results['Date_registered']); ?></td>
				</tr>
			</table>
			
			<p>This is the members only area. Only logged in users can view this page. Please <a href="login.php?action=logout">click here to logout</a></p>
			
			
			
		</div>
	</body>
</html>