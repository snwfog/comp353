<?php

class Address_Model extends Model
{
    protected $db;
    public function __construct() {
        $this->db = Database::getInstance();
    }


    public function get_attribute($attribute){
      $result = $this->get("Select ".$attribute." FROM addresses");
      return  $result;
    }

    public function exist_attribute($attribute, $value){
      $value = "\"".$value."\"";
      $result = $this->get("Select ".$attribute." FROM addresses WHERE ".$attribute."=".$value);

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
      $this->db->setFetchMode(2); //This may cause error if db class is singleton
      $insert = array($address, $city, $province, $country, $postal_code);
      $insert = implode(",", $insert);
      if($this->set("INSERT INTO addresses (address, city, province, country, postal_code) VALUES(".$insert.");")){
        echo "b";
        $new = $this->db->id();
        $new = $this->get("Select * FROM addresses WHERE id=".$new);
        return $new;
      }else{
          if($this->db->error_number() == 1062){//1062 = duplicate
              array_push($registration_controller->data["errors"], "Address Already Exist!");
              $registration_controller->display("registration.twig", $registration_controller->data);
          }
      }

    }
}
?>