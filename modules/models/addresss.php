<?php

class Address_Model
{
    private $db;
    public function __construct() {
        $this->db = Database::getInstance();
    }


    public function get_attribute($attribute){
      $this->db->query("Select ".$attribute." FROM addresses");
      $result = $this->db->get();
      return  $result;
    }

    public function exist_attribute($attribute, $value){
      $value = "\"".$value."\"";
      $this->db->query("Select ".$attribute." FROM addresses WHERE ".$attribute."=".$value);

      if(count($this->db->get()) > 0){
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
      $this->db->query("Select *
                        FROM addresses 
                        WHERE address=".$address."and city=".$city."and postal_code=".$postal_code
                       );
      $result = $this->db->get();
      if(count($result) == 1){//no two member can have same address!
        array_push($registration_controller->data["errors"], "Address Already Exist!");
        $registration_controller->display("registration.twig", $registration_controller->data);
      }elseif(count($result) == 0){//no duplicate
        $insert = array($address, $city, $province, $country, $postal_code);
        $insert = implode(",", $insert);
        $new = $this->db->query("INSERT INTO addresses (address, city, province, country, postal_code)
                                 VALUES(".$insert.");"
                                );
        $new = $this->db->id();
        $new = $this->db->query("Select *
                                FROM addresses
                                WHERE id=".$new
                               );
        $new = $this->db->get();
        return $new;
      }

    }
}
?>