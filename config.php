<?php

// Define constants
$base_url = "http://".$_SERVER['HTTP_HOST'];
$folder_url = str_replace(basename($_SERVER['SCRIPT_NAME']),"",$_SERVER['SCRIPT_NAME']);

define('SERVER_ROOT', $_SERVER['DOCUMENT_ROOT'] . $folder_url);
define('SITE_ROOT', $base_url . $folder_url);


// Load Twig
require_once('libs/Twig/Autoloader.php');
Twig_Autoloader::register();
//
//// Set Twig loader file system so we can locate the template folders
//$twig = new Twig_Environment(new Twig_Loader_Filesystem('views'));

require_once('renderer.php');

//echo get_class(Renderer::getInstance());