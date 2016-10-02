<?php
// Inventory Class
if(!class_exists('InventoryClass')){
	class InventoryClass {
	
		function addNewDrug($rdr)
		{
		
				global $hcdb;
				if (isset($_POST['submit']))
				{
					$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
					  
					$DIN = mysqli_real_escape_string($link, $_POST['DIN']);
					$DIN = ltrim($DIN, '0');
					$name = mysqli_real_escape_string($link, $_POST['Name']);					
					$type = mysqli_real_escape_string($link, $_POST['Type']);

					if (!empty($DIN) and !empty($name) and !empty($type) and filter_var($DIN, FILTER_VALIDATE_INT)) {
						$result = $hcdb->insertDrug($DIN, $name, $type);
						if(!$result) {
							echo "<script type='text/javascript'>alert('DIN already exists!'); window.location='$rdr';</script>";
						}
						else {
							$redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=inserted';
							//header('Location: $redirect?msg=updated');
							//exit;
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
						}
					}
					else {
						
						//$redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=null';
						echo "<script type='text/javascript'>alert('Invalid values for the drug!');</script>";
						// window.location='.$redirect.'php';</script>";
					}
				}
		}
		
		function updateDrug($id, $rdr)
		{
		   global $hcdb;
     $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
					
					if (isset($_POST['submit']))
					{ 
						$name = mysqli_real_escape_string($link, $_POST['Name']);					
						$type = mysqli_real_escape_string($link, $_POST['Type']);
						
						$result = $hcdb->updDrug($id, $name, $type);
						
						if(!$result) {
							echo "<script type='text/javascript'>alert('An error occurred!'); window.location='$redirect';</script>";
							return FALSE;
						}
						else {
						 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=updated';
							//header('Location: $redirect?msg=updated');
							//exit;
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
							return TRUE;
						}
					}
		}
		
		function deleteDrug($id,  $rdr)
		{
		   global $hcdb;
     $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
					
					
					// Store the deleted drug name and type so that we can inform the user
					// of the record that was successfully deleted
					$sql = "SELECT Name
																			,Type
															FROM Drugs_available
														WHERE Drug_id = $id";								
					
					$result = $hcdb->select($sql);
					$deleted = mysqli_fetch_array($result);
					
					$name = $deleted['Name'];
					$type = $deleted['Type'];
					
					$result = $hcdb->delDrug($id);
					
					if(!$result) {
							echo "<script type='text/javascript'>alert('An error occurred!'); window.location='$rdr';</script>";
							return FALSE;
						}
						else {
						 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=deleted?msg=ID: '.$id.'?msg=Name: '.$name.'?msg=Type: '.$type;
							//header('Location: $redirect?msg=updated');
							//exit;
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
							return TRUE;
						}
						mysqli_close($link);
					
		}
		
		function addNewEquipment($rdr)
		{
				if (isset($_POST['submit']))
				{
	     
	    global $hcdb; 
	     			 
				 $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				 
					$name = mysqli_real_escape_string($link, $_POST['Name']);					
					$manuf = mysqli_real_escape_string($link, $_POST['Manufacturer']);
					$rnum = mysqli_real_escape_string($link, $_POST['RoomNumber']);
					$rnum = ltrim($rnum, '0');
	
					if (!empty($name) and !empty($manuf) and !empty($rnum) and filter_var($rnum, FILTER_VALIDATE_INT)) {
					
					 $result = $hcdb->insertEquipment($name, $manuf, $rnum);
      					
						if(!$result) {
							echo "<script type='text/javascript'>alert('";
							echo mysqli_error($link);
							echo "'); window.location='".$rdr."';'</script>";
						}
						else {
							$redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=inserted';
							//header('Location: $redirect?msg=updated');
							//exit;
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
						}
					}
					else {
						echo "<script type='text/javascript'>alert('Invalid values for the equipment!'); window.location='$rdr';</script>";
					}
	
					mysqli_close($link);
				}

		}
		
		function updateEquipment($id, $rdr)
		{
				if (isset($_POST['submit']))
				{	 
					global $hcdb;
     $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
	
					
					$name = mysqli_real_escape_string($link, $_POST['Name']);					
					$manuf = mysqli_real_escape_string($link, $_POST['Manufacturer']);

					$rnum = mysqli_real_escape_string($link, $_POST['RoomNumber']);
					$rnum = ltrim($rnum, '0');
					$curr = $_SERVER['REQUEST_URI'];


					if (empty($rnum) or filter_var($rnum, FILTER_VALIDATE_INT)) {

						$result = $hcdb->updEquipment($id, $name, $manuf, $rnum);
						
						if(!$result) {
							echo "<script type='text/javascript'>alert('";
							echo mysqli_error($link);
							echo "'); window.location='$curr';</script>";
						}
						else {
						 mysqli_close($link);	
	      $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=updated';
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
							return TRUE;
						}
					}
					else {
						echo "<script type='text/javascript'>alert('";
						echo "Invalid room number!";
						echo "'); window.location='$curr';</script>";
					}


				 mysqli_close($link);	
				}
		}
		
		function deleteEquipment($id, $rdr)
		{
					global $hcdb;
     $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
     
     $sql = "SELECT Equipment_ID
     														,Name
     														,Manufacturer
      									FROM Equipment
      								WHERE Equipment_id = $id";
     
     $result = $hcdb->select($sql);
					$deleted = mysqli_fetch_array($result);
					
					$name = $deleted['Name'];
					$manuf = $deleted['Manufacturer'];
					
					$result = $hcdb->delEqp($id);
					
					if(!$result) {
							echo "<script type='text/javascript'>alert('An error occurred!'); window.location='$rdr';</script>";
							return FALSE;
						}
						else {
						 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=deleted?msg=ID: '.$id.'?msg=Name: '.$name.'?msg=Manufacturer: '.$manuf;
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
							return TRUE;
						}
						mysqli_close($link);
					
		}
		
		
		function addNewSupplies($rdr)
		{
				if (isset($_POST['submit']))
				{
				 global $hcdb;
					$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));  
	
					$name = mysqli_real_escape_string($link, $_POST['Name']);					
					$supp = mysqli_real_escape_string($link, $_POST['Supplier']);
					$rnum = mysqli_real_escape_string($link, $_POST['RoomNumber']);
					$rnum = ltrim($rnum, '0');
					$amt = mysqli_real_escape_string($link, $_POST['Amount']);
					$amt = ltrim($amt, '0');
					
					if (!empty($rnum) and !empty($name) and !empty($supp) and !empty($amt) and filter_var($rnum, FILTER_VALIDATE_INT) and filter_var($amt, FILTER_VALIDATE_INT)) {
					
					 $result = $hcdb->insertSupplies($name, $supp, $rnum, $amt);
						
						if(!$result) {
							echo "<script type='text/javascript'>alert('";
							echo mysqli_error($link);
							echo "'); window.location='$rdr';</script>";
						}
						else {
							mysqli_close($link);	
							$_POST = $a;
	      $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=inserted';
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
						}
					}
					else {
						echo "<script type='text/javascript'>alert('Invalid values for the supply!'); window.location='$rdr';</script>";
					}
					mysqli_close($link);
				}
		}
		
		function updateSupplies($id, $rdr, $room_update, $room)
		{
				if (isset($_POST['submit']))
				{
				 global $hcdb;
					$link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));  	   
					
				 if ($room_update == True)
					{
					  //echo 'room_update = true';
					  $sid = mysqli_real_escape_string($link, $_GET['SID']);
							$rnum = $room;
							$amt = mysqli_real_escape_string($link, $_POST['Amount']);
					}
					else {
							$sid = mysqli_real_escape_string($link, $_GET['SID']);
				  	$name= mysqli_real_escape_string($link, $_POST['Name']);
					  $supp = mysqli_real_escape_string($link, $_POST['Supplier']);
					}
				
	
					if ($room_update == FALSE)
					{
					  $r = $hcdb->selectSupplies($sid, '', FALSE);
					
				  	$result = mysqli_fetch_array($r);
							if (empty($name)) {
								$name = $result['Name'];
							}
	
							if (empty($supp)) {
								$supp = $result['Supplier'];
							}
					}
					
					if ($room_update == FALSE)
					{ 
					  $result = $hcdb->updSupplies($sid, -1, $name, $supp, -1);
					}
					else
					{
					  //echo $rnum;
							$result = $hcdb->updSupplies($sid, $rnum, '', '', $amt);
					}
					if(!$result) {
						echo "<script type='text/javascript'>alert('Error editing amount');</script>";
						//echo mysqli_error($link);						
						//echo "); window.location='$rdr';</script>";
					}
					else {
							mysqli_close($link);	
	      $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=updated';
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
							return TRUE;
					}
					mysqli_close($link);
				}

				//mysqli_close($link);
		}
		
		function deleteSupplies($id, $rdr)
		{
				global $hcdb;
    $link = mysqli_connect(DB_SERVER, DB_USER, DB_PASS, DB_NAME) or die('Error ' . mysqli_error($link));
				
				$SID = mysqli_real_escape_string($link, $_GET['SID']);

				if (isset($_GET['RoomNumber']) and !empty($_GET['RoomNumber'])) {
					$rnum = mysqli_real_escape_string($link, $_GET['RoomNumber']);
					$result = $hcdb->delSupplies($id, $rnum);
				}
				else {
					$result = $hcdb->delSupplies($id, '');
				}
				
				if(!$result) {
							echo "<script type='text/javascript'>alert('An error occurred!'); window.location='$rdr';</script>";
							return FALSE;
						}
						else {
						 $redirect = 'http://localhost:' . $_SERVER['SERVER_PORT'] . '/inventory/'.$rdr.'?msg=deleted?msg=ID: '.$id.'?msg=Room Number: '.$rnum;
							//header('Location: $redirect?msg=updated');
							//exit;
							echo "<script type='text/javascript'> window.location = '$redirect'; </script>";
							return TRUE;
						}
						mysqli_close($link);
					
		}
		
	}
}

$inv = new InventoryClass;
?>