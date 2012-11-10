<?php include_once 'db_connection.php' ?>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h2>Enter Listing:</h2>
	<form name="listing_form" action="scaffolding/insert_listing.php" method="post">
		<ul>
		<li>
		<?php
			$result = mysql_query("SELECT * FROM members");
			mysql_close();

			for ($i = 0; $i < $)
		?>
		<ul>
		<input type="submit" value="Submit" />
	</form>
</body>
</html>