<?php

/**--------------------------------------------------------------------------------------------------------------
 * COMP353 - Databases
 * Filename:        config.php
 * Description:     All global configurations of the project shall appears in this file.
 * Date:            November 10, 2012
 * Author:          Charles Yang
 * --------------------------------------------------------------------------------------------------------------
 */

/**--------------------------------------------------------------------------------------------------------------
 * Connection to database using the mysqli.class
 * --------------------------------------------------------------------------------------------------------------
 */
$dbconfig = array();
$dbconfig['host'] = 'localhost';
$dbconfig['user'] = 'root';
$dbconfig['pass'] = '';
$dbconfig['table'] = 'table';

/*--------------------------------------------------------------------------------------------------------------
/* Define local or server side URL and path constants
/*--------------------------------------------------------------------------------------------------------------
*/
$baseURL = "http://".$_SERVER['HTTP_HOST'];
$folderURL = str_replace(basename($_SERVER['SCRIPT_NAME']),"",$_SERVER['SCRIPT_NAME']);

define('SERVER_ROOT', $_SERVER['DOCUMENT_ROOT'] . $folderURL);
define('SITE_ROOT', $baseURL . $folderURL);

/*--------------------------------------------------------------------------------------------------------------
/* Load Twig, the PHP templating framework
/*--------------------------------------------------------------------------------------------------------------
*/
require_once('libs/Twig/Autoloader.php');
Twig_Autoloader::register();

/*--------------------------------------------------------------------------------------------------------------
/* Load the default twig renderer singleton class
/* Essentially one Twig class shall be used throughout the website
/*
/*--------------------------------------------------------------------------------------------------------------
*/
require_once('renderer.php');

/*--------------------------------------------------------------------------------------------------------------
/* Load the default superclass for view from which all controller must implement if they which to be
/* to be displayed in the web browser
/*--------------------------------------------------------------------------------------------------------------
*/
require_once('view.php');

/**--------------------------------------------------------------------------------------------------------------
 * Bootstrap model classes loading
 * --------------------------------------------------------------------------------------------------------------
 */
function __autoload($class_name)
{
    list($filename, $suffix) = explode('_', $class_name);

    $file = 'modules/models/' . strtolower($filename) . '.php';

    if (file_exists($file))
        include_once($file);
    else
        die("File '$filename' containing class '$class_name' not found.");
}

spl_autoload_register('__autoload');

/**
 * --------------------------------------------------------------------------------------------------------------
 * END OF CONFIGURATION
 */