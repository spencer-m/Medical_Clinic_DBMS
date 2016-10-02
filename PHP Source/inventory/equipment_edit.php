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

<center><h3><a href="equipment_index_grouped.php">Manage Equipment</a></h3></center>
<h2 align="center">Edit Equipment Information</h2>

<?php

$id = $_GET['EID'];
$results = $hcdb->selectEquipment('', '', '', $id);
$values = mysqli_fetch_array($results);

//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
//$result = mysqli_fetch_array(mysqli_query($link, "CALL sp_doctor_equipment_sel('', '', '', '$temp')"));

echo "<p><center><b>Name:  </b>" .$values['Name']. "<br>";
echo "<b>Manufacturer:  </b>" .$values['Manufacturer']. "<br>";
echo "<b>Room Number:  </b>" .$values['Room_number']. "</center></p>";
?>

<form method="post">
<table align="center">

	<tr>
		<td>Name</td>
		<td><input type="text" name="Name" placeholder='Name of supply (50 char limit)' size = "30"  maxlength = "50"class="form-control"/></td>
	</tr>
	<tr>
		<td>Manufacturer</td>
		<td><input type="text" name="Manufacturer" placeholder='Name of manufacturer (250 char limit)'size = "30"  maxlength = "250"class="form-control"/></td>
	</tr>
	<tr>
		<td>Room number</td>
		<td><input type="text" name="RoomNumber" placeholder='Room to add to (11 digit limit)'size = "30" maxlength = "11" class="form-control"/></td>
	</tr>

	
</table>

<div align="center">
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Edit Item" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>

<?php

$inv->updateEquipment($id, 'equipment_index_ungrouped.php');
// Moved this function to a different class to better organize the code
/*
if (isset($_POST['submit']))
{	 
	$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
	  
	$EID = mysqli_real_escape_string($link, $_GET['EID']);
	$name = mysqli_real_escape_string($link, $_POST['Name']);					
	$manuf = mysqli_real_escape_string($link, $_POST['Manufacturer']);
	
	$rnum = mysqli_real_escape_string($link, $_POST['RoomNumber']);
	$rnum = ltrim($rnum, '0');
	$curr = $_SERVER['REQUEST_URI'];
	
	
	if (empty($rnum) or filter_var($rnum, FILTER_VALIDATE_INT)) {
		
		if(!mysqli_query($link, "CALL sp_doctor_equipment_upd('$EID','$name','$manuf','$rnum')")) {
			echo "<script type='text/javascript'>alert('";
			echo mysqli_error($link);
			echo "'); window.location='$curr';</script>";
		}
		else {
			
			header('Location: equipment_index_grouped.php');
		}
	}
	else {
		echo "<script type='text/javascript'>alert('";
		echo "Invalid room number!";
		echo "'); window.location='$curr';</script>";
	}
	
	
mysqli_close($link);	
}
*/
?>
</form>
</body>
</html>

