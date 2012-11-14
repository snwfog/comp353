<?php

/**-----------------------------------------------------------------------------
 * COMP353 - Databases
 * Filename:        config.php
 * Description:     All global configurations of the project shall appears
 *                  in this file.
 * Date:            November 10, 2012
 * Author:          Charles Yang
 * -----------------------------------------------------------------------------
 */

/*------------------------------------------------------------------------------
/* Define local or server side URL and path constants
/*------------------------------------------------------------------------------
*/
$baseURL = "http://".$_SERVER['HTTP_HOST'];
$folderURL = str_replace(basename($_SERVER['SCRIPT_NAME']),"",$_SERVER['SCRIPT_NAME']);

define('SERVER_ROOT', $_SERVER['DOCUMENT_ROOT'] . $folderURL);
define('SITE_ROOT', $baseURL . $folderURL);

/**-----------------------------------------------------------------------------
 * Define project pathing constants.
 * Apparently PHP's include or require uses absolute pathing from the root
 * folder of the project. The difference between require and include is that
 * require is obligatory, the system will fail if a require file is not found.
 * While include will try to move on if the file is not found.
 * -----------------------------------------------------------------------------
 */
define('VIEW_PATH', 'modules/views');
define('MODEL_PATH', 'modules/models');
define('CONTROLLER_PATH', 'modules/controllers');

/**-----------------------------------------------------------------------------
 * Define system class naming suffix.
 * They are only used as class name, and NOT the filename.
 * -----------------------------------------------------------------------------
 */
define('CONTROLLER_SUFFIX', 'Controller');
define('MODEL_SUFFIX', 'Model');
define('VIEW_SUFFIX', 'View');

/*------------------------------------------------------------------------------
/* Load Twig, the PHP templating framework
/*------------------------------------------------------------------------------
*/
require_once('libs/Twig/Autoloader.php');
Twig_Autoloader::register();

/*------------------------------------------------------------------------------
/* Load the default twig renderer singleton class
/* Essentially one Twig class shall be used throughout the website
/*
/*------------------------------------------------------------------------------
*/
require_once('renderer.php');


/**-----------------------------------------------------------------------------
 * Import the files and load the database connector file as a singleton pattern.
 * The database connector should be called through the getInstance method.
 * -----------------------------------------------------------------------------
 */
require_once('libs/mysqli.class.php');
require_once('database.php');
require_once('model.php');

/*------------------------------------------------------------------------------
/* Load super class for controllers from which every controller must extends
/* if they which to be to be displayed in the web browser.
/*------------------------------------------------------------------------------
*/
require_once('controller.php');
require_once('redirectable.php');

/**-----------------------------------------------------------------------------
 * Load the session class, which act as LOGIN and SESSION checker.
 * -----------------------------------------------------------------------------
 */
require_once('session.php');

/**-----------------------------------------------------------------------------
 * Bootstrap classes loading for MODELS and CONTROLLERS only.
 * -----------------------------------------------------------------------------
 */
function __autoload($className)
{
    list($filename, $suffix) = explode('_', $className);

    $filename = strtolower($filename);

    if (preg_match('/' . CONTROLLER_SUFFIX . '/i', $suffix))
        $file = CONTROLLER_PATH . '/' . $filename . '.php';
    else if (preg_match('/' . MODEL_SUFFIX . '/i', $suffix))
        $file = MODEL_PATH . '/' . $filename . 's' . '.php'; // Note the "s"

    if (file_exists($file))
        include_once($file);
    else
        header('Location: ' . Controller::REDIRECT_ERROR);
//        die("File '$file' containing class '$className' could not be located by the autoload function!");
}

spl_autoload_register('__autoload');

/**
 * -----------------------------------------------------------------------------
 * END OF CONFIGURATION
 */