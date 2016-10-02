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
	 <a href="supplies_index.php" style="padding-left:2em"> 	Supplies</a> 
	 <a href="equipment_index_grouped.php" style="padding-left:2em"> Equipment</a> 
		
	</h3>
</center>
<h1 align="center">Drug Management Suite</h1>
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

<form method="post">
<table align="center">

	<tr>
		<td>DIN</td>
		<td><input type="text" name="DIN" placeholder = "DIN (11 digit limit)" size = "30"  maxlength = "11"class="form-control"/></td>
	</tr>
	<tr>
		<td>Name</td>
		<td><input type="text" name="Name"placeholder = "Name of drug (100 char limit)" size = "30"  maxlength = "100" class="form-control"/></td>
	</tr>
	<tr>
		<td>Type</td>
		<td><input type="text" name="Type" placeholder = "Type of drug (30 char limit)" size = "30"  maxlength = "30" class="form-control"/></td>
	</tr>
	
</table>

<div align = "center">
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Add Item" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>
<?php
//add function here
$inv->addNewDrug('drugs_index.php');
/*if (isset($_POST['submit']))
{
	$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));  
	$DIN = mysqli_real_escape_string($link, $_POST['DIN']);
	$DIN = ltrim($DIN, '0');
	$name = mysqli_real_escape_string($link, $_POST['Name']);					
	$type = mysqli_real_escape_string($link, $_POST['Type']);
	
	if (!empty($DIN) and !empty($name) and !empty($type) and filter_var($DIN, FILTER_VALIDATE_INT)) {
		if(!mysqli_query($link, "CALL sp_doctor_drugs_ins('$DIN', '$name', '$type')")) {
			echo "<script type='text/javascript'>alert('DIN already exists!'); window.location='drugs_index.php';</script>";
		}
		else {
			header('Location: drugs_index.php');
		}
	}
	else {
		echo "<script type='text/javascript'>alert('Invalid values for the drug!'); window.location='drugs_index.php';</script>";
	}
	
	mysqli_close($link);
}*/

?>
</form>

<h2 align="center">List of Available Drugs</h2>
<table align="center" border="2">
	
<?php

 $result = $hcdb->selectDrugs('', '');
 //$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
 //$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
 //$result = mysqli_query($link, "CALL sp_doctor_drugs_sel('', '')");

	echo "<tr align='center'>";	
	echo "<td><font color='black'><b>ID</b></font></td>";
	echo "<td><font color='black'><b>DIN</b></font></td>";
	echo "<td><font color='black'><b>Name</b></font></td>";
	echo "<td><font color='black'><b>Type</b></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "</tr>";

while($entries = mysqli_fetch_array($result))
{
	$id = $entries['Drug_id'];	
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$entries['Drug_id']."</font></td>";
	echo "<td><font color='black'>" .$entries['DIN']."</font></td>";
	echo "<td><font color='black'>" .$entries['Name']."</font></td>";
	echo "<td><font color='black'>" .$entries['Type']. "</font></td>";
	echo "<td> <a href ='drugs_edit.php?Drug_id=$id'><center>Edit</center></a>";
	echo "<td> <a href ='drugs_delete.php?Drug_id=$id'><center>Delete</center></a>";
	echo "</tr>";
}

//mysqli_close($link);

?>
</table>

</body>
</html>
