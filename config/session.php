<?php

class Session
{
    private $session_model;

    public function __construct($username, $password)
    {
        // Create a new session model ready to insert session variable
        $this->session_model = new Sessions_Model();

        // Set the new session for this member
        $this->session_model->setSession($username, $password);
    }

    public function isValid()
    {
        return TRUE;
    }

    public function isLogin()
    {
        return TRUE;
    }

    public function startSession()
    {
        session_start();
    }

    public function endSession()
    {
        session_destroy();
    }
}
