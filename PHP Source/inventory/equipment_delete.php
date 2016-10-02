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
 //$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
 $EID = $_GET['EID'];
 $inv->deleteEquipment($EID, 'equipment_index_ungrouped.php');
	
//mysqli_query($link, "CALL sp_doctor_equipment_del('$EID')") or die(mysql_error());
	
//header("Location: equipment_index_ungrouped.php");
?> 
