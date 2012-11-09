<?php

$request = $_SERVER['QUERY_STRING'];
/* print_r($request); */

$parsed = explode('&', $request);
/* print_r($parsed); */

$page = array_shift($parsed);
/* print_r($page); */

$get_vars = array();
foreach ($parsed as $argument)
{
	list($variable, $value) = split('=', $argument);
	$get_vars[$variable] = $value;
}

print "The page requested is $page";
print "<br />";
$vars = print_r($get_vars, TRUE);
print "The following GET vars were passed to the page:<pre>".$vars."</pre>";
