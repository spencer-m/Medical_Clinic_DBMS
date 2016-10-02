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
	$c->registerEmployee('employees.php');
?>
<html>
	<head>
		<title>Registration Form</title>
		<style type="text/css">
			body { background: #c7c7c7;}
		</style>
	</head>

	<body>
		<div style="width: 960px; background: #fff; border: 1px solid #e4e4e4; padding: 20px; margin: 10px auto;">
		 <h3> 	<center><a href="employees.php">Manage Employees</a> </center></h3>
			<h3>Employee Registration Form:</h3>
			
			<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
				<table>
				 <tr>
						<td>Employee Type:</td>
						<td><input type="text" name="Employee_Type" placeholder="DOCTOR / NURSE / RECEPTIONIST" size=30 /></td>						
					</tr>
					<tr>
						<td>First Name:</td>
						<td><input type="text" name="First_name" /></td>
					</tr>
					<tr>
						<td>Last Name:</td>
						<td><input type="text" name="Last_name" /></td>
					</tr>
					<tr>
						<td>Gender:</td>
						<td><input type="text" name="Gender" /></td>
					</tr>
					<tr>
						<td>SIN Number:</td>
						<td><input type="password" name="SIN_number" /></td>
					</tr>
					<tr>
						<td>Start Date:</td>
						<td><input type="text" name="Start_Date" placeholder="YYYY-MM-DD" /></td>						
					</tr>
					<tr>
						<td>Phone Number:</td>
						<td><input type="text" name="Phone_number" /></td>
					</tr>
					<tr>
						<td>Address:</td>
						<td><input type="text" name="Address" /></td>
					</tr>
					<tr>
						<td>Doctor ID:</td>
						<td><input type="text" name="Doctor_ID" /></td>
					</tr>
					<tr>
						<td>Speciality:</td>
						<td><input type="text" name="Speciality" /></td>
						<td> (Doctors ONLY) </td>
					</tr>
					<tr>
						<td>Certification:</td>
						<td><input type="text" name="Certification" /></td>
						<td> (Nurses ONLY) </td>
					</tr>
					<tr>
						<td>Work Station #:</td>
						<td><input type="text" name="Work_Station_Number" /></td>
						<td> (Receptionists ONLY) </td>
					</tr>
					<tr>
						<td><b>Login Info</b></td>
					</tr>
					<tr>
						<td>Username:</td>
						<td><input type="text" name="Username" /></td>
					</tr>
					<tr>
						<td>Password:</td>
						<td><input type="password" name="Password" /></td>
					</tr>
					<tr>
						<td>Email:</td>
						<td><input type="text"  name="Email" /></td>
					</tr>
					<input type="hidden" name="Date_registered" value="<?php echo time(); ?>" />
					
				</table>
				<div align="center">
				<tr>
						<td></td>
						<td><input type="submit" value="Register Employee" style="height:20px;width:130px"/></td>
					</tr>
				</div>
			</form>
		</div>
	</body>
</html>