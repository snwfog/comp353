<?php

/**
 * Router.php
 * Dynamically calls the controller and pass relevant variables.
 *
 */

$request = $_SERVER['QUERY_STRING'];

$request_uri = explode('&', $request);

$requested_page = array_shift($request_uri);

// Otherwise keep checking for other specific controller
$url_associative_array = array();

// Check if we are looking just for the index page
if (empty($requested_page) && empty($request_uri))
    $controller = new Index_Controller($url_associative_array);
else
{
    foreach ($request_uri as $argument)
    {
        list($variable, $value) = explode('=', $argument);
        $url_associative_array[$variable] = urldecode($value);
    }

    $controller_class = ucfirst($requested_page) . '_' . CONTROLLER_SUFFIX;

    if (class_exists($controller_class))
        $controller = new $controller_class($url_associative_array);
    else
//    header('Location: http://www.google.ca/');
        die("The '$controller_class' controller does not exists!");
}

