<?php
class Login_Controller extends Controller{
    private $params = array();
    public function __construct(array $data){
        $this->params = $data;
        $class_methods = get_class_methods($this);
        if(isset($this->params["controller"])){
            $method = trim(urldecode($this->params["controller"]), "\"");
            if (in_array($method, $class_methods)){
                $this::$method();
            }else{
                echo "no such methods";
            }
        }
    }

    public function main_login(){
      $this->display("main_login.html",$this->params);
    }

    public function login_user(){
       $loginModel = new Login_Model;
       $loginModel->get_user();
    }

    public function register(){
        if (count($_POST) !== 0){
          $loginModel = new Login_Model;
        }else{
          $this->display("registration_form.html",$this->params);
        }
    }

}
?>