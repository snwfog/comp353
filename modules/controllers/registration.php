<?php

class Registration_Controller extends Controller implements IRedirectable{
    private $data = array("errors" => array(), "form" => array());

    public function __construct(array $args){
      if(isset($_POST["registration_form"])){
        $this->data["form"] = $_POST;
        $this->check_form($_POST);

      }else{
          $this->display("registration.twig", $this->data);
      }
    }

    public function check_form($form){
      $registrationModel = new Registration_Model();

      if($registrationModel->exist_attribute("username",$_POST["username"])){
        array_push($this->data["errors"], "Username Exist!");
        $this->display("registration.twig", $this->data);
      }else{
      }
    }
}
?>
