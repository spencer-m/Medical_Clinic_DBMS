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
$id = $_GET['Drug_id'];
$inv->deleteDrug($id, 'drugs_index.php');
	
//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
//$id = mysqli_real_escape_string($link,$_GET['Drug_id']);
	
//mysqli_query($link, "CALL sp_doctor_drugs_del('$id')") or die(mysql_error());
	
//header("Location: drugs_index.php");
?> 
