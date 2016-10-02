<?php
// The following code is a modified version of the code presented in the tutorial video:
// https://www.youtube.com/watch?v=X6RNprqUPQc
// The source can subsequently be found on: http://www.johnmorrisonline.com/lesson/how-to-create-an-advanced-login-system/
// Our main class
if(!class_exists('ClinicClass')){
	class ClinicClass {
		
		function checkAccessType()
		{
		  global $hcdb;
				$cookie = $_COOKIE['cliniclogauth'];
    
				//Set our user and authID variables
				$user = $cookie['user'];
				$authID = $cookie['authID'];

				// First we find out if the user logging in, is a Doctor or Employee
				$sql = "SELECT User_type
														FROM Clinic_user
													WHERE Username = '" . $user . "'";
												
				$results = $hcdb->select($sql);
				$r = mysqli_fetch_assoc( $results );
		 
				// If the username does not exist, kill the script
				if (!$results) {
					die('Sorry, that username does not exist!');
				}
		
				$userType = $r['User_type'];
				
				return $userType;
		}
		
		function registerPatient($redirect) {
			global $hcdb;
		
			//Check to make sure the form submission is coming from our script
			//The full URL of our registration page
			$current = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];

			//The full URL of the page the form was submitted from
			$referrer = $_SERVER['HTTP_REFERER'];

			/*
			 * Check to see if the $_POST array has date (i.e. our form was submitted) and if so,
			 * process the form data.
			 */
			if ( !empty ( $_POST ) ) {

				/* 
				 * Here we actually run the check to see if the form was submitted from our
				 * site. Since our registration from submits to itself, this is pretty easy. If
				 * the form submission didn't come from the registerPatient.php page on our server,
				 * we don't allow the data through.
				 */
				if ( $referrer == $current ) {
				
					//Require our database class
					require_once('HealthcareClinicDB.php');
						
					//Set up the variables we'll need to pass to our insert method
					//This is the name of the table we want to insert data into
					$table = 'Clinic_user';
					
					//These are the fields in that table that we want to insert data into
					$fields = array('First_name', 'First_name', 'SIN_number', 'Health_care_number', 'Address', 'Phone_number', 'Allergies', 'Username', 'Password', 'Email', 'Date_Registered');
					
					//These are the values from our registration form... cleaned using our clean method
					$values = $hcdb->cleanInputs($_POST);
					
					//Now, we're breaking apart our $_POST array, so we can store our password securely
					$firstname = $_POST['First_name'];
					$lastname = $_POST['Last_name'];
					$sinnumber = $_POST['SIN_number'];
					$hcnumber = $_POST['Health_care_number'];
					$address = $_POST['Address'];
					$phonenumber = $_POST['Phone_number'];
					$allergies = $_POST['Allergies'];
					$username = $_POST['Username'];
					$password = $_POST['Password'];
					$email = $_POST['Email'];
					$regdate = $_POST['Date_registered'];
					
					//We create a NONCE using the action, username, timestamp, and the NONCE SALT
					$nonce = md5('registration-' . $username . $regdate . NONCE_SALT);
					
					//We hash our password
					$password = $hcdb->hash_password($password, $nonce);
					/*
					//Recompile our $value array to insert into the database
					$values = array(
								'First_name' => $firstname,
								'username' => $userlogin,
								'password' => $userpass,
								'email' => $useremail,
								'date' => $userreg
							);
					
					//And, we insert our data
					$insert = $hcdb->insert($link, $table, $fields, $values);
					*/
					$insert = $hcdb->insertPatient($link, $firstname, $lastname, $sinnumber, $hcnumber, $address, $phonenumber, $allergies, $username, $password, $email, $regdate);
					
					if ( $insert == TRUE ) {
						$url = "http" . ((!empty($_SERVER['HTTPS'])) ? "s" : "") . "://".'localhost:' . $_SERVER['SERVER_PORT'] .$_SERVER['REQUEST_URI'];
						$aredirect = str_replace('registerPatient.php', $redirect, $url);
						
						header("Location: $redirect?reg=true");
						exit;
					}
				} else {
					die('Your form submission did not come from the correct page. Please check with the site administrator.');
				}
			}
		}
		
		function loginUser($redirect) {
			global $hcdb;
		
			if ( !empty ( $_POST ) ) {
				//Clean our form data
				$values = $hcdb->cleanInputs($_POST);
				//echo $values;
				//The username and password submitted by the user
				$enteredname = $_POST['Username'];
				$enteredpass = $_POST['Password'];
				
				//The name of the table we want to select data from
				$table = 'Clinic_user';

				/*
				 * Run our query to get all data from the users table where the user 
				 * login matches the submitted login.
				 */
				$sql = "SELECT * FROM $table WHERE Username = '" . $enteredname . "'";
				$results = $hcdb->select($sql);
				
				//Kill the script if the submitted username doesn't exit
				if (!$results) {
					die('Sorry, that username does not exist!');
				}

				//Fetch our results into an associative array
				$results = mysqli_fetch_assoc( $results );
				
				//The registration date of the stored matching user
				$storedregdate = $results['Date_registered'];
				
				//The hashed password of the stored matching user
				$storedpass = $results['Password'];
				
				//Recreate our NONCE used at registration
				$nonce = md5('registration-' . $enteredname . $storedregdate . NONCE_SALT);

				//Rehash the submitted password to see if it matches the stored hash
				$enteredpass = $hcdb->hash_password($enteredpass, $nonce);
				
				//Check to see if the submitted password matches the stored password
				if ( $storedpass == $enteredpass ) {
					//If there's a match, we rehash password to store in a cookie
					$authnonce = md5('cookie-' . $enteredpass . $storedregdate . AUTH_SALT);
					$authID = $hcdb->hash_password($enteredpass, $authnonce);
					
					//Set our authorization cookie
					setcookie('cliniclogauth[user]', $enteredname, 0, '', '', '', true);
					setcookie('cliniclogauth[authID]', $authID, 0, '', '', '', true);
					
					//Build our redirect
					$url = "http" . ((!empty($_SERVER['HTTPS'])) ? "s" : "") . "://".'localhost:' . $_SERVER['SERVER_PORT'] .$_SERVER['REQUEST_URI'];
					$redirect = str_replace('login.php', $redirect, $url);
     
					//Redirect to the home page
					//header("Location: $redirect");
					header("Location: $redirect");
					exit;
				 //exit;
				} else {
					return 'invalid';
				}
			} else {
				return 'empty';
			}
		}
		
		function logout() {
			//Expire our auth coookie to log the user out
			$idout = setcookie('cliniclogauth[authID]', '', -3600, '', '', '', true);
			$userout = setcookie('cliniclogauth[user]', '', -3600, '', '', '', true);
			
			if ( $idout == true && $userout == true ) {
				return true;
			} else {
				return false;
			}
		}
		
		function checkUserLogin() {
			global $hcdb;
		
			//Grab our authorization cookie array
			$cookie = $_COOKIE['cliniclogauth'];
			
			//Set our user and authID variables
			$user = $cookie['user'];
			$authID = $cookie['authID'];
			
			/*
			 * If the cookie values are empty, we redirect to login right away;
			 * otherwise, we run the login check.
			 */
			if ( !empty ( $cookie ) ) {
				
				//Query the database for the selected user
				$table = 'Clinic_user';
				$sql = "SELECT * FROM $table WHERE Username = '" . $user . "'";
				$results = $hcdb->select($sql);

				//Kill the script if the submitted username doesn't exit
				if (!$results) {
					die('Sorry, that username does not exist!');
				}

				//Fetch our results into an associative array
				$results = mysqli_fetch_assoc( $results );
		
				//The registration date of the stored matching user
				$storeg = $results['Date_registered'];

				//The hashed password of the stored matching user
				$stopass = $results['Password'];

				//Rehash password to see if it matches the value stored in the cookie
				$authnonce = md5('cookie-' . $user . $storeg . AUTH_SALT);
				$stopass = $hcdb->hash_password($stopass, $authnonce);
				
				if ( $stopass == $authID ) {
					$results = true;
				} else {
					$results = false;
				}
			} 
			else {
				//Build our redirect
				//$url = "http" . ((!empty($_SERVER['HTTPS'])) ? "s" : "") . "://".'localhost:8888';//.$_SERVER['REQUEST_URI'];
							
				// always force them to this location
				//$redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/login.php';
			 //	$redirect = 'http://localhost/login.php';
		
				//Redirect to the home page
				//header("Location: $redirect?msg=login");
				$redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/login.php?msg=login';
							//header('Location: $redirect?msg=updated');
							//exit;
				echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
				exit;
			}
			
			return $results;
		}
		
		function updatePatient($id, $rdr)
		{
		   global $hcdb;
		   if (isset($_POST['submit']))
				 {
				 			$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				 			
				 			$fname = mysqli_real_escape_string($link, $_POST['FirstName']);
				 			$lname = mysqli_real_escape_string($link, $_POST['LastName']);
				 			$allergies = mysqli_real_escape_string($link, $_POST['Allergies']);
				 			$address = mysqli_real_escape_string($link, $_POST['Address']);
				 			$pnum = mysqli_real_escape_string($link, $_POST['PhoneNumber']);
				 			
				 			$result = $hcdb->updPatient($id, $fname, $lname, $allergies, $address, $pnum);
					
				 			if(!$result) {
									  echo "<script type='text/javascript'>alert('";
								  	echo mysqli_error($link);	
								  	echo "'); window.location='$rdr';</script>";
								}
								else {
										 mysqli_close($link);	
										 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/people/'.$rdr.'?msg=updated';
										 echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
										 return TRUE;
								}
					 }
				 			
				}
				
				function registerEmployee($rdr)
				{
						global $hcdb;
		
						//Check to make sure the form submission is coming from our script
						//The full URL of our registration page
						$current = 'http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI'];

						//The full URL of the page the form was submitted from
						$referrer = $_SERVER['HTTP_REFERER'];

						/*
							* Check to see if the $_POST array has date (i.e. our form was submitted) and if so,
							* process the form data.
							*/
						if ( !empty ( $_POST ) ) {
								if ( $referrer == $current ) {
								  $eType = $_POST['Employee_Type'];
										$firstname = $_POST['First_name'];
										$lastname = $_POST['Last_name'];
										$gender = $_POST['Gender'];
										$sinnumber = $_POST['SIN_number'];
										$startdate = $_POST['Start_Date'];
										$phonenumber = $_POST['Phone_number'];
										$address = $_POST['Address'];
										$docID = $_POST['Doctor_ID'];
										$spec = $_POST['Speciality'];
										$cert = $_POST['Certification'];
										$wsn = $_POST['Work_Station_Number'];
										$username = $_POST['Username'];
										$password = $_POST['Password'];
										$email = $_POST['Email'];
										$regdate = $_POST['Date_registered'];
										
										if (empty($docID))
										{
												$docID = -1;
										}
										if (empty($spec))
										{
												$spec = '';										
										}
										if (empty($cert))
										{
												$cert = '';
										}
										if(empty($wsn))
										{
												$wsn = -1;
										}
										
										//We create a NONCE using the action, username, timestamp, and the NONCE SALT
										$nonce = md5('registration-' . $username . $regdate . NONCE_SALT);
					
										//We hash our password
										$password = $hcdb->hash_password($password, $nonce);
										
									 $insert = $hcdb->insertEmployee($eType, $firstname, $lastname, $gender, $sinnumber, $startdate, $phonenumber, $address, $docID, $spec, $cert, $wsn, $username, $password, $email, $regdate);
									 
					
										if ( $insert == TRUE ) {
												$url = "http" . ((!empty($_SERVER['HTTPS'])) ? "s" : "") . "://".'localhost:' . $_SERVER['SERVER_PORT'] .$_SERVER['REQUEST_URI'];
												$aredirect = str_replace('registerEmployee.php', $rdr, $url);
						
												header("Location: $aredirect?reg=true");
												exit;
										}
									 
								}
						  else {
											die('Your form submission did not come from the correct page. Please check with the site administrator.');
								}
						}
				}
				
				function updateEmployee($id, $rdr)
				{
						global $hcdb;
						if (isset($_POST['submit']))
				  {
				 			$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				 			
				 			$fname = mysqli_real_escape_string($link, $_POST['FirstName']);
				 			$lname = mysqli_real_escape_string($link, $_POST['LastName']);
				 			$gender = mysqli_real_escape_string($link, $_POST['Gender']);
				 			$active = mysqli_real_escape_string($link, $_POST['Active']);
				 			$address = mysqli_real_escape_string($link, $_POST['Address']);
				 			$pnum = mysqli_real_escape_string($link, $_POST['PhoneNumber']);
				 			$speciality = mysqli_real_escape_string($link, $_POST['Speciality']);
				 			$certification = mysqli_real_escape_string($link, $_POST['Certification']);
				 			$wsn	= mysqli_real_escape_string($link, $_POST['WorkStationNumber']);
				 			
				 			if (empty($wsn))
				 			{
				 					$wsn = -1;
				 			}
				 			
				 			$result = $hcdb->updEmployee($id, $fname, $lname, strtoupper($gender), $active, $pnum, $address, $speciality, $certification, $wsn);
				 			
				 			if(!$result) {
									  echo "<script type='text/javascript'>alert('";
								  	echo mysqli_error($link);	
								  	echo "'); window.location='$rdr';</script>";
								}
								else {
										 mysqli_close($link);	
										 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/people/'.$rdr.'?msg=updated';
										 echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
										 return TRUE;
								}
				 	}
				}
				
				function updateAppointment($appt_id, $pid, $invoice_number, $date, $rdr)
				{
						if(isset($_POST['submit']))
						{
								global $hcdb;
								
								$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
								
								$newdate = mysqli_real_escape_string($link, $_POST['Date']);
								$reason = mysqli_real_escape_string($link, $_POST['Reason']);
								$doctor = mysqli_real_escape_string($link, $_POST['Doctor']);
								$nurse = mysqli_real_escape_string($link, $_POST['Nurse']);
								$family_dr = mysqli_real_escape_string($link, $_POST['FamilyDr']);
								$walkin = mysqli_real_escape_string($link, $_POST['Walkin']);
								$amount = mysqli_real_escape_string($link, $_POST['Amount']);
								$balance = mysqli_real_escape_string($link, $_POST['Balance']);
								$paid = mysqli_real_escape_string($link, $_POST['Paid']);
								
								if(empty($newdate))
								{
										$apptdate = $date;
								}
								else
								{
										$apptdate = $newdate;
								}
								
								$result = $hcdb->updPatientAppt($appt_id, $pid, $apptdate, $reason, $doctor, $nurse, $family_dr, $walkin, $invoice_number, $amount, $balance, $paid);
								
								if(!$result) {
									  echo "<script type='text/javascript'>alert('";
								  	echo mysqli_error($link);	
								  	echo "'); window.location='$rdr';</script>";
								}
								else {
										 mysqli_close($link);	
										 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'].$rdr.'?msg=updated&Id='.$pid;
										 echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
										 return TRUE;
								}
								
						}
				}
				
				function completeAppointment($appt_id, $rdr)
				{
						if (isset($_POST['submit']))
						{
						  global $hcdb;
								
								$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
								
								$comments = $_POST['Comments'];
								$amount = $_POST['Amount'];
								$balance = $_POST['Balance'];
								
								$prescriptions = $_POST['PrescribedDrugs'];
								$refills = $_POST['Refills'];
								
								$result = $hcdb->insertMedicalHistory($appt_id, $comments, $amount, $balance);
									
								if($result == null) {
									  echo "<script type='text/javascript'>alert('";
								  	echo mysqli_error($link);	
								  	echo "'); window.location='$rdr';</script>";
								}								
								else {
								   $r = mysqli_fetch_array($result);								  
											$med_hist_id = $r['last_inserted'];				
														
											foreach($prescriptions as $a => $b)
											{ 
													$result2 = $hcdb->insertMedDrugXref($med_hist_id, $prescriptions[$a], $refills[$a]);
													//if(!$result2) {
									  			
								  			//	echo mysqli_error($link);		
								  		//		var_dump($result2);								  		 
													//}
											}
											echo "<script type='text/javascript'>alert('Successfully Completed!');</script>";
										 mysqli_close($link);	
										 
										 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT']."/appointment/".$rdr.'?msg=inserted&Id='.$appt_id;
										 echo "<script type='text/javascript'> window.location = '".$redirect."'; </script>";
										 return TRUE;
								}
								
						}
						
				}
		}		
	}

//Instantiate our database class
$c = new ClinicClass;
?>