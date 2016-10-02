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
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>

<center><h3>
<a href="../index.php">Home</a>
<a href="patients.php" style="padding-left:2em"><t>	Manage Patients</a>
</h3></center>
<h2 align="center">Edit Patient Info</h2>

<?php
$id = $_GET['Id'];

$sql = "select Id
														,First_name
														,Last_name
														,Allergies
														,Health_care_number
														,Address
														,Phone_number
														,Revision_user
														,Revision_date
										from Patient
									where Id = $id";

$results = $hcdb->select($sql);
$values = mysqli_fetch_array($results);

/*
$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
$id = mysqli_real_escape_string($link, $_GET['Drug_id']);
$result = mysqli_query($link, "CALL sp_doctor_drugs_sel('.$id.', '')");
$values = mysqli_fetch_array($result);
*/
echo "<center><b>Patient ID:  </b>" .$values['Id']. "<br>";
echo "<p><center><b>Last Name:  </b>" .$values['First_name']."<b> First Name:  </b>" .$values['Last_name'];
echo "<p><center><b>Health Care #:  </b>" .$values['Health_care_number']."<b> Allergies:  </b>" .$values['Allergies'];
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
		<td>Allergies: </td>
		<td><input type="text" name="Allergies" class="form-control"/></td>
	</tr>
	<tr>
		<td>Address: </td>
		<td><input type="text" name="Address" class="form-control"/></td>
	</tr>
	<tr>
		<td>Phone #: </td>
		<td><input type="text" name="PhoneNumber" class="form-control"/></td>
	</tr>
	
</table>
<div align="center">
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Update Patient" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>

<?php
 $id =  $values['Id'];
 $result = $c->updatePatient($id, 'patients.php');

?>
</form>
</body>
</html>
