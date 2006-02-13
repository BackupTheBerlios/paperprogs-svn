<?
$user="paperprogs";
$password="smarty11";
$database="paperprogs";
$host="db.berlios.de"
mysql_connect($host,$user,$password);
@mysql_select_db($database) or die( "Unable to select database");
$query="CREATE TABLE attempt (id int(6) NOT NULL auto_increment,name varchar(30) NOT NULL,url varchar(255) NOT NULL,fake varchar(255) NOT NULL,PRIMARY KEY (id),UNIQUE id (id),KEY id_2 (id))";
mysql_query($query);
mysql_close();
?>
