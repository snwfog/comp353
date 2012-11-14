<?php

class Address_Model extends Model
{
    public function __construct() {
        parent::__construct();
    }


    public function get_attribute($attribute){
      $result = $this->db->query("Select ".$attribute." FROM addresses");
      $result = $this->db->selectField("",MYSQL_ASSOC);
      return  $result;
    }

    public function exist_attribute($attribute, $value){
      $value = "\"".$value."\"";
      $result = $this->db->query("Select ".$attribute." FROM addresses WHERE ".$attribute."=".$value);
      $result = $this->db->selectField("",MYSQL_ASSOC);
      if(count($result) > 0){
        return TRUE;
      }else{
        return FALSE;
      }
    }

    public function create_address($address, $city, $province, $country, $postal_code, $registration_controller){
      $address = "\"".$address."\"";
      $city = "\"".$city."\"";
      $province = "\"".$province."\"";
      $country = "\"".$country."\"";
      $postal_code = "\"".$postal_code."\"";
      $insert = array($address, $city, $province, $country, $postal_code);
      $insert = implode(",", $insert);
      if($this->db->query("INSERT INTO addresses (address, city, province, country, postal_code) VALUES(".$insert.");")){
        $new = $this->db->getLastInsertId();
        $new = $this->db->query("Select * FROM addresses WHERE id=".$new);
        $new = $this->db->selectField("",MYSQL_ASSOC);
        return $new;
      }else{
          if($this->db->getErrorId() == 1062)
          {//1062 = duplicate
              array_push($registration_controller->data["errors"], "Address Already Exist!");
          }
          $registration_controller->display("registration.twig", $registration_controller->data);
      }

    }
}
?>