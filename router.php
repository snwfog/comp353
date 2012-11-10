<?php

$request = $_SERVER['QUERY_STRING'];

$parsed = explode('&', $request);

$page = array_shift($parsed);

$get_vars = array();
foreach ($parsed as $argument)
{
	list($variable, $value) = explode('=', $argument);
	$get_vars[$variable] = $value;
}

$target = 'controllers/' . $page . '.php';

if (file_exists($target))
{
	include_once($target);
	$class = ucfirst($page) . '_Controller';

	if (class_exists($class))
		$controller = new $class;
	else
		die("The '$class' controller does not exists!");
}
else
{
	die("Page '$target' controller cannot be located!");
}

function __autoload($class_name)
{
    list($filename, $suffix) = explode('_', $class_name);

    $file = 'models/' . strtolower($filename) . '.php';

    if (file_exists($file))
        include_once($file);
    else
        die("File '$filename' containing class '$class_name' not found.");
}

// Register my own autoloader, otherwise it will conflict with library autoloader
spl_autoload_register('__autoload');

$controller->main($get_vars);