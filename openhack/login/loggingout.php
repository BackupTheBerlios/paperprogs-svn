<?php
setcookie("vault_uname", "", time()-1,'/'); 
setcookie("vault_pass", "", time()-1,'/');
setcookie("vult_session", "", time()-1,'/');
header('Location: loginform.php'); 
?>
