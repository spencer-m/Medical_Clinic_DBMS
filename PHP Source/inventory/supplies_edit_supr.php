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
//$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
//$sid = mysqli_real_escape_string($link, $_GET['SID']);
//$rnum = mysqli_real_escape_string($link, $_GET['RoomNumber']);
//$result = mysqli_fetch_array(mysqli_query($link, "SELECT * FROM Supplies as s JOIN Room_Supplies_Xref as rsx ON s.ID = rsx.Supplies_ID WHERE s.ID = '$sid' and rsx.Room_number = '$rnum'"));
$sid = $_GET['SID'];
$rnum = $_GET['RoomNumber'];
$r = $hcdb->selectSupplies($sid, $rnum, TRUE);
$result = mysqli_fetch_array($r);

echo "<p><center><b>Name:  </b>" .$result['Name']. "<br>";
echo "<b>Supplier:  </b>" .$result['Supplier']. "<br>";
echo "<b>Room Number:  </b>" .$result['Room_number']. "<br>";
echo "<b>Amount:  </b>" .ltrim($result['Amount'], '0'). "</center></p>";
?>

<form method="post">
<table align="center">

	<tr>
		<td>Amount</td>
		<td><input type="text" name="Amount" placeholder='New amount (11 digit limit)' size = "30" maxlength = "11" class="form-control"/></td>
	</tr>	

	
</table>

<div align="center">
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Edit" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>

<?php
$inv->updateSupplies($sid, 'supplies_index.php', TRUE, $rnum);
/*
$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));

if (isset($_POST['submit']))
{	   
	$amt= mysqli_real_escape_string($link, $_POST['Amount']);
	$sid = mysqli_real_escape_string($link, $_GET['SID']);
	$rnum = mysqli_real_escape_string($link, $_GET['RoomNumber']);
	
	if(!mysqli_query($link, "CALL sp_doctor_supplies_upd('$sid', '$rnum', '', '', '$amt')")) {
		echo "<script type='text/javascript'>alert('";
		echo mysqli_error($link);
		echo "'); window.location='suppplies_edit_supr.php';</script>";
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

