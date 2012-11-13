<?php

class Session
{
    /**
     * @var The only variable that is tracked by the session object.
     */
    private $session_id;


    private $model;

    public function __construct($username, $password)
    {
        session_start();

        // Create a new session model ready to insert session variable
        $this->model = new Sessions_Model();

        // Set the new session for this member
        $this->model->setSession($username, $password);
    }

    public function isValid()
    {
        $user = $this->model->getUser($this->session_id);

        if (empty($user))
            return FALSE;
        return TRUE;
    }

    public function isLogin()
    {
        return TRUE;
    }

    public function expire($value)
    {
        if (isset($this->session_id))
            $this->model->setExpire($this->session_id, $value);
        else
            throw new Exception("Undefined session id.");
    }

    public function __destruct()
    {
        $this->expire(TRUE);
        session_destroy();
    }
}
