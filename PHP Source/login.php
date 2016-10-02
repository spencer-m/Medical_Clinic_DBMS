<?php
	// The following code is a modified version of the code presented in the tutorial video:
 // https://www.youtube.com/watch?v=X6RNprqUPQc
 // The source can subsequently be found on: http://www.johnmorrisonline.com/lesson/how-to-create-an-advanced-login-system/
	require_once('loadFiles.php');
	$act = isset($_GET['action']) ? $_GET['action'] : 'logout';//$_GET['action'] == 'logout';
	if ( $act  ) {
		$loggedout = $c->logout();
	}
	
	$logged = $c->loginUser('index.php');
?>
<html>
	<head>
		<title>Login Form</title>
		<style type="text/css">
			body { background: #c7c7c7;}
		</style>
	</head>

	<body>
		<div style="width: 960px; background: #fff; border: 1px solid #e4e4e4; padding: 20px; margin: 10px auto;">
			<?php if ( $logged == 'invalid' ) : ?>
				<p style="background: #e49a9a; border: 1px solid #c05555; padding: 7px 10px;">
					The username password combination you entered is incorrect. Please try again.
				</p>
			<?php endif; ?>
			<?php
			$act; 
			if (isset($_GET['reg'])):
				$act = $_GET['reg'];
			else:
				$act = false;
			endif;
			if ( $act ) : ?>
				<p style="background: #fef1b5; border: 1px solid #eedc82; padding: 7px 10px;">
					Your registration was successful, please login below.
				</p>
			<?php endif; ?>
			<?php 
			$act;
			if (isset($_GET['action'])):
				$act = $_GET['action'];
			else:
				$act = "null";
			endif;
			
			if ($act == "logout" ) : ?>
				<?php if ( $loggedout == true ) : ?>
					<p style="background: #fef1b5; border: 1px solid #eedc82; padding: 7px 10px;">
						You have been successfully logged out.
					</p>
				<?php else: ?>
					<p style="background: #e49a9a; border: 1px solid #c05555; padding: 7px 10px;">
						There was a problem logging you out.
					</p>
				<?php endif; ?>
			<?php endif; ?>
			<?php 
			$act;
			if (isset($_GET['msg'])):
				$act = $_GET['msg'];
			else:
				$act = "null";
			endif;
			if ( $act == 'login' ) : ?>
				<p style="background: #e49a9a; border: 1px solid #c05555; padding: 7px 10px;">
						You must log in to view this content. Please log in below.
					</p>
			<?php endif; ?>
		
			<h3>Clinic Login</h3>
			
			<form action="<?php echo $_SERVER['PHP_SELF']; ?>" method="post">
				<table>
					<tr>
						<td>Username:</td>
						<td><input type="text" name="Username" /></td>
					</tr>
					<tr>
						<td>Password:</td>
						<td><input type="password" name="Password" /></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value="Login" /></td>
					</tr>
				</table>
			</form>
			<p>Not a registered patient? Please register <a href="registerPatient.php"> here</a></p>
		</div>
	</body>
</html>

