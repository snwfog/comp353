<?php

class Login_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        $this->startSession();

        // Check if username and password are valid _POST variable
        if (isset($_POST['username']) && isset($_POST['password']))
        {
            $username = $_POST['username'];
            //$password = hash('sha256', $_POST['password']);
            $password = $_POST['password'];
     
            $session = new Session($username, $password);

            parent::__construct($session);

            $this->redirect("index.php");
        }
        else if ($this->isValidSession() && isset($args["logout"])
            && $args["logout"] == '1')
        {
            $this->endSession();
            $this->redirect(self::REDIRECT_INDEX);
        }
        else if ($this->isValidSession())
        {
            $this->redirect(self::REDIRECT_INDEX); // Redirect to index
        }
        else
        {
            // Display the empty login
            $this->display('login.twig');
        }
    }
}