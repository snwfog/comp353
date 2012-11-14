<?php

class Visitor_Model extends Model
{
    protected $db;
    public function __construct() {
        parent::__construct();
    }

    public function get_attribute($attribute){
      $result = $this->db->query("Select ".$attribute." FROM visitors");
      $result = $this->db->selectField("",MYSQL_ASSOC);
      return  $result;
    }

    public function exist_attribute($attribute, $value){
      $value = "\"".$value."\"";
      $result = $this->db->query("Select ".$attribute." FROM visitors WHERE ".$attribute."=".$value);
      $result = $this->db->selectField("",MYSQL_ASSOC);
      if(count($result) > 0){
        return TRUE;
      }else{
        return FALSE;
      }
    }

    public function create_visitor($f_name, $l_name, $phone_number, $registration_controller)
    {
      $f_name = "\"".$f_name."\"";
      $l_name = "\"".$l_name."\"";
      $phone_number = "\"".$phone_number."\"";
      $join_date = "CURDATE()";
      $insert = array($f_name, $l_name, $phone_number, $join_date);
      $insert = implode(",", $insert);
      $this->db->query("Select * FROM visitors WHERE phone_number=".$phone_number);
      $result = $this->db->selectField("", MYSQL_ASSOC);
      if (count($result) == 1)
      {
          return $result[0];
      }else
      {
          $this->db->query("INSERT INTO visitors (first_name, last_name, phone_number, join_date) VALUES (".$insert.");");
          $result = $this->db->selectField("", MYSQL_ASSOC);
          print_r($result[0]);
      }


    }
}
?>