<?php

abstract class Controller
{

    const REDIRECT_ERROR = "modules/views/static/error.html";
    const REDIRECT_INDEX = "index.php";

    /**
     * The data array, you can use it, or you don't have to use it.
     */
    protected $data = array();

    public function __construct()
    {
        $this->startSession();
        
        if (!$this->isValidSession())
            $this->redirect(self::REDIRECT_INDEX);
    }

    public function verifySession(Session $session)
    {
        // Check if we invoke making a session
        if (isset($session))
        {
            $session->validateSession();
            if ($session->isValid())
                $session->startSession();
        }
    }

    public function display($file, $data = array())
    {
        Renderer::getInstance()->display($file, $data);
    }

    public function isValidSession()
    {
        return (isset($_SESSION['session_id'])) ? TRUE : FALSE;
    }

    public function getSessionId()
    {
        return (isset($_SESSION['session_id'])) ? $_SESSION['session_id'] :
            NULL;
    }

    public function getMemberId()
    {
        return (isset($_SESSION['owner_id'])) ? $_SESSION['owner_id'] : NULL;
    }

    public function endSession()
    {
        if (session_id())
            session_destroy();
    }

    public function startSession()
    {
        if (!session_id())
        {
            session_start();
        }
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

    public function back()
    {
        if (isset($_SERVER["HTTP_REFERER"]))
        {
            $url_segments = explode("/", $_SERVER["HTTP_REFERER"]);
            $redirect_uri = array_pop($url_segments);
            header("Location: $redirect_uri");
        }

    }
}
