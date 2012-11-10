<?php

/**
 * TODO: Better naming convention.
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

$target = 'modules/controllers/' . $page . '.php';


if (file_exists($target))
{
	include_once($target);
	$class = ucfirst($page) . '_Controller';

	if (class_exists($class))
		$controller = new $class($get_vars);
	else
		die("The '$class' controller does not exists!");
}
else
{
	die("Page '$target' controller cannot be located!");
}

