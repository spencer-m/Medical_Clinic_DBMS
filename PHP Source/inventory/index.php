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
<body>
	Click <a href="drugs_index.php">here</a> to go to the drugs page.<br>
	Click <a href="supplies_index.php">here</a> to go to the supplies page.<br>
	Click <a href="equipment_index_grouped.php">here</a> to go to the equipment page.
</body>
</html>
