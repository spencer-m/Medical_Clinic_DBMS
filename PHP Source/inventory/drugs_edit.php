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

<center><a href="drugs_index.php">Manage Drugs</a></center>
<h2 align="center">Edit Drug Information</h2>

<?php
$id = $_GET['Drug_id'];
$results = $hcdb->selectDrugs($id, '');
$values = mysqli_fetch_array($results);

/*
$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
$id = mysqli_real_escape_string($link, $_GET['Drug_id']);
$result = mysqli_query($link, "CALL sp_doctor_drugs_sel('.$id.', '')");
$values = mysqli_fetch_array($result);
*/
echo "<p><center><b>Drug ID:  </b>" .$values['Drug_id']. "<br>";
echo "<p><center><b>Drug Identification Number:  </b>" .$values['DIN']. "<br>";
echo "<b>Name:  </b>" .$values['Name']. "<br>";
echo "<b>Type:  </b>" .$values['Type']. "</center></p>";

//mysqli_close($link);

?>

<form method="post">
<table align="center">

	<tr>
		<td>Name</td>
		<td><input type="text" name="Name"placeholder = "Name of drug (100 char limit)" size = "30"   maxlength = "100"class="form-control"/></td>
	</tr>
	<tr>
		<td>Type</td>
		<td><input type="text" name="Type" placeholder = "Type of drug (30 char limit)" size = "30"  maxlength = "30"class="form-control"/></td>
	</tr>
	
</table>
<div align = "center>
<tr align="center">
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Edit Item" class="btn btn-success btn-lg"style="height:20px;width:130px"/></td>
	</tr>
</div>
<?php
 $id =  $values['Drug_id'];
 $result = $inv->updateDrug($id, 'drugs_index.php');

// NEED TO FIX THIS; REFACTOR QUERIES TO DB CLASS AND PHP TO IT'S OWN FUNCTION
/* // MOVED FUNCTION TO InventoryClass...
$link = mysqli_connect('localhost','root','','healthcareclinic') or die('Error ' . mysqli_error($link));
$id = mysqli_real_escape_string($link, $_GET['Drug_id']);

if (isset($_POST['submit']))
{	   
	$name = mysqli_real_escape_string($link, $_POST['Name']);					
	$type = mysqli_real_escape_string($link, $_POST['Type']);
	
	if(!mysqli_query($link, "CALL sp_doctor_drugs_upd('$id', '$name', '$type')")) {
		echo "<script type='text/javascript'>alert('An error occurred!'); window.location='drugs_index.php';</script>";
	}
	else {
		header('Location: drugs_index.php');
	}
}
mysqli_close($link);

*/

?>
</form>
</body>
</html>
