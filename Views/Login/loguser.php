<?php
session_start();
echo "YEA BITCHES you LOGIN";
if(!session_is_registered(parse_str($_GET["myusername"]))){
header("location:main_login.php");
}
?>