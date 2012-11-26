<?php

class Reserve_Controller extends Controller implements IRedirectable
{
    protected $data;
    public function __construct(array $args)
    {
        parent::__construct(FALSE);
        if(isset($_POST["first_name"])){
          $visitorModel = new Visitor_Model();
          $reserveModel = new Reserve_Model();
          $visitor_instance = $visitorModel->create_visitor($_POST["first_name"], $_POST["last_name"], $_POST["phone_number"], $this);
          $reserveModel->create_reserve($visitor_instance["id"], $_POST["offer_id"]);
          $this->back();
        }elseif( $this->data["is_logged_in"] == true ){
          $member_id   = $this->getMemberid();
          $memberModel = new Member_Model();
          $visitor_id = $memberModel->get_visitor_id($member_id);
          $reserveModel = new Reserve_Model();
          $reserveModel->create_reserve($visitor_id, $_POST["offer_id"]);
          $this->back();
        }
    }
}
?>
