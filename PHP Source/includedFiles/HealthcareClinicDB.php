<?php
// The following code is a modified version of the code presented in the tutorial video:
// https://www.youtube.com/watch?v=X6RNprqUPQc
// The source can subsequently be found on: http://www.johnmorrisonline.com/lesson/how-to-create-an-advanced-login-system/
// NOTE: We have added many of our own functions to in this file...

// Our database class
if(!class_exists('HealthcareClinicDB')){
	class HealthcareClinicDB {
		/**
		 * Connects to the database server and selects a database
		 *
		 * PHP4 compatibility layer for calling the PHP5 constructor.
		 *
		 * @uses healthcareClinicDB::__construct()
		 *
		 */	
		/*function HealthcareClinicDB() {
			return $this->__construct();
		}*/
		
		/**
		 * Connects to the database server and selects a database
		 *
		 * PHP5 style constructor for compatibility with PHP5. Does
		 * the actual setting up of the connection to the database.
		 *
		 */
		function __construct() {
			$this->connect();
		}
	
		/**
		 * Connect to and select database
		 *
		 * @uses the constants defined in config.php
		 */	
		function connect() {
		 
			$link = mysqli_connect('localhost:3306', DB_USER, DB_PASS, DB_NAME);
			
			if (!$link) {
				die('Could not connect: ' . mysqli_connect_error());
			}

			//$db_selected = mysql_select_db(DB_NAME, $link);

			//if (!$db_selected) {
			//	die('Can\'t use ' . DB_NAME . ': ' . mysql_error());
			//}
		}
		
		/**
		 * Clean the array using mysql_real_escape_string
		 *
		 * Cleans an array by array mapping mysql_real_escape_string
		 * onto every item in the array.
		 *
		 * @param array $array The array to be cleaned
		 * @return array $array The cleaned array
		 */
		function cleanInputs($array) {
			//$link = mysqli_connect('localhost:3306', DB_USER, DB_PASS, DB_NAME);
		 /*$cleanedArray =	array_walk($_POST, function(&$string) use ($link) 
		 																{ 
  																				$string = mysqli_real_escape_string($link, $string);
																			});*/
			$cleanedArray = $array;//array_map('mysqli_real_escape_string', $array);
			return $cleanedArray;
		}
		
		/**
		 * Create a secure hash
		 *
		 * Creates a secure copy of the user password for storage
		 * in the database.
		 *
		 * @param string $password The user's created password
		 * @param string $nonce A user-specific NONCE
		 * @return string $secureHash The hashed password
		 */
		function hash_password($password, $nonce) {
		  $secureHash = hash_hmac('sha512', $password . $nonce, SITE_KEY);
		  
		  return $secureHash;
		}
		
		/**
		 * Select data from the database
		 *
		 * Grabs the requested data from the database.
		 *
		 * @param string $table The name of the table to select data from
		 * @param string $columns The columns to return
		 * @param array $where The field(s) to search a specific value for
		 * @param array $equals The value being searched for
		 */
		function select($sql) {
			$link = mysqli_connect('localhost:3306', DB_USER, DB_PASS, DB_NAME);
			if (!$link) {
				die('Could not connect: ' . mysqli_connect_error());
			}
				
			$results = mysqli_query($link, $sql);
				
			if (!mysqli_query($link,$sql))
			{
				die('Error: ' . mysqli_error($link));
			}
				
			return $results;
		}
		
		/**
		 * Insert data into the database
		 *
		 * Does the actual insertion of data into the database.
		 *
		 * @param resource $link The MySQL Resource link
		 * @param string $table The name of the table to insert data into
		 * @param array $fields An array of the fields to insert data into
		 * @param array $values An array of the values to be inserted
		 */
		function insert($link, $table, $fields, $values) {
			$fields = implode(", ", $fields);
			$values = implode("', '", $values);
			$sql="INSERT INTO $table (id, $fields) VALUES ('', '$values')";

			if (!mysql_query($sql)) {
				die('Error: ' . mysql_error());
			} else {
				return TRUE;
			}
		}
		
		// Inventory:
		function insertDrug($DIN, $name, $type)
		{
				$link =  mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
				
				if (!$link) {
					die('Could not connect: ' . mysqli_connect_error());
				}
				
				$sql = "CALL sp_doctor_drugs_ins($DIN, '$name', '$type')";

				if(!mysqli_query($link, $sql))
				{
				  mysqli_close($link);
						return False;
				}
				else
				{
						mysqli_close($link);
						return True;
				}
		}
		
		function updDrug($id, $name, $type)
		{
				$link =  mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
			
				if (!$link) {
					die('Could not connect: ' . mysqli_connect_error());
				}
				//echo $id,$name,$type;
				$sql = "CALL sp_doctor_drugs_upd($id, '$name', '$type')";

				if(!mysqli_query($link, $sql))
				{
				  die('Error: ' . mysqli_error($link));
						return FALSE;
				}
				else
				{ 
						return TRUE;
				}
		}	
		
		function delDrug($id)
		{
				$link =  mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
			
				if (!$link) {
					die('Could not connect: ' . mysqli_connect_error());
				}

				$sql = "CALL sp_doctor_drugs_del(".$id.")";
				if(!mysqli_query($link, $sql))
				{
				  die('Error: ' . mysqli_error($link));
				  mysqli_close($link);
						return FALSE;
				}
				else
				{ 
				  mysqli_close($link);
						return TRUE;
				}
				
		}	
		
		function selectDrugs($id, $type)
		{
		  $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
		  $sql = "CALL sp_doctor_drugs_sel('$id', '$type')";
		  
    $result = mysqli_query($link, $sql);
    
    if (!$result) {
			  	die('Error: ' . mysqli_error($link));
			 } else {
				 return $result;
			 }
    
		}
		
		function insertEquipment($name, $manuf, $rnum)
		{
		   $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
		   
		   if (!$link) {
						die('Could not connect: ' . mysqli_connect_error());
					}
		   
		   $sql = "CALL sp_doctor_equipment_ins('$name','$manuf', '$rnum')";
		   
		   if (!mysqli_query($link, $sql))
		   {
		     mysqli_close($link);
						 return False;
		   } else {
		   		mysqli_close($link);
						 return True;
		   }
		}
		
		function updEquipment($id, $name, $manuf, $rnum)
		{
		  $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
		  
		  if (!$link) {
					die('Could not connect: ' . mysqli_connect_error());
				}
				$sql = "CALL sp_doctor_equipment_upd($id,'$name','$manuf','$rnum')";
				
				if(!mysqli_query($link, $sql))
				{
				  die('Error: ' . mysqli_error($link));
				  mysqli_close($link);
						return FALSE;
				}
				else
				{ 
						mysqli_close($link);
						return TRUE;
				}
		}
		
		function delEqp($id)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
				if (!$link) {
					die('Could not connect: ' . mysqli_connect_error());
				}
				
				$sql = "CALL sp_doctor_equipment_del(".$id.")";
				if(!mysqli_query($link, $sql))
				{
				  die('Error: ' . mysqli_error($link));
				  mysqli_close($link);
						return FALSE;
				}
				else
				{ 
				  mysqli_close($link);
						return TRUE;
				}
					
		}
		
		function selectEquipment($name, $room_number, $group, $id)
		{
					$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
		   
		   if (!$link) {
						die('Could not connect: ' . mysqli_connect_error());
					}
					
					$sql = "CALL sp_doctor_equipment_sel('$name', '$room_number', '$group', '$id')";
					
					$result = mysqli_query($link, $sql);
					
					if (!$result) {
			  	 die('Error: ' . mysqli_error($link));
			  } else {
				   return $result;
			  }
					
		}
		
		function insertSupplies($name, $supp, $rnum, $amt)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
		   
		   if (!$link) {
						die('Could not connect: ' . mysqli_connect_error());
					}
					
					$sql = "CALL sp_doctor_supplies_ins('$name', '$supp', $rnum, $amt)";
					
					if (!mysqli_query($link, $sql))
		   {
		     mysqli_close($link);
						 return False;
		   } else {
		   		mysqli_close($link);
						 return True;
		   }
		}
		
		function listSupplies($room_number, $supplies_name, $group_flag)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "CALL sp_doctor_supplies_sel('$room_number', '$supplies_name', '$group_flag')";
				
				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
		}

		function selectSupplies($id, $rnum, $room_info)
		{
		  $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
		  
		  if (!$link) {
						die('Could not connect: ' . mysqli_connect_error());
					}
					if ($room_info == FALSE)
					{ 
							$sql = "SELECT ID
																					,Name
																					,Supplier																	 
																	FROM Supplies 
																WHERE ID = $id";
					}
					else {
							$sql = "SELECT * 
							          FROM Supplies as s JOIN Room_Supplies_Xref as rsx ON s.ID = rsx.Supplies_ID 
							         WHERE s.ID = $id and rsx.Room_number = $rnum";
					}
					$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
				  mysqli_close($link);
						return $result;
				}
		}
		
		function updSupplies($id, $room, $name, $supp, $amt)
		{
		  $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
		  
		  if (!$link) {
						die('Could not connect: ' . mysqli_connect_error());
				}
				
				$sql = "CALL sp_doctor_supplies_upd($id, $room, '$name', '$supp', $amt)";
				//echo $sql;
				if (!mysqli_query($link, $sql))
		   {
		     mysqli_close($link);
						 return False;
		   } else {
		   		mysqli_close($link);
						 return True;
		   }
		}
		
		function delSupplies($id, $rnum)
		{
			 $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME);
				if (!$link) {
					die('Could not connect: ' . mysqli_connect_error());
				}
				
				$sql = "CALL sp_doctor_supplies_del($id, $rnum)";
				if(!mysqli_query($link, $sql))
				{
				  die('Error: ' . mysqli_error($link));
				  mysqli_close($link);
						return FALSE;
				}
				else
				{ 
				  mysqli_close($link);
						return TRUE;
				}
				
		}

		// Billing

		function selectBilling($id)
		{
			$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
		  
			if (!$link) {
				die('Could not connect: ' . mysqli_connect_error());
			}
			
			$sql = "CALL sp_billing_sel($id, '')";
					
			$result = mysqli_query($link, $sql);
					
			if (!$result) {
				die('Error: ' . mysqli_error($link));
			} else {
				return $result;
			}
		}

		function viewBilling($flag)
		{
			$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
		  
			if (!$link) {
				die('Could not connect: ' . mysqli_connect_error());
			}
			
			$sql = "CALL sp_billing_sel('', $flag)";
					
			$result = mysqli_query($link, $sql);
					
			if (!$result) {
				die('Error: ' . mysqli_error($link));
			} else {
				return $result;
			}
		}

		function updateBilling($id, $paid) 
		{
			$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
		  
			if (!$link) {
				die('Could not connect: ' . mysqli_connect_error());
			}
				
			$sql = "CALL sp_billing_upd($id, $paid)";
			echo $sql;
			
			if (!mysqli_query($link, $sql))
			{
		    	mysqli_close($link);
				return False;
		   } else {
		   		mysqli_close($link);
				return True;
		   }
		}
	
		function insertPatient($link, $firstname, $lastname, $sinnumber, $hcnumber, $address, $phonenumber, $allergies, $username, $password, $email, $regdate)
		{
				$link = mysqli_connect('localhost:3306', DB_USER, DB_PASS, DB_NAME);
				//echo $link, $firstname, $lastname, $sinnumber, $hcnumber, $address, $phonenumber, $allergies, $username, $password, $email, $regdate;
				$sql="CALL sp_patient_ins('$firstname', '$lastname', '$sinnumber', '$hcnumber', '$address', '$phonenumber',
																									     '$allergies', '$username', '$password', '$email', $regdate);";
				//$sql="CALL sp_patient_ins('Luke', 'Toenjes', '1', '2', '3', '4',
				//																					     'none', 'lrtoenje', '5', 'luke@example.com', 123456789)";
				
				if (!mysqli_query($link,$sql)) 
				{
						die('Error: ' . mysqli_error($link));
				} else {
					return TRUE;
				}
		
		}
		
		function selPatient($fname, $lname, $hc_num)
		{
		
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "CALL sp_patient_sel('$fname', '$lname', '$hc_num')";

				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
		}
		
		function updPatient($id, $fname, $lname, $allergies, $address, $pnum)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "CALL sp_patient_upd($id, '$fname', '$lname', '$allergies', '$address', '$pnum')";
				
				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
				
		}
		
		function selEmployee($eid, $etype, $fname, $lname, $active_flag, $d_id, $spec, $cert)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				if (empty($eid) )
				{
						$eid = -1;
				}
				if (empty($d_id))
				{
						$d_id = -1;
				}
				$sql = "CALL sp_employee_sel($eid, '$etype', '$fname', '$lname', '".ucfirst($active_flag)."', $d_id, '$spec', '$cert')";

				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
		}
		
		
		function insertEmployee($eType, $firstname, $lastname, $gender, $sinnumber, $startdate, $phonenumber, $address, $docID, $spec, $cert, $wsn, $username, $password, $email, $regdate)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "CALL sp_employee_ins('$eType', '$firstname', '$lastname', '$gender', '$sinnumber', '$startdate', '$phonenumber', 
				                             '$address', $docID, '$spec', '$cert', $wsn, '$username', '$password', '$email', $regdate)";
				                             
				if (!mysqli_query($link,$sql)) 
				{
						die('Error: ' . mysqli_error($link));
				} else {
					return TRUE;
				}
		}
		
		
		function updEmployee($eid, $fname, $lname, $gender, $active, $address, $pnum, $speciality, $certification, $wsn)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "CALL sp_employee_upd($eid, '$fname', '$lname', '$gender', '$active', '$address', '$pnum', '$speciality', '$certification', $wsn)";
				
				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
		}
		
		
		function selPatientAppt($id, $start_date, $end_date, $doctor_lname, $balance)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				if (empty($balance))
				{
						$balance = -1.0;
				}
				
				$sql =  "CALL sp_patient_appt_detail_sel($id, '$start_date', '$end_date', '$doctor_lname', $balance)";
				
				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
				
		}
		
		function updPatientAppt($appt_id, $pid, $date, $reason, $doctor, $nurse, $family_dr, $walkin, $invoice_number, $amount, $balance, $paid)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				
				if (!empty($doctor))
				{
						$sql = "select Doctor_id
																from Employee
															where concat(First_name, ' ', Last_name) like '$doctor'";
						
						$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));

						$result = mysqli_query($link,$sql);
						$r = mysqli_fetch_array($result);
						$docID = $r['Doctor_id'];
    }

				if (!empty($nurse))
				{
						$sql = "select Employee_id
																from Employee
															where concat(First_name, ' ', Last_name) like '$nurse'";
				
						$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));

						$result = mysqli_query($link,$sql);
						$r = mysqli_fetch_array($result);
						$e_id = $r['Employee_id'];
				}
				
				if (empty($amount))
				{
						$amount = -1;
				}
				if (empty($balance))
				{
						$balance = -1;
				}
				if (empty($paid))
				{
						$paid = -1;
				}
				if (empty($docID))
				{
						$docID = -1;
				}
				if (empty($e_id))
				{
						$e_id = -1;
				}
				if ($invoice_number == 'N/A')
				{
						$invoice_number = -1;
				}
				
				$sql = "CALL sp_patient_appointment_upd ($appt_id, $pid, $docID, $e_id, '$date', '$reason', '$doctor', '$nurse', '$family_dr', '$walkin', $invoice_number, $amount, $balance, $paid)";
				echo $sql;
				$result = mysqli_query($link, $sql);
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
				
		}
		
		function selPatientMedicalHist($id, $doctor_lname, $start_date, $end_date)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "CALL sp_doctor_medicalHistory_sel($id, '$doctor_lname', '$start_date', '$end_date')";
				
				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
		}
		
		function selAppointments($docID, $start_date, $end_date, $patient_id)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "CALL sp_appointment_sel($docID, '$start_date', '$end_date', $patient_id)";
				
				
				$result = mysqli_query($link, $sql);
				
				if (!$result) {
						die('Error: ' . mysqli_error($link));
				} else {
						return $result;
				}
		}		
		
		function insertMedicalHistory($appt_id, $comments, $amount, $balance)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				if (empty($amount))
				{
						$amount = 0;
				}
				if (empty($balance))
				{
						$balance = 0;
				}
				
				$sql = "CALL sp_doctor_medicalHistory_ins($appt_id, '$comments', $amount, $balance)";
				
				$result = mysqli_query($link,$sql);
				if (!$result) 
				{
						die('Error: ' . mysqli_error($link));
				} else {
					return $result;
				}
		}
		
		function insertMedDrugXref($med_hist_id, $prescription, $refills)
		{
				$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$sql = "insert into Medical_Hist_Drug_Xref (
																			Medical_history_id
																		,Drug_id
																		,Refills
																		,Revision_user
																		,Revision_date
												)
												values (
																			$med_hist_id
																		,$prescription
																		,$refills
																		,user()
																		,now()
												)";
				
				if (!mysqli_query($link,$sql)) 
				{
						die('Error: ' . mysqli_error($link));
				} else {
					return TRUE;
				}
		}
		
	}
}

//Instantiate our database class
$hcdb = new HealthcareClinicDB;
?>