<?php

class Login_Controller extends Controller
{
    public function __construct()
    {
        // Check if username and password are valid _POST variable
        if (isset($_POST['username']) && isset($_POST['password']))
        {
            $username = $_POST['username'];
            $password = hash('sha256', $_POST['password']);

            $session = new Session();

            // Create a new session model ready to insert session variable
//            $session = new Sessions_Model;

            // Set the new session for this member
//            $session->setSession($username, $password);
        }
        else
        {
            // Display the empty login
            $this->display('login.twig');
        }
    }
}
