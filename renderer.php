<?php

class Renderer
{
    // Set Twig loader file system so we can locate the template folders
    private static $twig;
    private function __construct() {}

    public static function getInstance()
    {
        if (!isset(self::$twig))
            self::$twig = new Twig_Environment(new Twig_Loader_Filesystem('views'));

        return self::$twig;
    }
}
