<?php

// Setting up the boatstrap
require_once __DIR__.'/vendor/autoload.php';

$app = new Silex\Application();

$app->get('/hello/{name}', function ($name) use ($app) {
    echo '<h1>Hello '.$app->escape($name).'</h1>';
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

