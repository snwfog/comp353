<?php
class Registration_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function create_user($username, $password, $password2,
        $address_id, $visitor_id, $avatar_url)
    {
        //to do
    }

    public function get_attribute($attribute)
    {
        $this->db->query("Select " . $attribute . " FROM members");
        $result = $this->db->selectField("",MYSQL_ASSSOC);
        return $result;
    }

    public function exist_attribute($attribute, $value)
    {
        $value = "\"" . $value . "\"";
        $this->db->query("Select " . $attribute . " FROM members WHERE " . $attribute . "=" . $value);
        $result = $this->db->selectField("",MYSQL_ASSOC);
        if (count($result) > 0)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
}
