<?php

class Member_Controller extends Controller implements IRedirectable
{
    public function __construct()
    {
        // Check for login and session
        // parent::__construct();

        $email = new Email_Model;

        $email->setDomain('icloud');

    }

}
