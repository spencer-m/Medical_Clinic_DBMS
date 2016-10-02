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
$id = $_GET['SID'];
$inv->deleteSupplies($id, 'supplies_index.php');
/*	
$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
$SID = mysqli_real_escape_string($link, $_GET['SID']);

if (isset($_GET['RoomNumber']) and !empty($_GET['RoomNumber'])) {
	$rnum = mysqli_real_escape_string($link, $_GET['RoomNumber']);
	mysqli_query($link, "CALL sp_doctor_supplies_del('$SID', '$rnum')") or die(mysql_error());
}
else {
	mysqli_query($link, "CALL sp_doctor_supplies_del('$SID', '')") or die(mysql_error());
}
	
header("Location: supplies_index.php");
*/
?> 
