<?php
session_start();
if(!isset($_SESSION["myusername"])){
	header("location:main_login.html");
}else{
	header("location:/~etc353_2");
}
?>