<?php

class Session
{
    private $session_model;
    private $username;
    private $password;

    public function __construct($username, $password)
    {
        $this->username = $username;
        $this->password = $password;

        // Create a new session model ready to insert session variable
        $this->session_model = new Sessions_Model();

        // Set the new session for this member
        $this->session_model->setSession($username, $password);
    }

    public function isValid()
    {
        $user = $this->session_model->getUser($this->username);
        print_r($user);
        if (empty($user))
            return FALSE;
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
