<?php

include '../db_connection.php';

$query = 'INSERT INTO members ( name, address, city, province, postal_code, country, phone_number, email) values ("'.$_POST['name'].'", "'.$_POST['address'].'", "'.$_POST['city'].'", "'.$_POST['province'].'", "'.$_POST['postal_code'].'", "'.$_POST['country'].'", "'.$_POST['phone_number'].'", "'.$_POST['email'].'");';

print($query);
		    
mysql_query($query);

mysql_close();

?>