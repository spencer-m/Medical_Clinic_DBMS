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
		<a href="../index.php">	Home</a>
	</h3>
</center>
<h1 align="center">Billing Management Suite</h1>

<h2 align="center">List of Paid Bills</h2>

<?php
echo "<center><a href=billing_unpaid.php>List of Unpaid Bills</a></center>";
?>

<table align="center" border="2">
	
<?php
 
 // query for PAID bills here
 $result = $hcdb->viewBilling('4'); // paid has 4 characters

	echo "<tr align='center'>";	
	echo "<td><font color='black'><b>Appointment Date</b></font></td>";
	echo "<td><font color='black'><b>Invoice Number</b></font></td>";
	echo "<td><font color='black'><b>First Name</b></font></td>";
	echo "<td><font color='black'><b>Last Name</b></font></td>";
	echo "<td><font color='black'><b>Amount</b></font></td>";
	echo "<td><font color='black'><b>Balance</b></font></td>";
	echo "<td><font color='black'><b>Paid</b></font></td>";
	echo "<td><font color='black'><b>Revision Date</b></font></td>";
	echo "</tr>";

while($entries = mysqli_fetch_array($result))
{
	echo "<tr align='center'>";	
	echo "<td><font color='black'>" .$entries['Date']."</font></td>";
	echo "<td><font color='black'>" .$entries['Invoice_number']."</font></td>";
	echo "<td><font color='black'>" .$entries['First_name']. "</font></td>";
	echo "<td><font color='black'>" .$entries['Last_name']."</font></td>";
	echo "<td><font color='black'>" .$entries['Amount']."</font></td>";
	echo "<td><font color='black'>" .$entries['Balance']."</font></td>";
	echo "<td><font color='black'>" .$entries['Paid']."</font></td>";
	echo "<td><font color='black'>" .$entries['Revision_date']."</font></td>";
	echo "</tr>";
}

?>
</table>

</body>
</html>
