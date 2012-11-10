<?php
	function is_login(){
		session_start();
		if(isset($_SESSION['myusername'])){
			return TRUE;
		}
	}
?>