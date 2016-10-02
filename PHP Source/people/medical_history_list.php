<?php
 require_once('../loadFiles.php');
 $logged = $c->checkUserLogin();
 $access = $c->checkAccessType();
 /*if ($access == 'PATIENT')
 {
 		echo "<script type='text/javascript'>alert('";
			echo "ACCESS DEINED!";
			echo "'); window.location='../index.php';</script>";
 }*/
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>

<center><h3><a href="../index.php">Home</a></h3></center>
<h2 align="center">Patient Details</h2>

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
if($access == 'DOCTOR')
{
		echo "<center><b>Patient ID:  </b>" .$values['Id']. "<br>";
}
echo "<p><center><b>Last Name:  </b>" .$values['First_name']."<b> First Name:  </b>" .$values['Last_name'];
echo "<p><center><b>Health Care #:  </b>" .$values['Health_care_number']."<b> Allergies:  </b>" .$values['Allergies'];
echo "<p><center><b>Address:  </b>" .$values['Address']."<b> Phone #:  </b>" .$values['Phone_number']. "<br>";
echo "<p><center><b>Last Revised:  </b>" .$values['Revision_date']. "<br></p>";

//mysqli_close($link);

?>

<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="get">
<table align="center">
	<tr>
		<td>Start Date: </td>
		<td><input type="text" name="StartDate" placeholder="YYYY-MM-DD" class="form-control"/></td>
		<td>End Date: </td>
		<td><input type="text" name="EndDate" placeholder="YYYY-MM-DD" class="form-control"/></td>
	</tr>
	<tr>
		<td>Dr's Last Name: </td>
		<td><input type="text" name="DrLname" class="form-control"/></td>
	</tr>
	<tr>
		<?php echo "<td><input type='hidden' name='Id' value=$id /></td>"; ?>
	</tr>
	
</table>

<div align="center">
<tr align="right">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Search" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
	<tr align="right">
		<td>&nbsp;</td>
		<td><input type="submit" name="clear" value="Clear" class="btn btn-success btn-lg"style="height:20px;width:130px"/></td>
	</tr>
</div>
</form>

<h2 align="center">Patient Medical History</h2>
<table align="center" border="2">
	
<?php
if (isset($_GET['submit']))
 {
 	 $startdate = $_GET['StartDate'];
 	 if ($startdate == "")
 	 	$startdate = "1111-11-11";
 	 $enddate = $_GET['EndDate'];
 	 if ($enddate == "")
 	 	$enddate = "9999-12-25";
 	 $drlname = $_GET['DrLname'];
 	 $result = $hcdb->selPatientMedicalHist($id, $drlname, $startdate, $enddate);
 	 //$_POST = $a;
 }
 else 
 {
	  $result = $hcdb->selPatientMedicalHist($id, 'NULL', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
	}
	echo "<tr align='center'>";	
	echo "<td><font color='black'><b>Date</b></font></td>";
	echo "<td><font color='black'><b>Patient</b></font></td>";
	echo "<td><font color='black'><b>Doctor</b></font></td>";
	echo "<td><font color='black'><b>Speciality</b></font></td>";
	echo "<td><font color='black'><b>Reason</b></font></td>";
	echo "<td><font color='black'><b>Prescription (Refills)</b></font></td>";
	if ($access == 'DOCTOR')
	{	
	  echo "<td><font color='black'><b>Comments</b></font></td>";	
	}
	echo "<td><font color='black'><b>Family Doctor?</b></font></td>";
	echo "<td><font color='black'><b>Walkin?</b></font></td>";
	echo "<td><font color='black'><b>Last Revised</b></font></td>";
	echo "</tr>";


while($entries = mysqli_fetch_array($result))
{
	//$date = $entries['Appointment_date'];
	//$docID = $entries['Doctor'];	
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$entries['Appointment_date']."</font></td>";
	echo "<td><font color='black'>" .$entries['Patient']."</font></td>";
	echo "<td><font color='black'>" .$entries['Doctor']."</font></td>";
	echo "<td><font color='black'>" .$entries['Speciality']."</font></td>";
	echo "<td><font color='black'>" .$entries['Reason_for_appt']. "</font></td>";
	echo "<td><font color='black'>" .$entries['p_and_r']. "</font></td>";
	if ($access == 'DOCTOR')
	{
	  echo "<td><font color='black'>" .$entries['Comments']. "</font></td>";	
	}
	echo "<td><font color='black'>" .$entries['Family_dr_flag']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Walkin_flag']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Revision_date']. "</font></td>";
	echo "</tr>";
}

//mysqli_close($link);

?>
</table>
</form>
</body>
</html>