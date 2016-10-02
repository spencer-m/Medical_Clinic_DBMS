<?php
 // The following code is a modified version of the code presented in the tutorial video:
 // https://www.youtube.com/watch?v=X6RNprqUPQc
 // The source can subsequently be found on: http://www.johnmorrisonline.com/lesson/how-to-create-an-advanced-login-system/
	require_once('loadFiles.php');
	$c->registerPatient('login.php');
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
			<h3>Patient Registration Form:</h3>
			
			<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
				<table>
					<tr>
						<td>First Name:</td>
						<td><input type="text" name="First_name" /></td>
					</tr>
					<tr>
						<td>Last Name:</td>
						<td><input type="text" name="Last_name" /></td>
					</tr>
					<tr>
						<td>SIN Number:</td>
						<td><input type="password" name="SIN_number" /></td>
					</tr>
					<tr>
						<td>Health Care #:</td>
						<td><input type="text" name="Health_care_number" /></td>
					</tr>
					<tr>
						<td>Address:</td>
						<td><input type="text" name="Address" /></td>
					</tr>
					<tr>
						<td>Phone Number:</td>
						<td><input type="text" name="Phone_number" /></td>
					</tr>
					<tr>
						<td>Allergies:</td>
						<td><input type="text" name="Allergies" /></td>
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
						<td><input type="text" name="Email" /></td>
					</tr>
					<input type="hidden" name="Date_registered" value="<?php echo time(); ?>" />
					<tr>
						<td></td>
						<td><input type="submit" value="Register" /></td>
					</tr>
				</table>
			</form>
			<p>Already a registered patient? Please login <a href="login.php">here</a></p>
		</div>
	</body>
</html>