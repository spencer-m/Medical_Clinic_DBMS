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

<center><h3><a href="supplies_index.php">Manage Supplies</a></h3></center>
<h2 align="center">Edit Supply Information</h2>

<?php

$sid = $_GET['SID'];
$r = $hcdb->selectSupplies($sid, '',  FALSE);
$result = mysqli_fetch_array($r);

//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
//$sid = mysqli_real_escape_string($link, $_GET['SID']);
//$result = mysqli_fetch_array(mysqli_query($link, "SELECT * FROM Supplies WHERE ID = '$sid'"));

echo "<p><center><b>Name:  </b>" .$result['Name']. "<br>";
echo "<b>Supplier:  </b>" .$result['Supplier']. "<br>";
?>

<form method="post">
<table align="center">


	<tr>
		<td>Name</td>
		<td><input type="text" name="Name" placeholder='New name (50 char limit)' size = "30"  maxlength = "50"class="form-control"/></td>
	</tr>	

	<tr>
		<td>Supplier</td>
		<td><input type="text" name="Supplier" placeholder='New supplier (45 char limit)' size = "30"  maxlength = "45"class="form-control"/></td>
	</tr>	

	
</table>

<div align= "center">

<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Edit Item" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>

<?php
$inv->updateSupplies($sid, 'supplies_index.php', false, -1);
/*
//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));

if (isset($_POST['submit']))
{	   
	$sid = mysqli_real_escape_string($link, $_GET['SID']);
	$name= mysqli_real_escape_string($link, $_POST['Name']);
	$supp = mysqli_real_escape_string($link, $_POST['Supplier']);
	$result = mysqli_fetch_array(mysqli_query($link, "SELECT * FROM Supplies WHERE ID = '$sid'"));
	
	if (empty($name)) {
		$name = $result['Name'];
	}
	
	if (empty($supp)) {
		$supp = $result['Supplier'];
	}
	
	if(!mysqli_query($link, "CALL sp_doctor_supplies_upd('$sid', '', '$name', '$supp', '')")) {
		echo "<script type='text/javascript'>alert('";
		echo mysqli_error($link);
		echo "'); window.location='suppplies_edit_supp.php';</script>";
	}
	else {
		header('Location: supplies_index.php');
	}
}

mysqli_close($link);
*/
?>
</form>
</body>
</html>

