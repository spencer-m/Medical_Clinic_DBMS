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

<center>
<h3>
<a href="../index.php"> Home</a>
<a href="/employee_appointment_calendar/index.php" style="padding-left:2em">Clinic Schedule</a>
<a href="/appointment/my_appointments.php" style="padding-left:2em">My Appointments</a>
</h3>
</center>

<h2 align="center">Edit Appointment Info</h2>

<?php
$id = $_GET['Patient_id'];
$date = $_GET['Date'];
$docID = $_GET['Doctor_id'];

$sql = "select a.ID
              ,concat(p.First_name, ' ', p.Last_name) as Patient
              ,a.Date
														,concat(d.First_name, ' ', d.Last_name) as Doctor
														,d.Doctor_id
														,concat(e.First_name, ' ', e.Last_name) as Nurse
														,a.Reason
														,case when a.Family_dr_flag = 'Y'
																			 then 'Yes'
																				else 'No'
																end as Family_dr_flag
														,case when a.Walkin_flag = 'Y'
																				then 'Yes'
																				else 'No'
																end as Walkin_flag
														,case when a.Invoice_number is null
																				then 'N/A'
																				else a.Invoice_number
																end as Invoice_number
														,case when b.Amount is null
																				then 'N/A'
																				else b.Amount
																end as Amount
														,case when b.Balance is null
																				then 'N/A'
																				else b.Balance
																end as Balance																
														,case when b.Paid is null
																				then 'N/A'
																				else b.Paid
																end as Paid
														,a.Revision_date
										from Patient as p
															inner join Appointment as a
																							on p.ID = a.Patient_id
															inner join Employee as d
																							on a.Doctor_id = d.Doctor_id
															left outer join Employee as e
																												on a.Employee_id = e.Employee_id
															left outer join Billing as b
																												on a.Invoice_number = b.Invoice_number
									where p.ID =". $id."
											and a.Doctor_id = ".$docID."
											and a.Date = '".$date."'";

$results = $hcdb->select($sql);
$values = mysqli_fetch_array($results);

//echo $results;




/*
$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
$id = mysqli_real_escape_string($link, $_GET['Drug_id']);
$result = mysqli_query($link, "CALL sp_doctor_drugs_sel('.$id.', '')");
$values = mysqli_fetch_array($result);
*/
echo "<center><b>Patient:  </b>" .$values['Patient'];
echo "<center><b>Appointment Date:  </b>" .$values['Date'];
echo "<center><b>Reason:  </b>" .$values['Reason'];
echo "<p><center><b>Doctor:  </b>" .$values['Doctor']."<b> Nurse:  </b>" .$values['Nurse']."<b> Family Dr:  </b>" .$values['Family_dr_flag']."<b> Walkin:  </b>" .$values['Walkin_flag'];
if ($values['Invoice_number'] != 'N/A')
{
  echo "<p><center><b>Invoice #:  </b>" .$values['Invoice_number']."<b> Amount:  </b>" .'$'.$values['Amount']."<b> Balance:  </b>" .'$'.$values['Balance']."<b> Paid:  </b>" .'$'.$values['Paid'];
}
else
{
		echo "<p><center><b>Invoice #:  </b>" .$values['Invoice_number']."<b> Amount:  </b>" .''.$values['Amount']."<b> Balance:  </b>" .''.$values['Balance']."<b> Paid:  </b>" .''.$values['Paid'];
}
echo "<p><center><b>Last Revised:  </b>" .$values['Revision_date']. "<br></p>";

//mysqli_close($link);

?>

<form method="post">
<table align="center">

	<tr>
		<td>Date: </td>
		<td><input type="text" name="Date" class="form-control"/></td>
		<td>Reason: </td>
		<td><input type="text" name="Reason" class="form-control"/></td>
	</tr>
	<tr>
		<td>Doctor: </td>
		<td><input type="text" name="Doctor" class="form-control"/></td>
		<td>Nurse: </td>
		<td><input type="text" name="Nurse" class="form-control"/></td>
		<td>Family Dr: </td>
		<td><input type="text" name="FamilyDr" class="form-control"/></td>
		<td>Walkin: </td>
		<td><input type="text" name="Walkin" class="form-control"/></td>
	</tr>
	<tr>
		<td>Amount: </td>
		<td><input type="text" name="Amount" class="form-control"/></td>
		<td>Balance: </td>
		<td><input type="text" name="Balance" class="form-control"/></td>
		<td>Paid: </td>
		<td><input type="text" name="Paid" class="form-control"/></td>
	</tr>
</table>
<table>
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Update Appointment" class="btn btn-success btn-lg"style="height:20px;width:130px"/></td>
	</tr>
</table>


<?php
 $invoice_number = $values['Invoice_number'];
 $appt_id = $values['ID'];
 $msg;
 if (isset($_GET['msg'])):
{
	$msg = $_GET['msg'];
}
 else:
 {
 	$msg = "";
 }
 endif;
 if ($msg == 'fromdoctor')
 {
 		$result = $c->updateAppointment($appt_id, $id, $invoice_number, $date, '/appointment/my_appointments.php');
 }
 else{
   $result = $c->updateAppointment($appt_id, $id, $invoice_number, $date, '/people/patient_details.php');
 }

?>
</form>
</body>
</html>
