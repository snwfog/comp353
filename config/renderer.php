<?php

/**-----------------------------------------------------------------------------
 * Template renderer class.
 * This class implement the Singleton pattern. It is used to generate a
 * single Twig instance from which the instance can call to render any view.
 * This class is used in the view.php superclass of all view, as a composite.
 * -----------------------------------------------------------------------------
 */
class Renderer
{
    // Set Twig loader file system so we can locate the template folders
    private static $twig;
    private function __construct() { }

    public static function getInstance()
    {
        if (!isset(self::$twig))
            self::$twig = new Twig_Environment(new Twig_Loader_Filesystem(VIEW_PATH));
        return self::$twig;
    }
}
