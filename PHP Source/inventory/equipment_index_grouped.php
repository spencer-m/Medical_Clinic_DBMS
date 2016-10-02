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
	 <a href="supplies_index.php" style="padding-left:2em">	Supplies</a> 
	 <a href="drugs_index.php" style="padding-left:2em"> Drugs</a> 
		
	</h3>
</center>
<h1 align="center">Equipment Management Suite</h1>

<form method="post">
<table align="center">

	<tr>
		<td>Name</td>
		<td><input type="text" name="Name" placeholder='Name of supply (50 char limit)' size = "30" maxlength = "50" class="form-control"/></td>
	</tr>
	<tr>
		<td>Manufacturer</td>
		<td><input type="text" name="Manufacturer" placeholder='Name of manufacturer (250 char limit)'size = "30"  maxlength = "250"class="form-control"/></td>
	</tr>
	<tr>
		<td>Room number</td>
		<td><input type="text" name="RoomNumber" placeholder='Room to add to (11 digit limit)'size = "30"  maxlength = "11"class="form-control"/></td>
	</tr>
	
</table>

<div align="center">
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Add Item" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>

<?php

$inv->addNewEquipment('equipment_index_grouped.php');

//Moved to its own function in adifferent class
/*
if (isset($_POST['submit']))
{
	$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));  
	$name = mysqli_real_escape_string($link, $_POST['Name']);					
	$manuf = mysqli_real_escape_string($link, $_POST['Manufacturer']);
	$rnum = mysqli_real_escape_string($link, $_POST['RoomNumber']);
	$rnum = ltrim($rnum, '0');
	
	if (!empty($name) and !empty($manuf) and !empty($rnum) and filter_var($rnum, FILTER_VALIDATE_INT)) {
		if(!mysqli_query($link, "CALL sp_doctor_equipment_ins('$name','$manuf', '$rnum')")) {
			echo "<script type='text/javascript'>alert('";
			echo mysqli_error($link);
			echo "'); window.location='equipment_index_grouped.php';</script>";
		}
		else {
			header('Location: equipment_index_grouped.php');
		}
	}
	else {
		echo "<script type='text/javascript'>alert('Invalid values for the equipment!'); window.location='equipment_index_grouped.php';</script>";
	}
	
	mysqli_close($link);
}
*/ 
?>
</form>

<h2 align="center">List of Equipment Available</h2>

<?php
echo "<center><a href=equipment_index_ungrouped.php>Ungroup</a></center>";
?>

<table align="center" border="2">
	
<?php
 
 $result = $hcdb->selectEquipment('', '', '1', '');
//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
//$result = mysqli_query($link, "CALL sp_doctor_equipment_sel('', '', '1', '')");

	echo "<tr align='center'>";	
	echo "<td><font color='black'><b>Room Number</b></font></td>";
	echo "<td><font color='black'><b>Number of Equipment</b></font></td>";
	echo "<td><font color='black'><b>Name</b></font></td>";
	echo "<td><font color='black'><b>Manufacturer</b></font></td>";
	echo "</tr>";

while($entries = mysqli_fetch_array($result))
{
	$rnum = $entries['Room_number'];
	$name = $entries['Name'];
	$manuf = $entries['Manufacturer'];
	$eqpCount = $entries['Number_of_eqp'];
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$rnum."</font></td>";
	echo "<td><font color='black'>" .$eqpCount."</font></td>";
	echo "<td><font color='black'>" .$name. "</font></td>";
	echo "<td><font color='black'>" .$manuf. "</font></td>";
	echo "</tr>";
}

?>
</table>

</body>
</html>
