<?php

require_once 'Slim/Slim.php';
\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

$app->get('/', function () {
	echo 'Hello world';
});

$app->run();

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

