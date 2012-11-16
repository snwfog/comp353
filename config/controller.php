<?php

abstract class Controller
{

    const REDIRECT_ERROR = "modules/views/static/error.html";
    const REDIRECT_INDEX = "index.php";

    protected static $session;

    public function __construct()
    {
        // Check if we invoke making a session
        if (isset(self::$session))
        {
            self::$session->validateSession();
            if (!self::$session->isValid())
                header("Location: " . self::REDIRECT_INDEX);
        }
        else
        {
            header("Location: " . self::REDIRECT_INDEX);
        }
    }

    public function display($file, $data = array())
    {
        Renderer::getInstance()->display($file, $data);
    }

    /**-------------------------------------------------------------------------
     * Redirect a controller to another controller.
     * Such as in the case where the user is not logged in, hence
     * everything must be redirected to login page.
     *
     * IMPORTANT: This method must be called before anything is displayed
     *            on the page, e.g. It MUST be called before the display
     *            function.
     * -------------------------------------------------------------------------
     */
    public function redirect($file = self::REDIRECT_INDEX)
    {
        header("Location: $file");
    }
}
