<?php

require 'NiceDog.php';

R('')->controller('test')->action('index')->on('GET');

class Test extends C {
	public function index() {
		echo "Hi world";
	}
}

run();

?>

<html>
<head>
<title>COMP353 - Databases</title>
</head>
<body>
<p>Welcome to COMP 353 - Databases website</p>
<p>This website is setup by Charles Yang through shell on September 26, 2012.</p>
<p>You are viewing this page on <? echo date("D M d, Y H:i:s", time()) ?>
</body>
</html>

