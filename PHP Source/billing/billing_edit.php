<?php
	require_once('../loadFiles.php');
	$logged = $c->checkUserLogin();
	
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>

<center>
<h3>
<a href = "../index.php">Home</a>
<a href="billing_unpaid.php"style="padding-left:2em">Manage Bills</a>
</h3>
</center>
<h2 align="center">Edit Billing Information</h2>

<?php

$id = $_GET['Invoice_number'];
$results = $hcdb->selectBilling($id);
$values = mysqli_fetch_array($results);
$bal = $values['Balance'];

echo "<p><center><b>Date:  </b>" .$values['Date']. "<br>";
echo "<b>Invoice Number:  </b>" .$values['Invoice_number']. "<br>";
echo "<b>First Name:  </b>" .$values['First_name']. "<br>";
echo "<b>Last Name:  </b>" .$values['Last_name']. "<br>";
echo "<b>Amount:  </b>" .$values['Amount']. "<br>";
echo "<b>Balance:  </b>" .$values['Balance']. "<br>";
echo "<b>Paid:  </b>" .$values['Paid']. "</center></p>";
?>

<form method="post">
<table align="center">

	<tr>
		<td>Amount paid</td>
		<td><input type="text" name="AddPaid" placeholder = "Amount paid" class="form-control"/></td>
	</tr>
	
</table>
<div align="center">

<tr >
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Paid" class="btn btn-success btn-lg" style="height:20px;width:130px" /></td>
	</tr>
</div>

<?php

if (isset($_POST['submit']))
{	
	$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
	
	$rdr = "billing_unpaid.php";
	$id = mysqli_real_escape_string($link, $_GET['Invoice_number']);
	$paid = mysqli_real_escape_string($link, $_POST['AddPaid']);
	$paid = ltrim($paid, '0');
 	$paid = round($paid, 2);
	$curr = $_SERVER['REQUEST_URI'];                
       
	if (!empty($paid) and filter_var($paid, FILTER_VALIDATE_FLOAT) and ($paid > 0) and ($paid <= $bal)) {
	
		$result = $hcdb->updateBilling($id, $paid);
	
		if(!$result) {
			echo "<script type='text/javascript'>alert('";
			echo mysqli_error($link);
			echo "'); window.location='$curr';</script>";
		}
		else {
			mysqli_close($link);	
			$redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/billing/'.$rdr.'?msg=updated';
			echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
			return TRUE;
		}
	}
	else {
		echo "<script type='text/javascript'>alert('";
		echo "Invalid Amount!";
		echo "'); window.location='$curr';</script>";
	}
	
	mysqli_close($link);
}

?>
</form>
</body>
</html>

