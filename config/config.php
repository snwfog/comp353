<?

$host = "clipper.encs.concordia.ca";
$username = "etc353_2";
$password = "QqT9tR";
$database = "etc353_2";

function showerror() {
	die("Error ".mysql_errno().": ".mysql_error());
}

if (!($connection = @mysql_connect($host, $username, $password))) {
	showerror();
}

if (!mysql_select_db($database, $connection)) {
	showerror();
}

?>