<?php

$filename = "install.sql";

echo "\n<br>".$filename;

$file = fopen($filename, 'rw');
       $data = array();
       $i = 0;
       while($line = fgets($file))
       {
               if(ereg('^--', $line))
               {
                       if($data[$i] != '')
                       {
                       $i++;
                       $data[$i] = '';
                       }
               }
               else
               {
               $data[$i] .= $line;
               }
       }

echo "\Geting database info...<br> ";
$host = $_POST['dbhost'];
$user = $_POST['dbuser'];
$pass = $_POST['dbpass'];
$db = $_POST['dbname'];
$adminp = $_POST[adminp'];

echo "Executing:\n<br>";
echo "*********************\n<br>";
print_r($data);
echo "<br>*********************\n<br>";

$conn = mysql_connect($host, $user, $pass);
mysql_select_db($db, $conn);

       $i = 0;
       while(isset($data[$i]))
       {
       $data[$i] = explode(';', $data[$i]);

               $j = 0;
               while(isset($data[$i][$j]))
               {
                       if(trim($data[$i][$j]) != '')
                       {
                       echo "<br>++ Running *************\n".$data[$i][$j]."\n++ *******************\n<br>";
                       mysql_query($data[$i][$j].';');
                       echo "\n\n".mysql_error()."\n\n\n<br>";
                       }
                       else
                       {
                       echo "++ Skipping empty query\n<br><br>";
                       }
               $j++;
               }
       $i++;
       }

echo chr(13);

$fr = fopen('../config.php','w');
if(!$fr) {
        echo "<br>Could not re-create the config file!<br>";
        exit;
}
fputs("\$username='$user'\n\$password='$pass'\n\$password='$pass'\n\$database='$db'\n\$host='$host'");
fclose($fr);
?>
