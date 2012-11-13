<?php
class Registration_Controller extends Controller implements IRedirectable{
    public function __construct(array $args){
      if(isset($_POST["registration_form"])){
        
      }else{
          $this->display("registration.twig");
      }
    }
}
?>