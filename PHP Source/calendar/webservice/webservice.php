<?php
	
	//###########
	//# INCLUDE #
	//###########
	
	include("./library.php"); //Includes the library that will return the data or execute the required commands

	//###########
	//# REQUEST #
	//###########
	
	//Check the method requested and execute
	$method = $_GET["method"];
	if ($method == "getUsers") 			// webservice.php?method=getUsers
		json_getUsers();
	else if ($method == "getAppt")
	{
		json_getAppt($_GET["start"],$_GET["end"], $_GET["did"]);
	}
	else if ($method == "addAppt")		//webservice.php?method=addAppt&comment=comment&start=date&did=doctor
		json_addAppt($_GET["comment"],$_GET["start"],$_GET["did"]);
	else if ($method == "addUser") 		// webservice.php?method=addUser&name=person
		json_addUser($_GET["name"]);
	else if ($method == "deleteUser")	// webservice.php?method=deleteUser&id=1
		json_deleteUser($_GET["id"]);
	
	//######################
	//# WEBSERVICE METHODS #
	//######################
	
	//Gets all the user from the method created in the library
	//Then it returns the data in JSON format in the following structure
	/*
	{
		"success" : true,
		"message" : "Users list fetched successfully",
		"data" : [
			{
				"id" : 1,
				"name" : "User 1"
			},
			...
		]
	}	
	*/
	function json_getUsers()
	{		
		$output = array();
		$output["success"] = true;
		$output["message"] = "Users list fetched successfully";
		$output["data"] = getUsers(); //Gets the array of users from the library method
		echo json_encode($output); //Prints your dictionary in JSON format
		//echo ("this works");
	}
	
	function json_getAppt($start,$end,$did)
	{
		$output = array();
		$output["success"] = true;
		$output["message"] = "Users list fetched successfully";
		$output["data"] = getAppt($start, $end,$did); //Gets the array of users from the library method
		echo json_encode($output); //Prints your dictionary in JSON format
		//echo ("this works");
	}
	
	function json_addAppt($comment,$start,$did)
	{
		$output = array();
		$output["success"] = true;
		$output["message"] = "Users list fetched successfully";
		$output["data"] = addAppt($comment,$start,$did); //Gets the array of users from the library method
		echo json_encode($output); //Prints your dictionary in JSON format
		//echo ("this works");
	}
	
	//Adds a new user using the add function in the library
	//Then it returns the result in JSON format
	/*
	{
		"success" : true,
		"message" : "User added successfully"
	}
	*/
	function json_addUser($name)
	{
		$valid = true;
		$message = "User added successfully";
		
		//Check if the name was inserted in the URL request (webservice.php?method=addUser&name=????)
		if (!isset($name))
		{
			$valid = false;
			$message = "Please make sure to pass the name to the webservice";
		}
		
		//Adds the user using the library method
		if ($valid)
		{
			$valid = addUser($name);
			if (!$valid)
				$message = "Something went wrong with the insertion process";
		}
		
		$output = array();
		$output["success"] = $valid;
		$output["message"] = $message;
		echo json_encode($output); //Prints your dictionary in JSON format
		
		//echo ("Gets here");
	}
	
	//Deletes a user using the delete function in the library
	//Then it returns the result in JSON format
	/*
	{
		"success" : true,
		"message" : "User deleted successfully"
	}
	*/
	function json_deleteUser($id)
	{
		$valid = true;
		$message = "User deleted successfully";
		
		//Check if the id was inserted in the URL request (webservice.php?method=deleteUser&id=????)
		if (!isset($id))
		{
			$valid = false;
			$message = "Please make sure to pass the id to the webservice";
		}
		
		//Deletes the user using the library method
		if ($valid)
		{
			$valid = deleteUser($id);
			if (!$valid)
				$message = "Something went wrong with the deletion process";
		}
		
		$output = array();
		$output["success"] = $valid;
		$output["message"] = $message;
		echo json_encode($output); //Prints your dictionary in JSON format
	}
	
?>