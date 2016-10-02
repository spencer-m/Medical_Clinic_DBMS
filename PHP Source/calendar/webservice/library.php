<?php
	require_once("../loadFiles.php");
	//#######################
	//# DATABASE CONNECTION #
	//#######################
	
	//$CONNECTION_HOST = "localhost";
	$CONNECTION_HOST = 'localhost:3306';
	$CONNECTION_USER = 'root';
	//$CONNECTION_PASSWORD = "";
	$CONNECTION_PASSWORD = '';
	//$CONNECTION_DATABASE = "healthcareclinic";
	$CONNECTION_DATABASE = 'HealthcareClinic';
	
	//$link = mysqli_connect($CONNECTION_HOST, $CONNECTION_USER, $CONNECTION_PASSWORD, $CONNECTION_DATABASE);

	if (!$link)
	{
		echo mysqli_connect_error($link);
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
		$array = array();
	
		//Create the SQL statement
		//$SQL = "SELECT name, type FROM drugs_available";
		$SQL = "call sp_appointment_sel_cal('".$start." 08:00:00','".$end." 18:00:00',".$did.")";
	
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
	
	//Adds the user to the database and returns a boolean value to indicate whether it was successful or not
	function addUser($name)
	{
		global $link;
		
		//Clean all the variables that you will use in creating your SQL statement to avoid "SQL Injection"
		$name = mysqli_real_escape_string($link, $name);
		
		//Create the SQL statement
		//echo $link;
		$SQL = "CALL sp_doctor_drugs_ins('". $name."' , 'ddd')";
		
		echo $SQL;
		
		//Execute the SQL statement
		$results = mysqli_query($link, $SQL);
		
		return true;
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
			die('Sorry, that username does not exist!');
		}
		
		//Fetch our results into an associative array
		$results = mysqli_fetch_assoc( $results );
		
		$pid = $results['Patient_id'];
		
		$start = str_replace("/"," ",$start);
	
		//Create the SQL statement
		//echo $link;
		$SQL = "CALL sp_appointment_ins('". $start."' , 8,1,".$pid.",".$did.",".$did.",'Y','".$comment."','N')";
	
		echo $SQL;
	
		//Execute the SQL statement
		$results = mysqli_query($link, $SQL);
	
		return true;
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