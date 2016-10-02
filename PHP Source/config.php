<?php

// The following code is a modified version of the code presented in the tutorial video:
// https://www.youtube.com/watch?v=X6RNprqUPQc
// The source can subsequently be found on: http://www.johnmorrisonline.com/lesson/how-to-create-an-advanced-login-system/
/* Configuration Info
 * Enter your configuration information below.
 */
 
//Database Information

define('DB_SERVER', 'localhost:3306');

/* DB Name
 * Enter the name of your database below.
 */
define('DB_NAME', 'HealthcareClinic');

/* DB Username
 * Enter the username of the user with access to the database below.
 */
define('DB_USER', 'root');

/* DB Password
 * Enter the above user's password below.
 */
//define('DB_PASS', 'cpsc471group11');
define('DB_PASS', '');

//SALT Information

/* Site Key
 * Enter your site key below.
 */
define('SITE_KEY', 'tIVLEabZMrxm!%4ZHJWnXAjxbPt4mYGtyb!@$%&^%VQJsxGjOIdej#OT3EhCpxqC5Bu6KSOJM$$##VJV9jLF5uWiiFXm1G');

/* NONCE SALT
 * Enter your NONCE SALT below.
 */
define('NONCE_SALT', 'fxmAMC5TiY2_)(eh2DfbOOX4*&F73ldggm8KZP35N48t3OVbTaoOpaOlLydef#_+kvusgNgafnuujTPdazfzqpDy');

/* AUTH SALT
 * Enter your AUTH SALT below.
 */
define('AUTH_SALT', 'g)(*)Um9SXCqWWvSDm6&^&k3iwMqPghWzTgqMSiy)(&*&RaAoMdbyLNuRdvH(gwL0fA7Umlmy4ZvH04r2xjp7KH2ahNNc');
?>