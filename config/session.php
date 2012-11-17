<?php

class Session
{
    /**
     * @var int The only variable that is tracked by the session object.
     */
    private $session_id;
    private $member_id;
    private $valid_session = FALSE;

    public function __construct($username, $password)
    {
        // Create a new session model ready to insert session variable
        $this->session_model = new Session_Model();
        // Create a member model to access member information
        $this->member_model = new Member_Model();

        $this->username = $username;
        $this->password = $password;
//        $this->password = hash('sha256', $password);
    }

    public function validateSession()
    {
        // First get the member id see if its a proper member
        $member_id = $this->member_model->getUserId(
            $this->username, $this->password);

        $this->member_id = Helper::getIndex($member_id, "id");

        if (!isset($this->member_id))
            $this->valid_session = FALSE;
        else
        {   
            $this->valid_session = TRUE;

            // Set all session for this member to expire
            $this->session_model->setAllExpire($this->member_id);

            // Create a new session and get an unique session id
            $this->session_id = $this->session_model->generateNewSession(
                $this->member_id);
        }
    }

    public function isValid()
    {
        return $this->valid_session;
    }

    public function isLogin()
    {
        return $this->valid_session;
    }

    public function who()
    {
        return $this->member_id;
    }

    public function which()
    {
        return $this->session_id;
    }

    public function startSession()
    {
        if (!session_id())
            session_start();

        // Assign session variables
        $_SESSION['owner_id'] = $this->member_id;
        $_SESSION['session_id'] = $this->session_id;
    }

    public function endSession()
    {
        if (isset($this->session_id))
            $this->session_model->setAllExpire($this->member_id);

        if ($this->valid_session)
            $this->valid_session = FALSE;

        $this->session_id = NULL;
        $this->member_id = NULL;
        
        session_destroy();
    }
}
