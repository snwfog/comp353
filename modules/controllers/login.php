<?php

class Login_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        // Check if username and password are valid _POST variable
        if (isset($_POST['username']) && isset($_POST['password']))
        {
            $username = $_POST['username'];
            //$password = hash('sha256', $_POST['password']);
            $password = $_POST['password'];

            $this->session = new Session($username, $password);

            parent::__construct();
        }
        else
        {
            // Display the empty login
            $this->display('login.twig');
        }
    }
}