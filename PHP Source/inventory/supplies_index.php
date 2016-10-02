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
<div>
<center>
	<h3>
		<a href="../index.php">Home</a> 
	 <a href="equipment_index_grouped.php" style="padding-left:2em">Equipment</a> 
	 <a href="drugs_index.php" style="padding-left:2em">Drugs</a> 
		
	</h3>
</center>
</div>

<h1 align="center">Supplies Management Suite</h1>

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
		<td>Name</td>
		<td><input type="text" name="Name"  placeholder='Name of supply (50 char limit)' size = "30" maxlength = "50"class="form-control"/></td>
	</tr>
	<tr>
		<td>Supplier</td>
		<td><input type="text" name="Supplier" placeholder='Name of supplier (45 char limit)' size = "30" maxlength = "45"class="form-control"/></td>
	</tr>
	<tr>
		<td>Amount</td>
		<td><input type="text" name="Amount" placeholder='Amount added (11 digit limit)'size = "30"  maxlength = "11"class="form-control"/></td>
	</tr>
	<tr>
		<td>Room Number</td>
		<td><input type="text" name="RoomNumber" placeholder='Room to add to (11 digit limit)'size = "30" maxlength = "11"class="form-control"/></td>
	</tr>
	
</table>

<div align="center">

<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Add Item" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>

<?php
$inv->addNewSupplies('supplies_index.php');

//}

/*
if (isset($_POST['submit']))
{
 $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
	//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));  
	
	$name = mysqli_real_escape_string($link, $_POST['Name']);					
	$supp = mysqli_real_escape_string($link, $_POST['Supplier']);
	$rnum = mysqli_real_escape_string($link, $_POST['RoomNumber']);
	$rnum = ltrim($rnum, '0');
	$amt = mysqli_real_escape_string($link, $_POST['Amount']);
	$amt = ltrim($amt, '0');
	
	if (!empty($rnum) and !empty($name) and !empty($supp) and !empty($amt) and filter_var($rnum, FILTER_VALIDATE_INT) and filter_var($amt, FILTER_VALIDATE_INT)) {
		if(!mysqli_query($link, "CALL sp_doctor_supplies_ins('$name', '$supp', '$rnum', '$amt')")) {
			echo "<script type='text/javascript'>alert('";
			echo mysqli_error($link);
			echo "'); window.location='supplies_index.php';</script>";
		}
		else {
			header('Location: supplies_index.php');
		}
	}
	else {
		echo "<script type='text/javascript'>alert('Invalid values for the supply!'); window.location='supplies_index.php';</script>";
	}
	
	echo mysqli_error($link);
	mysqli_close($link);
}*/

?>
</form>
<h2 align="center">List of Supplies by Room Number</h2>
<table align="center" border="2">
<?php
$result = $hcdb->listSupplies('', '', '1');
//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
//$result = mysqli_query($link, "CALL sp_doctor_supplies_sel('', '', '1')");

$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
if (!$link)
{
	echo mysqli_connect_error();
}

	echo mysqli_error($link);
	echo "<tr align='center'>";
	echo "<td><font color='black'><b>Room Number</b></font></td>";
	echo "<td><font color='black'><b>Name</b></font></td>";
	echo "<td><font color='black'><b>Supplier</b></font></td>";
	echo "<td><font color='black'><b>Amount</b></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "</tr>";

while($entries = mysqli_fetch_array($result))
{
	// by room number
	$sid = $entries['ID'];
	$rnum = $entries['Room_number'];
	$name = $entries['Name'];
	$supp = $entries['Supplier'];
	$amt = ltrim($entries['Amount'], '0');
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$rnum."</font></td>";
	echo "<td><font color='black'>" .$name. "</font></td>";
	echo "<td><font color='black'>" .$supp."</font></td>";
	echo "<td><font color='black'>" .$amt. "</font></td>";
	echo "<td> <a href ='supplies_edit_supr.php?SID=$sid&RoomNumber=$rnum'>Edit</a>";
	echo "<td> <a href ='supplies_delete.php?SID=$sid&RoomNumber=$rnum'><center>Delete</center></a>";
	echo "</tr>";
}

mysqli_close($link);

?>
</table>

<h2 align="center"><br>List of Supplies</h2>
<table align="center" border="2">
	
<?php
$result = $hcdb->listSupplies('', '', '');
//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
//$result = mysqli_query($link, "CALL sp_doctor_supplies_sel('', '', '')");

$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
if (!$link)
{
	echo mysqli_connect_error();
}

	echo mysqli_error($link);
	echo "<tr align='center'>";
	echo "<td><font color='black'><b>Supply ID</b></font></td>";
	echo "<td><font color='black'><b>Name</b></font></td>";
	echo "<td><font color='black'><b>Supplier</b></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "<td><font color='black'></font></td>";
	echo "</tr>";

while($entries = mysqli_fetch_array($result))
{
	// all supplies
	$sid = $entries['ID'];
	$name = $entries['Name'];
	$supp = $entries['Supplier'];
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$sid."</font></td>";
	echo "<td><font color='black'>" .$name. "</font></td>";
	echo "<td><font color='black'>" .$supp."</font></td>";
	echo "<td> <a href ='supplies_edit_supp.php?SID=$sid'>Edit</a>";
	echo "<td> <a href ='supplies_delete.php?SID=$sid'><center>Delete</center></a>";
	echo "</tr>";
}

mysqli_close($link);

?>
</table>
</body>
</html>
