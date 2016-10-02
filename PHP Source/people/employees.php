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
		<a href="../index.php">	Home</a> 
	 <a href="patients.php"style="padding-left:2em">	Manage Patients</a> 
	</h3>
</center>
<h1 align="center">Employee Management Suite</h1>
   <?php 
   						$act;
			if (isset($_GET['msg'])):
				$act = $_GET['msg'];
			else:
				$act = 'null';
			endif;
   						$temp = $act;
         if ( strpos($temp,'deleted') !== false ) : 
  							$string = str_replace('?msg=', ', ', $temp); 
  							$string = str_replace('deleted,', 'deleted:', $string);
   ?>
				<p style="background: #55c055; border: 1px solid #55c055; padding: 7px 10px;">
						Successfully <?php echo $string ?>
					</p>
			<?php endif; ?>
<center>
	<h4>
		<a href="registerEmployee.php">Register New Employee</a> 
	</h4>
</center>
<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
<table align="center">
	<tr>
		<td>First Name: </td>
		<td><input type="text" name="FirstName" class="form-control"/></td>
		<td> Last Name: </td>
		<td><input type="text" name="LastName" class="form-control"/></td>
	</tr>
	<tr>
		<td>Employee ID:</td>
		<td><input type="text" name="EmployeeID" class="form-control"/></td>
	</tr>
	<tr>
		<td>Doctor ID:</td>
		<td><input type="text" name="DoctorID" class="form-control"/></td>
	</tr>
	<tr>
		<td>Employee Type:</td>
		<td><input type="text" name="EmployeeType" placeholder="DOCTOR/NURSE/RECPTIONIST" SIZE=30 class="form-control"/></td>
	</tr>
	<tr>
		<td>Active Flag:</td>
		<td><input type="text" name="ActiveFlag" placeholder="Yes/No" class="form-control"/></td>
		<td>Speciality:</td>
		<td><input type="text" name="Speciality" class="form-control"/></td>
		<td>Certification:</td>
		<td><input type="text" name="Certification" placeholder="RN/LPN" class="form-control"/></td>
	</tr>

</table>

<div align="center">
<tr>
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Search" class="btn btn-success btn-lg"style="height:20px;width:130px"align="center"/></td>
	</tr>
	<tr >
		<td>&nbsp;</td>
		<td><input type="submit" name="clear" value="Clear" class="btn btn-success btn-lg"style="height:20px;width:130px"align="center"/></td>
	</tr>
	</div>
<?php
// add search functionality here


?>
</form>

<h2 align="center">Employees</h2>
<table align="center" border="2">
	
<?php
 if (isset($_POST['submit']))
 {
   //(isset($_GET["var"]) && $_GET['var'] !== '') ? $_GET["var"] : "default";
 	 $eid = $_POST['EmployeeID'];
 	 $etype = $_POST['EmployeeType'];
 	 $fname = $_POST['FirstName'];
 	 $lname = $_POST['LastName'];
 	 $active_flag = $_POST['ActiveFlag'];
 	 $d_id = $_POST['DoctorID'];
 	 $spec = $_POST['Speciality'];
 	 $cert = $_POST['Certification'];
 	 
 	 $result = $hcdb->selEmployee($eid, $etype, $fname, $lname, $active_flag, $d_id, $spec, $cert);
 	 //$_POST = $a;
 }
 else 
 {
   // We pass in -1 to denote a null integer value...
	  $result = $hcdb->selEmployee(-1, '', '', '', '', -1, '', '');
	}
	
 //$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
 //$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
 //$result = mysqli_query($link, "CALL sp_doctor_drugs_sel('', '')");

	echo "<tr align='center'>";	
	echo "<td><font color='black'><b>ID</b></font></td>";
	echo "<td><font color='black'><b>First Name</b></font></td>";
	echo "<td><font color='black'><b>Last Name</b></font></td>";
	echo "<td><font color='black'><b>Gender</b></font></td>";
	echo "<td><font color='black'><b>Start Date</b></font></td>";
	echo "<td><font color='black'><b>End Date</b></font></td>";
	echo "<td><font color='black'><b>Active</b></font></td>";
	echo "<td><font color='black'><b>Phone #</b></font></td>";
	echo "<td><font color='black'><b>Address</b></font></td>";
	echo "<td><font color='black'><b>Doctor ID</b></font></td>";
	echo "<td><font color='black'><b>Speciality</b></font></td>";
	echo "<td><font color='black'><b>Certification</b></font></td>";	
	echo "<td><font color='black'><b>Work Station #</b></font></td>";
	echo "<td><font color='black'><b>Last Revised</b></font></td>";	
	echo "<td><font color='black'></font></td>";
	echo "</tr>";

while($entries = mysqli_fetch_array($result))
{
	$id = $entries['Employee_id'];	
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$entries['Employee_id']."</font></td>";
	echo "<td><font color='black'>" .$entries['First_name']."</font></td>";
	echo "<td><font color='black'>" .$entries['Last_name']."</font></td>";
	echo "<td><font color='black'>" .$entries['Gender']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Start_date']. "</font></td>";
	echo "<td><font color='black'>" .$entries['End_date']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Active']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Phone_number']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Address']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Doctor_id']. "</font></td>";	
	echo "<td><font color='black'>" .$entries['Speciality']. "</font></td>";	
 echo "<td><font color='black'>" .$entries['Certification']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Work_station_number']. "</font></td>"; 
	echo "<td><font color='black'>" .$entries['Revision_date']. "</font></td>";	
	echo "<td> <a href ='employee_edit.php?Employee_id=$id'><center>Edit</center></a>";
	echo "</tr>";
}

//mysqli_close($link);

?>
</table>

</body>
</html>