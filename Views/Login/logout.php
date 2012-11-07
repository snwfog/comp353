<?php 
session_start();
if(isset($_SESSION['myusername'])){
	unset($_SESSION['myusername']);
}
header("Location:/com353");
?>