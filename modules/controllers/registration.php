<?php

class Registration_Controller extends Controller implements IRedirectable
{
    public $data = array("errors" => array(), "form" => array());
    private $password1;
    private $password2;
    
    public function __construct(array $args)
    {
        if (isset($_POST["registration_form"]))
        {
            $this->password1              = $_POST["password1"];
            $this->password2              = $_POST["password2"];
            $_POST["password1"]           = "";
            $_POST["password2"]           = "";
            $_POST["credit_number"]       = "";
            $_POST["credit_expire"]       = "";
            $_POST["credit_verification"] = "";
            $this->data["form"]           = $_POST;
            $this->check_form($_POST);
            
        }
        else
        {
            $this->display("registration.twig", $this->data);
        }
    }
    
    public function check_form($form)
    {
        $memberModel = new Member_Model();
        $emailModel = new Email_Model();
        if ($this->password1 == "" && $this->password2 == "")
        {
            array_push($this->data["errors"], "Passwords is empty!");
        }
        elseif ($this->password1 !== $this->password2)
        {
            array_push($this->data["errors"], "Confirm password is different!");
        }
        if ($memberModel->exist_attribute("username", $_POST["username"]))
        {
            array_push($this->data["errors"], "Username Exist!");
        }
        if ($emailModel->emailExist($_POST["email"]))
        {
            array_push($this->data["errors"], "Email Exist!");
        }
        if (count($this->data["errors"]) > 0)
        {
            $this->display("registration.twig", $this->data);
        }
        else
        {
            $this->register_member();
            session_start();
            $session = new Session($this->data["form"]["username"], hash(ENCRYPTION_TYPE, $this->password1));
            $this->verifySession($session);
            $this->redirect("index.php?member");
        }
    }
    
    private function register_member()
    {
        $memberModel     = new Member_Model();
        $addressModel    = new Address_Model();
        $visitorModel    = new Visitor_Model();
        //$creditcardModel = new CreditCard_Model();
        $email_instance  = new Email_Model();


        if($visitor_instance = $visitorModel->create_visitor($_POST["first_name"], $_POST["last_name"], $_POST["phone_number"], $this)){
            $email_instance = $email_instance->setEmailAndGetId($_POST["email"]);
            $address_instance = $addressModel->create_address($_POST["address"], $_POST["city"], $_POST["province"], $_POST["country"], $_POST["postal_code"], $this);
            $member_instance = $memberModel->create_member($_POST["username"], $this->password1, $email_instance, $address_instance["id"], $visitor_instance["id"], $this);
            return $member_instance;
        }else{
            array_push($this->data["errors"], "Email Taken!");
            $this->date["form"]["email"] = NULL;
            $this->display("registration.twig", $this->data);
        }
    }
}
?>
