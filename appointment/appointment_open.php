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

<h2 align="center">Appointment Info</h2>

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
														,a.Revision_date
										from Patient as p
															inner join Appointment as a
																							on p.ID = a.Patient_id
															inner join Employee as d
																							on a.Doctor_id = d.Doctor_id
															left outer join Employee as e
																												on a.Employee_id = e.Employee_id															
									where p.ID = $id
											and a.Doctor_id = $docID
											and a.Date = '$date'";

$results = $hcdb->select($sql);
$values = mysqli_fetch_array($results);

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
echo "<p><center><b>Last Revised:  </b>" .$values['Revision_date']. "<br></p>";

//mysqli_close($link);
//<td><input type="text" size="25" maxlength="25" value="Enter Diagnosis" name="Comments" class="form-control"/></td>
$rows = 0;

?>

<SCRIPT language="javascript">
								// The following javascript code comes from the site:
								// http://viralpatel.net/blogs/dynamically-add-remove-rows-in-html-table-using-javascript/
								// We do not take credit for the two functions in this script
        function addRow(tableID) {
 
            var table = document.getElementById(tableID);
 
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);
 
            var colCount = table.rows[0].cells.length;
 
            for(var i=0; i<colCount; i++) {
 
                var newcell = row.insertCell(i);
 
                newcell.innerHTML = table.rows[1].cells[i].innerHTML;
                //alert(newcell.childNodes);
                switch(newcell.childNodes[0].type) {
                    case "text":
                            newcell.childNodes[0].value = "";
                            break;
                    case "checkbox":
                            newcell.childNodes[0].checked = false;
                            break;
                    case "select-one":
                            newcell.childNodes[0].selectedIndex = 0;
                            break;
                }
            }
        }
 
        function deleteRow(tableID) {
            try {
            var table = document.getElementById(tableID);
            var rowCount = table.rows.length;
 
            for(var i=0; i<rowCount; i++) {
                var row = table.rows[i];
                var chkbox = row.cells[0].childNodes[0];
                if(null != chkbox && true == chkbox.checked) {
                    if(rowCount <= 1) {
                        alert("Cannot delete all the rows.");
                        break;
                    }
                    table.deleteRow(i);
                    rowCount--;
                    i--;
                }
 
 
            }
            }catch(e) {
                alert(e);
            }
        }
 
</SCRIPT>

<table align="center" >

	<tr>
  <td> <input type="submit" name="add" value="Add" class="btn btn-success btn-lg" onclick="addRow('drugs')" /> </td>
		<td> <input type="submit" name="delete" value="Delete" class="btn btn-success btn-lg" onclick="deleteRow('drugs')" /> </td>
</table>
<?php 
		$mysqli = new mysqli(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
		if (mysqli_connect_errno())
		{
				printf("Connection failed: %s\n", mysqli_connect_errno());		 					
				exit();
		}
?>
<form method="post">
<table id="drugs" align="center" border=2>
 <tr>
	 <th></th>
		<th> Prescriptions: </th>
		<th> No. of Refills: </th>
	</tr>
	<tr>
	 <td><input type="checkbox" name="Check[]" class="form-control"/></td>
		<td>
		 <!-- <input type="text" name="PrescribedDrugs[]" class="form-control"/> -->
		 <select name="PrescribedDrugs[]">
		 	<option value="">--- Select Drug ---</option>
		 	<?php 
		 			if ($sql = $mysqli->prepare("select Drug_id, Name from Drugs_Available"))
		 			{
		 					
		 					$sql->execute();
		 					$sql->bind_result($drug_id, $drug_name);
		 					while ($sql->fetch())
		 					{
		 							printf('<option value="%s">%s</option>', $drug_id, $drug_name);
		 					}
		 					$sql->close();
		 					$mysqli->close();
		 			}
		 			
		 	?>
		 </select>
		</td>
		<td><input type="text" name="Refills[]" class="form-control"/></td>
	</tr>
	</table>
	
<table align="center">	
	<tr>
		<td>Amount: </td>
		<td><input type="text" name="Amount" class="form-control"/></td>
		<td>Balance: </td>
		<td><input type="text" name="Balance" class="form-control"/></td>
	</tr>
</table>

<h3 align="center">Comments: </h3>
<table align="center">
	<tr>
		<textarea name="Comments" > </textarea>
	</tr>
</table>

<table>
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Done" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
		<td>&nbsp;</td>
		<td><input type="submit" name="clear" value="Clear" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</table>

<?php

$appt_id = $_GET['Aid'];
$result = $c->completeAppointment($appt_id, 'my_appointments.php');

?>
</form>
</body>
</html>
