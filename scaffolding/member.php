<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h2>Enter Members:</h2>
	<form name="members_form" action="scaffolding/insert_member.php" method="post">
		<ul>
		<li>Name: <input type="text" name="name" />
		<li>Address: <input type="text" name="address" />
		<li>City: <input type="text" name="city" />
		<li>Province: <input type="text" name="province" />
		<li>Postal Code: <input type="text" name="postal_code" />
		<li>Country: <input type="text" name="country" />
		<li>Phone Number: <input type="text" name="phone_number" />
		<li>Email: <input type="text" name="email" />
		<ul>
		<input type="submit" value="Submit" />
	</form>
</body>
</html>