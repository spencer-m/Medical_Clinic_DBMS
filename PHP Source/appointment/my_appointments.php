<?php
 require_once('../loadFiles.php');
 $logged = $c->checkUserLogin();
	$access = $c->checkAccessType();
 

	$start;
	if (isset($_GET['StartDate']))
	{
		$start = $_GET['StartDate'];
	}
	else
	{
		$start = "";
	}
	
	$end;
	if (isset($_GET['EndDate']))
	{
		$end = $_GET['EndDate'];
	}
	else
	{
		$end = "";
	}
	
	$all;
	if (isset($_GET['msg']))
	{
		$all = $_GET['msg'];
	}
	else
	{
		$all = "";
	}

	
	
	//$start = $_GET['StartDate'];
	//$end = $_GET['EndDate'];
	//$all = $_GET['msg']; 
	$tz = 'America/Edmonton';
	$timestamp = time();
	$day = new DateTime("now", new DateTimeZone($tz)); 
	$day->setTimestamp($timestamp);
	
	$today = new DateTime('today', new DateTimeZone($tz));
	
	$start_date = $today->format('Y-m-d H:i:s');
	$tomorrow =  new DateTime('tomorrow', new DateTimeZone($tz));
	$end_date = $tomorrow->format('Y-m-d H:i:s'); 

 if ($access == 'PATIENT')
	{
			// Display ALL appointments for the Patient
			$end_date = '9999-12-30 00:00:00';
	}
 if ($access == 'DOCTOR' or $access == 'NURSE')
 {
			$cookie = $_COOKIE['cliniclogauth'];

			//Set our user and authID variables
			$user = $cookie['user'];
			$authID = $cookie['authID'];
	
			$sql = "select Doctor_id
													from Employee as e
																		inner join Clinic_user as c
																										on e.Employee_id = c.Employee_id
												where c.Username = '" . $user . "'";
	
			$results = $hcdb->select($sql);
			$r = mysqli_fetch_assoc( $results );
			$docID = $r['Doctor_id'];
	}
	if ($access == 'PATIENT')
	{
			$cookie = $_COOKIE['cliniclogauth'];
			$user = $cookie['user'];
			$authID = $cookie['authID'];
			
			$sql = "select Id
													from Patient as p
																		inner join Clinic_user as c
																										on p.Id = c.Patient_id
												where c.Username = '" . $user . "'";
			$results = $hcdb->select($sql);
			$r = mysqli_fetch_assoc( $results );
			
			$patient_id = $r['Id'];
	}
?>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>
<body>

<center><h3> <a href="../index.php"> Home</a></h3></center>
<?php 


		if ($access == 'DOCTOR')
		{
			$clear;
			if (isset($_GET['clear']))
			{
				$clear = $_GET['clear'];
			}
			else
			{
				$clear = "";
			}
				if ($all == 'all')
				{
						echo "<h1 align='center'>All Clinic Appointments</h1>";
						echo "<div align='center'>";
						echo "<a href='my_appointments.php'>View My Appointments</a>";
						echo "</div>";
				}
				elseif (($start != "" or $end != "") and $clear != 'Clear')
				{
						echo "<h1 align='center'>Clinic Appointments</h1>";
						echo "<div align='center'>";
						echo "<a href='my_appointments.php'>View My Appointments</a>";
						echo "</div>";
				}
				else
				{
						echo "<h1 align='center'>My Appointments</h1>";
						echo "<div align='center'>";
						echo "<a href='my_appointments.php?msg=all'>View All Appointments</a>";
						echo "</div>";
				}
  }
  if ($access == 'PATIENT')
  {
  		echo "<h1 align='center'>My Appointments</h1>";
  		echo "<a href='/people/medical_history_list.php?Id=$patient_id'><center>View All Appointments</center></a>";
  }  
				
?>
<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="get">

<table align="center">
	<tr>
		<td>Start Date: </td>
		<td><input type="text" name="StartDate" placeholder = "YYYY-MM-DD" class="form-control"/></td>
		<td>End Date: </td>
		<td><input type="text" name="EndDate" placeholder = "YYYY-MM-DD" class="form-control"/></td>
	</tr>
	
</table>
<div align="center">
<tr>
		<td>&nbsp;</td>
		<td><input type="submit" name="submit" value="Search" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
	<tr >
		<td>&nbsp;</td>
		<td><input type="submit" name="clear" value="Clear" class="btn btn-success btn-lg" style="height:20px;width:130px"/></td>
	</tr>
</div>
</form>

<h2 align="center"><?php 
                        //if (!isset($_POST['submit']))
                       // { 
																								if($access == 'DOCTOR')
																								{																										
																										
																										echo "Today's Date: ".$day->format('l, F jS, Y');
																										
                       	}
                        //}
                        //else
                        //{
                        //		$start_date = $_POST['StartDate'];
 	 																					//		$end_date = $_POST['EndDate'];
 	 																					//		if(empty($end_date))
 	 																					//		{
 	 																					//			 $x = time($start_date);
 	 																					//			 echo	date('l, F jS, Y', $x);
 	 																					//		}
 	 																					//		else
 	 																					//		{
 	 																				//			  echo	date('l, F jS, Y', time($start_date)).' to '.date('l, F jS, Y', $end_date);
 	 																					//		}
                        		
                       // }
                        ?></h2>
