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

    public function getMemberCreditCard($member_id)
    {
        $result = $this->db->query("Select * FROM credit_cards WHERE credit_cards.member_id = $member_id");
        $result = $this->db->fetch(MYSQL_ASSOC);
        return $result;
    }
    
    public function create_credit_card($member_id, $credit_card_type_id, $number, $expire, $verification, $holder_name)
    {
        $holder_name     = "\"" . $holder_name . "\"";
        $expire     = "\"" . $expire . "\"";
        $number     = "\"" . $number . "\"";
        $verification    = "\"" . $verification . "\"";
        $insert = array(
            $member_id,
            $credit_card_type_id,
            $number,
            $expire,
            $verification,
            $holder_name
        );
        $insert = implode(",", $insert);
        if ($this->db->query("INSERT INTO credit_cards
                                    (member_id, credit_card_type_id, number, expire, verification_code, holder_name)
                              VALUES(" . $insert . ");"))
        {
            $new = $this->db->getLastInsertId();
            $new = $this->db->query("Select * FROM addresses WHERE id=" . $new);
            $new = $this->db->fetch(MYSQL_ASSOC);
            return $new;
        }
    }


    public function update_credit_card($member_id, $credit_card_type_id, $number, $expire, $verification, $holder_name)
    {
        $holder_name     = "\"" . $holder_name . "\"";
        $expire     = "\"" . $expire . "\"";
        $number     = "\"" . $number . "\"";
        $verification    = "\"" . $verification . "\"";
        $result = $this->db->query("Update credit_cards
                                    SET credit_card_type_id = $credit_card_type_id,
                                        number = $number, 
                                        expire = $expire, 
                                        verification_code = $verification, 
                                        holder_name = $holder_name
                                    WHERE member_id = $member_id;");
        if ($result)
        {
           return TRUE;
        }
    }


    public function getCreditCardTypes()
    {
        $result = $this->db->query("Select * FROM credit_card_types");
        $result = $this->db->fetch(MYSQL_ASSOC);
        return $result;
    }

    public function isUniqueCreditCard($number, $member_id)
    {
        $result = $this->db->query("Select * FROM credit_cards WHERE number = $number AND NOT member_id = $member_id");
        $result = $this->db->fetch(MYSQL_ASSOC);
        return $result ? FALSE : TRUE;
    }
    
    
}
?>