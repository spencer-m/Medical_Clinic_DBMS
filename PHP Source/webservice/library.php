<?php
require_once('../loadFiles.php');
	//#######################
	//# DATABASE CONNECTION #
	//#######################
	
	$CONNECTION_HOST = DB_SERVER;
	$CONNECTION_USER = DB_USER;
	$CONNECTION_PASSWORD = DB_PASS;
	$CONNECTION_DATABASE = DB_NAME;
	
	$link = mysqli_connect($CONNECTION_HOST, $CONNECTION_USER, $CONNECTION_PASSWORD, $CONNECTION_DATABASE);
	if (!$link)
	{
		echo mysqli_connect_error();
	}
	
	//######################
	//# DATABASE FUNCTIONS #
	//######################
	
	//Returns an array that contains all the users with their names and ids
	function getUsers()
	{
		//The array that will be populated with the data
		$array = array();
		
		//Create the SQL statement
		//$SQL = "SELECT name, type FROM drugs_available";
		$SQL = "call sp_appointment_sel_cal('2016-04-03 13:00:00','2016-04-03 14:00:00')";
		
		//Execute the SQL statement
		global $link;
		$results = mysqli_query($link, $SQL);
		
		//Retrieve the rows returned
		while ($row = mysqli_fetch_row($results))
		{
			//Each userObject represents one user
			$userObject = array(); //This array will be used as a dictionary (key, value)
			$userObject["time"] = $row[0];	//(key, value) => (id => $row[0])
			$userObject["pid"] = $row[4];
			$userObject["comment"] = $row[7];
			
			$array[] = $userObject; //Add the user information to the array that will be returned to the user
									//$array[] = ... => similar to array.push or array.add in other languages
		}
		return $array;
	}
	
	function getAppt($start,$end,$did)
	{
		//The array that will be populated with the data
		global $link;
		
		$array = array();
	
		//Create the SQL statement
		//$SQL = "SELECT name, type FROM drugs_available";
		$SQL = "call sp_appointment_sel_cal('".$start." 08:00:00','".$end." 18:00:00',".$did.")";
	
		//Execute the SQL statement
		$results = mysqli_query($link, $SQL);
	
		//Retrieve the rows returned
		while ($row = mysqli_fetch_row($results))
		{
			//Each userObject represents one user
			$userObject = array(); //This array will be used as a dictionary (key, value)
			$userObject["time"] = $row[1];	//(key, value) => (id => $row[0])
			$userObject["pid"] = $row[3];
			$userObject["comment"] = $row[7];
				
			$array[] = $userObject; //Add the user information to the array that will be returned to the user
			//$array[] = ... => similar to array.push or array.add in other languages
		}
		

		
		return $array;
	}
	
	function getNotWorking($start, $end, $did)
	{
		global $link;
		$table = 'Employee';
		$sql = "SELECT Employee_id FROM $table WHERE Doctor_id = $did";
		$results2 = mysqli_query($link, $sql);
		
		$results2 = mysqli_fetch_assoc($results2);
		
		$eid = $results2['Employee_id'];
		
		$array = array();
		
		$SQL = "call sp_check_days('$start', '$end', $eid)";
		
		$newResults = mysqli_query($link, $SQL);
		
		
		while ($rows = mysqli_fetch_row($newResults))
		{
			$userObject = array();
			$userObject["time"] = $rows[0];
			$userObject["comment"] = "Not Working";
		
			$array[] = $userObject;
		}
		
		return $array;
	}
	
	function getApptPatient($start,$end,$did)
	{
		//The array that will be populated with the data
		global $link;
	
		$cookie = $_COOKIE['cliniclogauth'];
			
		//Set our user and authID variables
		$user = $cookie['user'];
		$authID = $cookie['authID'];
	
		$table = 'Clinic_user';
		$sql = "SELECT * FROM $table WHERE Username = '" . $user . "'";
		$results = mysqli_query($link, $sql);
	
		//Kill the script if the submitted username doesn't exit
		if (!$results) {
			die('Sorry, that username does not exist!');
		}
	
		//Fetch our results into an associative array
		$results = mysqli_fetch_assoc( $results );
	
		$pid = $results['Patient_id'];
	
		$array = array();
	
		//Create the SQL statement
		//$SQL = "SELECT name, type FROM drugs_available";
		$SQL = "call sp_appointment_sel_cal('".$start." 08:00:00','".$end." 18:00:00',".$did.")";
	
		//Execute the SQL statement
		$results = mysqli_query($link, $SQL);
	
		//Retrieve the rows returned
		while ($row = mysqli_fetch_row($results))
		{
			//Each userObject represents one user
			$userObject = array(); //This array will be used as a dictionary (key, value)
			$userObject["time"] = $row[1];	//(key, value) => (id => $row[0])
			$userObject["pid"] = $row[3];
			if ($row[3] == $pid):
				$userObject["comment"] = $row[7];
			else:
				$userObject["comment"] = "Appointment";
			endif;
	
			$array[] = $userObject; //Add the user information to the array that will be returned to the user
			//$array[] = ... => similar to array.push or array.add in other languages
		}
		return $array;
	}
	
	
	
	function getEmpl($start,$end)
	{
		global $link;
		//The array that will be populated with the data
		$array = array();
	
		$cookie = $_COOKIE['cliniclogauth'];
			
		//Set our user and authID variables
		$user = $cookie['user'];
		$authID = $cookie['authID'];
	
		$table = 'Clinic_user';
		$sql = "SELECT * FROM $table WHERE Username = '" . $user . "'";
		$results = mysqli_query($link, $sql);
	
		//Kill the script if the submitted username doesn't exit
		if (!$results) {
			die('Sorry, that username does not exist!');
		}
	
		//Fetch our results into an associative array
		$results = mysqli_fetch_assoc( $results );
	
		$eid = $results['Employee_id'];
		
		//echo ($eid);
		
	
		//Create the SQL statement
		//$SQL = "SELECT name, type FROM drugs_available";
		$SQL = "call sp_appointment_sel_empl('".$start." 08:00:00','".$end." 18:00:00',".$eid.")";
		//echo ($SQL);
		
		//$SQL = "call sp_appointment_sel_empl('2016-04-18 08:00:00', '2016-04-18 18:00:00',1)";
	
		//Execute the SQL statement
		
		$results = mysqli_query($link, $SQL); //this holds all work_days employee is scheduled for
		
		//echo (mysqli_fetch_row($results));
	
		//Retrieve the rows returned
		while ($row = mysqli_fetch_row($results))
		{
			//Each userObject represents one user
			$userObject = array(); //This array will be used as a dictionary (key, value)
			$userObject["time"] = $row[0];	//(key, value) => (id => $row[0])
			$userObject["pid"] = $eid;
			$userObject["comment"] = $row[2]." ".$row[3];
			$userObject["end"] = $row[1];
	
			$array[] = $userObject; //Add the user information to the array that will be returned to the user
			//$array[] = ... => similar to array.push or array.add in other languages
		}
		return $array;
	}
	
	function getAllEmpl($start, $end)
	{
		global $link;
		//The array that will be populated with the data
		$array = array();
		
		
		//Create the SQL statement
		//$SQL = "SELECT name, type FROM drugs_available";
		$SQL = "call sp_appointment_sel_all_empl('".$start." 08:00:00','".$end." 18:00:00')";
		//echo ($SQL);
		
		//$SQL = "call sp_appointment_sel_empl('2016-04-18 08:00:00', '2016-04-18 18:00:00',1)";
		
		//Execute the SQL statement
		
		$results = mysqli_query($link, $SQL); //this holds all work_days employee is scheduled for
		
		//echo (mysqli_fetch_row($results));
		
		//Retrieve the rows returned
		while ($row = mysqli_fetch_row($results))
		{
			//Each userObject represents one user
			$userObject = array(); //This array will be used as a dictionary (key, value)
			$userObject["time"] = $row[0];	//(key, value) => (id => $row[0])
			$userObject["pid"] = 1;
			$userObject["comment"] = $row[2]." ".$row[3];
			$userObject["end"] = $row[1];
		
			$array[] = $userObject; //Add the user information to the array that will be returned to the user
			//$array[] = ... => similar to array.push or array.add in other languages
		}
		return $array;
	}
	
	function getPatientName($pid)
	{
		global $link;
		//The array that will be populated with the data
		$array = array();
	
	
		//Create the SQL statement
		//$SQL = "SELECT name, type FROM drugs_available";
		$SQL = "call sp_patient_sel_ID($pid)";
		//echo ($SQL);
	
		//$SQL = "call sp_appointment_sel_empl('2016-04-18 08:00:00', '2016-04-18 18:00:00',1)";
	
		//Execute the SQL statement
	
		$results = mysqli_query($link, $SQL); //this holds all work_days employee is scheduled for
	
		//echo (mysqli_fetch_row($results));
	
		//Retrieve the rows returned
		while ($row = mysqli_fetch_row($results))
		{
			//Each userObject represents one user
			$userObject = array(); //This array will be used as a dictionary (key, value)
			$userObject["first"] = $row[0];	//(key, value) => (id => $row[0])
			$userObject["last"] = $row[1];
	
			$array[] = $userObject; //Add the user information to the array that will be returned to the user
			//$array[] = ... => similar to array.push or array.add in other languages
		}
		return $array;
	}
	
	
	
	function addAppt($comment,$start,$did)
	{
		global $link;
		
		//Grab our authorization cookie array
		$cookie = $_COOKIE['cliniclogauth'];
			
		//Set our user and authID variables
		$user = $cookie['user'];
		$authID = $cookie['authID'];
		
		$table = 'Clinic_user';
		$sql = "SELECT * FROM $table WHERE Username = '" . $user . "'";
		$results = mysqli_query($link, $sql);
		
		//Kill the script if the submitted username doesn't exit
		if (!$results) {
			return "User not found";
			die('Sorry, that username does not exist!');
			
		}
		
		//Fetch our results into an associative array
		$results = mysqli_fetch_assoc( $results );
		
		$pid = $results['Patient_id'];
		
		$table = 'Employee';
		$sql = "SELECT Employee_id FROM $table WHERE Doctor_id = ". $did."";
		$results = mysqli_query($link, $sql);
		
		$results = mysqli_fetch_assoc($results);
		
		$eid = $results['Employee_id'];
		
		$start = str_replace("/"," ",$start);
		
		$date = explode(" ", $start);
		
		
		$table = 'Scheduled_for';
		$sql= "SELECT * FROM $table WHERE Employee_id = $eid and Work_day_date = '".$date[0]."'";
		
		
		$results = mysqli_query($link, $sql);
		$results = mysqli_fetch_assoc($results);
		//echo $results['Employee_id'];
		if ($results =="")
		{
			return "The doctor is not working on this day";
		}
	
		//Create the SQL statement
		//echo $link;
		$SQL = "CALL sp_appointment_ins('". $start."' ,".$pid.", null,".$did.",'Y','".$comment."','N')";
	
		//echo $SQL;
	
		//Execute the SQL statement
		$results = mysqli_query($link, $SQL);
		if ($results == "")
		{
			//echo ("false");
			return "Error: Appointment not added";
		}
		
	
		return "Success";
	}
	
	function addApptPid($comment,$start,$did,$pid)
	{
		global $link;
		
		$table = 'Employee';
		$sql = "SELECT Employee_id FROM Employee WHERE Doctor_id = $did";
		$results = mysqli_query($link, $sql);
		
		$results2 = mysqli_fetch_assoc($results);
		
		$eid = $results2['Employee_id'];
		
		
		$start = str_replace("/"," ",$start);
		
		$date = explode(" ", $start);
		
		$table = 'Scheduled_for';
		$sql= "SELECT * FROM $table WHERE Employee_id = $eid and Work_day_date = '$date[0]'";
		
		$results = mysqli_query($link, $sql);
		$results = mysqli_fetch_assoc($results);
		//echo $results['Employee_id'];
		if ($results =="")
		{
			return "The doctor is not working on this day";
		}
	
	
		//Create the SQL statement
		//echo $link;
		$SQL = "CALL sp_appointment_ins('$start' ,$pid,null,$did,'Y','$comment','N')";
		
	
		
	
		//Execute the SQL statement
		$results = mysqli_query($link, $SQL);
		if ($results == "")
		{
			//echo ("false");
			return "Error: Appointment not added";
		}
	
	
		return "Success";
	}
	
	//Deletes the user from the database and returns a boolean value to indicate whether it was successful or not
	function deleteUser($id)
	{
		global $link;
		
		//Clean all the variables that you will use in creating your SQL statement to avoid "SQL Injection"
		$id = mysqli_real_escape_string($link, $id);
		
		//Create the SQL statement
		$SQL = "DELETE FROM user_table WHERE id = ".$id;
		
		//Execute the SQL statement
		$results = mysqli_query($link, $SQL);
		
		return true;
	}
	/*
	function getAppointments($start, $end)
	{
		global $link;
		
		$startDate = explode("-", $start); // YYYY-MM-DD
		$endDate = explode("-", $end); // YYYY-MM-DD
		
		
		
		$array = array();
		
		
		while ($startDate[2] <= $endDate[2])
		{
			
			$startString = implode("-",$startDate);
			echo $startString;
			
		
			$SQL = "call procedureName('".$startString."')";
			
			$results = mysqli_query ($link, $SQL);
			
			while ($row = mysqli_fetch_row ($results))
			{
				$userObject["id"] = $row[0]."d".$row[1]; //patient ID in first, concat with d and doctorID in second
				$userObject["title"] = $row[2]; //reason for appt in [2]
				$userObject["start"] = $row[3]; //full date for appt in [3]
				$array[] = $userObject;
				
				
			}
			$startDate[2] ++;
			$startDate[2] = str_pad($startDate[2], 2, '0', STR_PAD_LEFT);
		}
		return $array;
	}
	
	function addAppointment($start,$pid,$did,$reason)
	{
		global $link;
		
		$appt = mysqli_real_escape_string($link,$pid,$did,$start,$reason)
		
		//have to search for the family doctor from patient id
		
		//then search if room is occupied, if not use room 2
		
		$SQL = //insert SQL here
		
		$results = mysqli_query($link, $SQL);
		
		return true;
	}
	
	//employee update
	function updateEmployee($id, $type, $fname, $lname, $gender, $sdate, $edate, $sin, $active, $pnumber, $address, $did, $speciality, $certification, $workstation)
	{
		global $link;
		$emp = mysqli_real_escape_string($link,$id, $type, $fname, $lname, $gender, $sdate, $edate,  $sin, $active, $pnumber, $address, $did, $speciality, $certification, $workstation );
		
		$SQL = "call sp_employee_upd(".$id.",'".$type."','". $fname . "','" . $lname . "','" 
			 . $gender . "','" . $sdate . "','" . $edate . "','"
			 . $sin . "','" . $active . "','" . $pnumber . "','" 
			 . $address . "'," . $did . ",'" . $speciality . "','" 
			 . $certification . "'," . $workstation . ")";
		
		$results = mysqli_query($link, $SQL);
		
		return true;
	}
	
	//employee insert
	function addEmployee( $type, $fname, $lname, $gender, $sin, $active, $pnumber, $address, $did, $speciality, $certification, $workstation)
	{
		global $link;
		$emp = mysqli_real_escape_string($link,$type, $fname, $lname, $gender, $sin, $active, $pnumber, $address, $did, $speciality, $certification, $workstation );
	
		$SQL = "call sp_employee_ins('".$type."','". $fname . "','" . $lname . "','" 
			 . $gender . "','" . $sdate . "','" . $edate . "','"
			 . $sin . "','" . $active . "','" . $pnumber . "','" 
			 . $address . "'," . $did . ",'" . $speciality . "','" 
			 . $certification . "'," . $workstation . ")";
		
	
		$results = mysqli_query($link, $SQL);
	
		return true;
	}
	//employee delete
	
	function deleteEmployee($eid)
	{
		global $link;
		$emp = mysqli_real_escape_string($link, $eid);
		
		$SQL = "call sp_employee_del(".$eid.")";
		
		$results = mysqli_query($link, $SQL);
		return true;
	}
	
	//delete employee schedule
	function deleteEmpSched($eid, $date)
	{
		global $link;
		$emp = mysqli_real_escape_string($link, $eid, $date);
		
		$SQL ="call sp_employee_schedule_del(".$eid.",'" .$date."')";
		
		$results = mysqli_query($link, $SQL);
		return true;
	}
	
	//insert employee schedule
	function insertEmpSched($eid, $date, $start, $end)
	{
		global $link;
		$emp = mysqli_real_escape_string($link,$eid, $date, $start, $end);
		
		$SQL = "call sp_employee_schedule_ins(".$eid.",'" .$date."','" .$start . "','" . $end."')";
		
		$results = mysqli_query($link, $SQL);
		return true;
	}
	
	//select employee schedule
	function getEmpSched($eid, $date)
	{
		global $link;
		$emp = mysqli_real_escape_string($link, $eid, $date);
		
		$SQL = "call sp_employee_schedule_sel(".$eid.",' .$date."')";
		
		$results = mysqli_query($link, $SQL);
		return true;
	}
	
	//update employee schedule
	//select employee
	//insert patient bill
	//select patient bill
	//update patient bill
	//insert work day

	*/
	
	
?>