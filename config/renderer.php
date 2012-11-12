<?php

/**-----------------------------------------------------------------------------
 * Template renderer class.
 * This class implement the Singleton pattern. It is used to generate a
 * single Twig instance from which the instance can call to render any view.
 * This class is used in the controller.php superclass of all view, as a composite.
 * -----------------------------------------------------------------------------
 */
class Renderer
{
    // Set Twig loader file system so we can locate the template folders
    private static $twig;
    private static $twigConfig  = array
    (
        'cache' => 'modules/views/cache',   // Twig template cache folder
        'auto_reload' => TRUE               // Autoload reload caches,
                                            // set to false when deploy
    );

    private function __construct() { }

    public static function getInstance()
    {
        if (!isset(self::$twig))
            self::$twig = new Twig_Environment
            (
                new Twig_Loader_Filesystem(VIEW_PATH),
                self::$twigConfig
            );
        return self::$twig;
    }
}
