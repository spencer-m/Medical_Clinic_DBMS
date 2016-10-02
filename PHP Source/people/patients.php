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
	 <a href="employees.php" style="padding-left:2em"><t>	Manage Employees</a> 
	</h3>
</center>
<h1 align="center">Patient Management Suite</h1>
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
			
<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
<table align="center">
	<tr>
		<td>First Name</td>
		<td><input type="text" name="FirstName" class="form-control"/></td>
	</tr>
	<tr>
		<td>Last Name</td>
		<td><input type="text" name="LastName" class="form-control"/></td>
	</tr>
	<tr>
		<td>Health Care #</td>
		<td><input type="text" name="HC_Num" class="form-control"/></td>
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

<h2 align="center">List of Registered Patients</h2>
<table align="center" border="2">
	
<?php
 if (isset($_POST['submit']))
 {
 	 $fname = $_POST['FirstName'];
 	 $lname = $_POST['LastName'];
 	 $hc_num = $_POST['HC_Num'];
 	 $result = $hcdb->selPatient($fname, $lname, $hc_num);
 	 //$_POST = $a;
 }
 else 
 {
	  $result = $hcdb->selPatient('', '', '');
	}
	
 //$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
 //$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
 //$result = mysqli_query($link, "CALL sp_doctor_drugs_sel('', '')");

	echo "<tr align='center'>";	
	echo "<td><font color='black'><b>ID</b></font></td>";
	echo "<td><font color='black'><b>First Name</b></font></td>";
	echo "<td><font color='black'><b>Last Name</b></font></td>";
	echo "<td><font color='black'><b>Allergies</b></font></td>";
	echo "<td><font color='black'><b>Health Care #</b></font></td>";
	echo "<td><font color='black'><b>Address</b></font></td>";
	echo "<td><font color='black'><b>Phone #</b></font></td>";
	echo "<td><font color='black'><b>Last Revised</b></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "</tr>";

while($entries = mysqli_fetch_array($result))
{
	$id = $entries['Id'];	
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$entries['Id']."</font></td>";
	echo "<td><font color='black'>" .$entries['First_name']."</font></td>";
	echo "<td><font color='black'>" .$entries['Last_name']."</font></td>";
	echo "<td><font color='black'>" .$entries['Allergies']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Health_care_number']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Address']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Phone_number']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Revision_date']. "</font></td>";
	echo "<td> <a href ='patient_edit.php?Id=$id'><center>Edit</center></a>";
	echo "<td> <a href ='patient_details.php?Id=$id'><center>Details</center></a>";
	echo "</tr>";
}

//mysqli_close($link);

?>
</table>

</body>
</html>