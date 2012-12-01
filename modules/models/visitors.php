<?php

class Visitor_Model extends Model
{
    protected $db;
    public function __construct()
    {
        parent::__construct();
    }
    
    public function get_attribute($attribute)
    {
        $result = $this->db->query("Select " . $attribute . " FROM visitors");
        $result = $this->db->fetch(MYSQL_ASSOC);
        return $result;
    }
    
    public function exist_attribute($attribute, $value)
    {
        $value  = "\"" . $value . "\"";
        $result = $this->db->query("Select " . $attribute . " FROM visitors WHERE " . $attribute . "=" . $value);
        $result = $this->db->fetch(MYSQL_ASSOC);
        if (count($result) > 0)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    
    public function create_visitor($f_name, $l_name, $phone_number, $registration_controller, $is_registration = TRUE)
    {
        $f_name       = "\"" . $f_name . "\"";
        $l_name       = "\"" . $l_name . "\"";
        $phone_number = "\"" . $phone_number . "\"";
        $join_date    = "CURDATE()";
        $insert       = array(
            $f_name,
            $l_name,
            $phone_number,
            $join_date
        );
        $insert       = implode(",", $insert);
        
        if($is_registration){
            $this->db->query("SELECT *
                            FROM  `visitors`
                            JOIN members ON members.visitor_id = visitors.id
                            WHERE first_name=$f_name AND last_name=$l_name AND phone_number=$phone_number");
            $result = $this->db->fetch(MYSQL_ASSOC);
            if (count($result) == 1)
            {
                array_push($registration_controller->data["errors"], "First name, last name, phone number in use!");
                $registration_controller->display("registration.twig", $registration_controller->data);
                exit;
            }
        }
        
        $this->db->query("SELECT *
                        FROM  `visitors`
                        WHERE NOT EXISTS (
                                          SELECT *
                                          FROM  `members`
                                          WHERE members.visitor_id = visitors.id
                                          )
                        AND first_name=$f_name AND last_name=$l_name AND phone_number=$phone_number");
        $result = $this->db->fetch(MYSQL_ASSOC);
        if (count($result) == 1)
        {
            return $result[0];
        }
        else
        {
            $this->db->query("INSERT INTO visitors (first_name, last_name, phone_number, join_date) VALUES (" . $insert . ");");
            $new = $this->db->getLastInsertId();
            $this->db->query("Select * FROM visitors WHERE id=" . $new);
            $new = $this->db->fetch(MYSQL_ASSOC);
            return $new[0];
        }
        
        
    }
}
?>