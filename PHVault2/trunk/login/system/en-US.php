<?php
$logout='<a href="loggingout.php" alt="logout">Logout</a>';
$loggedinn=strip_tags($_COOKIE["vault_uname"]);$loggedin="Hello <b>$loggedinn</b> you are allready logged in <br>$logout";
$die="Server error/nPlease try again in a few minuts";
$usertext="Username: ";
$passtext="Password: ";
$incorrect="Incorrent username or password...";
$nologin="You are not logged in"
?>