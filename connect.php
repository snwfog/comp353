<?php

$connect = mysql_connect("clipper.encs.concordia.ca","etc353_2","QqT9tR");
if (!$con){
	die('Could not connect: ' . mysql_error()); 
}
	
mysql_select_db("etc353_2", $connect);


?>