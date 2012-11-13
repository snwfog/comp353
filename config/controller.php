<?php

abstract class Controller
{

    /*
     * TODO: controller should be able to check for login and redirect when
     */
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
    public function redirect($file = 'index.php')
    {
        header("Location: $file");
    }
}
