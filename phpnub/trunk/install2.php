<?php

$filename = "install.sql";

echo "\n".$filename;

$file = fopen($filename, 'r');
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

echo "\Geting database info... ";
$host = $_POST['dbhost'];
$user = $_POST['dbuser'];
$pass = $_POST['dbpass'];
$db = $_POST['dbname'];

echo "Executing:\n";
echo "*********************\n";
print_r($data);
echo "*********************\n";

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
                       echo "++ Running *************\n".$data[$i][$j]."\n++ *******************\n";
                       mysql_query($data[$i][$j].';');
                       echo "\n\n".mysql_error()."\n\n\n";
                       }
                       else
                       {
                       echo "++ Skipping empty query\n";
                       }
               $j++;
               }
       $i++;
       }

echo chr(13);

$fr = fopen('../config.php','w');
if(!$fr) {
        echo "Could not re-create the config file!";
        exit;
}
fputs("\$username='$user'\n\$password='$pass'\n\$password='$pass'\n\$database='$db'\n\$host='$host'");
fclose($fr);
?>
