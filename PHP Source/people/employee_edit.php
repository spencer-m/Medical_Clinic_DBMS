<?php
 require_once('../loadFiles.php');
 $logged = $c->checkUserLogin();
 $userAccess = $c->checkAccessType();
 if ($userAccess == 'PATIENT')
 {
 		echo "<script type='text/javascript'>alert('";
			echo "ACCESS DEINED!";
			echo "'); window.location='../index.php';</script>";
 }
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>

<center><h3>
<a href="../index.php">Home</a>
<a href="employees.php" style="padding-left:2em"><t>	Manage Employees</a>
</h3></center>
<h2 align="center">Edit Employee Info</h2>

<?php
$id = $_GET['Employee_id'];

$results = $hcdb->selEmployee($id, '', '', '', '', '', '', '');
$values = mysqli_fetch_array($results);

$eType = $values['Employee_type'];

/*
$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
$id = mysqli_real_escape_string($link, $_GET['Drug_id']);
$result = mysqli_query($link, "CALL sp_doctor_drugs_sel('.$id.', '')");
$values = mysqli_fetch_array($result);
*/

// build the 'feature' string depending on what employee type is being edited...
if (strtoupper($eType) == 'DOCTOR')
{
		$feature = "<b> Speciality:  </b>" .$values['Speciality'];
}
if (strtoupper($eType) == 'NURSE')
{
		$feature = "<b> Certification:  </b>" .$values['Certification'];
}
if (strtoupper($eType) == 'RECEPTIONIST')
{
		$feature = "<b> Work Station #:  </b>" .$values['Work_station_number'];
}


echo "<center><b>Employee Type:  </b>" .$values['Employee_type'];
echo "<center><b>Employee ID:  </b>" .$values['Employee_id']."<b> Doctor ID:  </b>" .$values['Doctor_id'];
echo "<p><center><b>First Name:  </b>" .$values['First_name']."<b> Last Name:  </b>" .$values['Last_name']."<b> Gender:  </b>" .strtoupper($values['Gender']).$feature;
echo "<p><center><b>Active:  </b>" .$values['Active']."<b> Start Date:  </b>" .$values['Start_date']."<b> End Date:  </b>" .$values['End_date'];
echo "<p><center><b>Address:  </b>" .$values['Address']."<b> Phone #:  </b>" .$values['Phone_number']. "<br>";
echo "<p><center><b>Last Revised:  </b>" .$values['Revision_date']. "<br></p>";

//mysqli_close($link);

?>

<form method="post">
<table align="center">

	<tr>
		<td>First Name: </td>
		<td><input type="text" name="FirstName" class="form-control"/></td>
	</tr>
	<tr>
		<td>Last Name: </td>
		<td><input type="text" name="LastName" class="form-control"/></td>
	</tr>
	<tr>
		<td>Gender: </td>
		<td><input type="text" name="Gender" class="form-control"/></td>
	</tr>
	<tr>
		<td>Active (Y/N): </td>
		<td><input type="text" name="Active" class="form-control"/></td>
	</tr>
	<tr>
		<td>Address: </td>
		<td><input type="text" name="Address" class="form-control"/></td>
	</tr>
	<tr>
		<td>Phone #: </td>
		<td><input type="text" name="PhoneNumber" class="form-control"/></td>
	</tr>
	<?php if($eType == 'DOCTOR'): ?>
		<tr>
			<td>Speciality: </td>
			<td><input type="text" name="Speciality" class="form-control"/></td>
		</tr>
	<?php elseif($eType == 'NURSE'):?>
	 <tr>
			<td>Certification: </td>
			<td><input type="text" name="Certification" class="form-control"/></td>
		</tr>
	<?php elseif($eType == 'RECEPTIONIST'):?>
	 <tr>
			<td>Work Station #: </td>
			<td><input type="text" name="WorkStationNumber" class="form-control"/></td>
		</tr>
	<?php endif;?>
	
	
	
	
</table>
<div align = "center">
	<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Update Employee" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
	</div>
<?php
 $id =  $values['Employee_id'];
 $result = $c->updateEmployee($id, 'employees.php');

?>
</form>
</body>
</html>
