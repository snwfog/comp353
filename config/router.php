<?php

/**
 * Router.php
 * Dynamically calls the controller and pass relevant variables.
 *
 */

/**
 * TODO: Better naming convention???
 * TODO: Encapsulate the class???
 */

$request = $_SERVER['QUERY_STRING'];

$parsed = explode('&', $request);

$page = array_shift($parsed);

$get_vars = array();
foreach ($parsed as $argument)
{
	list($variable, $value) = explode('=', $argument);
	$get_vars[$variable] = $value;
}

$class = ucfirst($page) . '_' . CONTROLLER_SUFFIX;

if (class_exists($class))
    $controller = new $class($get_vars);
else
//    header('Location: http://www.google.ca/');
    die("The '$class' controller does not exists!");
