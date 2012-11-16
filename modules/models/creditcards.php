<?php

class CreditCard_Model extends Model
{
    protected $db;
    public function __construct()
    {
        $this->db = Database::getInstance();
    }
    
    
    public function get_attribute($attribute)
    {
        $result = $this->db->query("Select " . $attribute . " FROM credit_cards");
        $result = $this->db->fetch(MYSQL_ASSOC);
        return $result;
    }
    
    public function exist_attribute($attribute, $value)
    {
        $value  = "\"" . $value . "\"";
        $result = $this->db->query("Select " . $attribute . " FROM credit_cards WHERE " . $attribute . "=" . $value);
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
    
    public function create_credit_card($member_id, $credit_card_type_id, $number, $expire, $verification)
    {
        $member_id           = "\"" . $member_id . "\"";
        $credit_card_type_id = "\"" . $credit_card_type_id . "\"";
        $number              = "\"" . $number . "\"";
        $expire              = "\"" . $expire . "\"";
        $verification        = "\"" . $verification . "\"";
        $insert              = array(
            $member_id,
            $credit_card_type_id,
            $number,
            $expire,
            $verification
        );
        $insert              = implode(",", $insert);
        if ($this->db->query("INSERT INTO addresses (member_id, credit_card_type, number, expire, verification_code) 
                           VALUES(" . $insert . ");"))
        {
            $new = $this->db->getLastInsertId();
            $new = $this->db->query("Select * FROM addresses WHERE id=" . $new);
            $new = $this->db->fetch(MYSQL_ASSOC);
            return $new;
        }
        else
        {
            if ($this->db->getErrorId() == 1062)
            //1062 = duplicate
            {
                array_push($registration_controller->data["errors"], "Credit Card Already Exist!");
            }
            $registration_controller->display("registration.twig", $registration_controller->data);
        }
    }
    
    
}
?>