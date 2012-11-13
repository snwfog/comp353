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

    //private $params = array();
//    public function __construct(array $data){
//        $this->params = $data;
//        $class_methods = get_class_methods($this);
//        if(isset($this->params["controller"])){
//            $method = trim(urldecode($this->params["controller"]), "\"");
//            if (in_array($method, $class_methods)){
//                $this::$method();
//            }else{
//                echo "no such methods";
//            }
//        }
//    }
//
//    public function main_login(){
//      $this->display("main_login.html",$this->params);
//    }
//
//    public function login_user(){
//       $loginModel = new Login_Model;
//       $loginModel->get_user();
//        //notfinished
//    }
//
//    public function register(){
//        if (count($_POST) !== 0){
//          $loginModel = new Login_Model;
//
//        }else{
//          $this->display("registration_form.html",$this->params);
//        }
//    }

}