<table align="center" border="2">
	
<?php

	if (isset($_GET['submit']))
	{
	  $start_date = $_GET['StartDate'];
 	 $end_date = $_GET['EndDate'];
 
 	 if ($access == 'DOCTOR')
			{
					if($all == 'all')
					{	
					
							$result = $hcdb->selAppointments(-1, $start_date, $end_date, 0);														
					}
					else
					{
							$result = $hcdb->selAppointments($docID, $start_date, $end_date, 0);														
					}
			}
			if ($access == 'PATIENT')
			{
			  // We pass in -2 to indicate that this is meant for a specific Patient who
			  // is currently logged in.
					$result = $hcdb->selAppointments(-2, $start_date, $end_date, $patient_id);
			}
	}
	else
	{
			if ($access == 'DOCTOR')
			{
					if($all == 'all')
					{	
					
							$result = $hcdb->selAppointments(-1, $start_date, $end_date, 0);
					}
					else
					{
							$result = $hcdb->selAppointments($docID, $start_date, $end_date, 0); 
					}
			}
			if ($access == 'PATIENT')
			{
			  // We pass in -2 to indicate that this is meant for a specific Patient who
			  // is currently logged in.
					$result = $hcdb->selAppointments(-2, $start_date, $end_date, $patient_id);
			}
	}
	if ($access == 'DOCTOR')
	{
			echo "<tr align='center'>";	
			echo "<td><font color='black'><b>Date</b></font></td>";
			echo "<td><font color='black'><b>Patient</b></font></td>";
			echo "<td><font color='black'><b>Nurse</b></font></td>";
			echo "<td><font color='black'><b>Reason</b></font></td>";
			echo "<td><font color='black'><b>Family Doctor?</b></font></td>";
			echo "<td><font color='black'><b>Walkin?</b></font></td>";
			echo "<td><font color='black'><b>Invoice #</b></font></td>";
			echo "<td><font color='black'><b>Last Revised</b></font></td>";
			echo "<td><font color='black'></font></td>";
			echo "<td><font color='black'></font></td>";
			echo "</tr>";


			while($entries = mysqli_fetch_array($result))
			{
				$date = $entries['Date'];
				$pid = $entries['Patient_id'];
				$aid = $entries['ID'];
				$msg = 'fromdoctor';
				echo "<tr align='center'>";	
				echo "<td><font color='black'>" .$entries['Date']."</font></td>";
				echo "<td><font color='black'>" .$entries['Patient']."</font></td>";
				echo "<td><font color='black'>" .$entries['Nurse']."</font></td>";
				echo "<td><font color='black'>" .$entries['Reason']."</font></td>";
				echo "<td><font color='black'>" .$entries['Family_dr_flag']. "</font></td>";
				echo "<td><font color='black'>" .$entries['Walkin_flag']. "</font></td>";
				echo "<td><font color='black'>" .$entries['Invoice_number']. "</font></td>";
				echo "<td><font color='black'>" .$entries['Revision_date']. "</font></td>";
				echo "<td> <a href ='../appointment/appointment_edit.php?Date=$date&Patient_id=$pid&Doctor_id=$docID&msg=$msg'><center>Edit</center></a>";
				echo "<td> <a href ='../appointment/appointment_open.php?Aid=$aid&Date=$date&Patient_id=$pid&Doctor_id=$docID'><center>Open</center></a>";
				echo "</tr>";
			}
	}
	if ($access == 'PATIENT')
	{
			echo "<tr align='center'>";	
			echo "<td><font color='black'><b>Date</b></font></td>";
			echo "<td><font color='black'><b>Doctor</b></font></td>";
			echo "<td><font color='black'><b>Nurse</b></font></td>";
			echo "<td><font color='black'><b>Reason</b></font></td>";
			echo "<td><font color='black'><b>Invoice #</b></font></td>";
			echo "<td><font color='black'><b>Last Revised</b></font></td>";
	
			while($entries = mysqli_fetch_array($result))
			{							
				echo "<tr align='center'>";	
				echo "<td><font color='black'>" .$entries['Date']."</font></td>";
				echo "<td><font color='black'>" .$entries['Doctor']."</font></td>";
				echo "<td><font color='black'>" .$entries['Nurse']."</font></td>";
				echo "<td><font color='black'>" .$entries['Reason']."</font></td>";
				echo "<td><font color='black'>" .$entries['Invoice_number']. "</font></td>";
				echo "<td><font color='black'>" .$entries['Revision_date']. "</font></td>";					
				echo "</tr>";
			}
	}

//mysqli_close($link);

?>
</table>
</form>
</body>
</html>