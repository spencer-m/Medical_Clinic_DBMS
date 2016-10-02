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
echo "<center><b>Patient ID:  </b>" .$values['Id']. "<br>";
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
		<td><input type="text" name="StartDate" class="form-control"/></td>
		<td>End Date: </td>
		<td><input type="text" name="EndDate" class="form-control"/></td>
	</tr>
	<tr>
		<td>Dr's Last Name: </td>
		<td><input type="text" name="DrLname" class="form-control"/></td>
		<td>Balance: </td>
		<td><input type="text" name="Balance" class="form-control"/></td>
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
		<td><input type="submit" name="clear" value="Clear" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>
</form>

<h2 align="center">Patient Appointments</h2>
<?php echo "<a href='medical_history_list.php?Id=$id'><center>View Medical History</center></a>"; ?>
<table align="center" border="2">
	
<?php
if (isset($_GET['submit']))
 {
 	 $startdate = $_GET['StartDate'];
 	 $enddate = $_GET['EndDate'];
 	 $drlname = $_GET['DrLname'];
 	 $balance = $_GET['Balance'];
 	 
 	 $result = $hcdb->selPatientAppt($id, $startdate, $enddate, $drlname, $balance);
 	
 }
 else 
 {
   
	  $result = $hcdb->selPatientAppt($id, '', '', '', -1.0);
	}
	echo "<tr align='center'>";	
	echo "<td><font color='black'><b>Date</b></font></td>";
	echo "<td><font color='black'><b>Doctor</b></font></td>";
 echo "<td><font color='black'><b>Nurse</b></font></td>";
	echo "<td><font color='black'><b>Reason</b></font></td>";
	echo "<td><font color='black'><b>Family Doctor?</b></font></td>";
	echo "<td><font color='black'><b>Walk-in?</b></font></td>";
	echo "<td><font color='black'><b>Invoice #</b></font></td>";
	echo "<td><font color='black'><b>Amount</b></font></td>";
	echo "<td><font color='black'><b>Balance</b></font></td>";
	echo "<td><font color='black'><b>Paid</b></font></td>";
	echo "<td><font color='black'><b>Last Revised</b></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "</tr>";


while($entries = mysqli_fetch_array($result))
{
	$date = $entries['Date'];
	$docID = $entries['Doctor_id'];	
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$entries['Date']."</font></td>";
	echo "<td><font color='black'>" .$entries['Doctor']."</font></td>";
	echo "<td><font color='black'>" .$entries['Nurse']."</font></td>";
	echo "<td><font color='black'>" .$entries['Reason']."</font></td>";
	echo "<td><font color='black'>" .$entries['Family_dr_flag']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Walkin_flag']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Invoice_number']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Amount']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Balance']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Paid']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Revision_date']. "</font></td>";
	echo "<td> <a href ='../appointment/appointment_edit.php?Date=$date&Patient_id=$id&Doctor_id=$docID'><center>Edit</center></a>";
	echo "</tr>";
}

//mysqli_close($link);

?>
</table>
</form>
</body>
</html>