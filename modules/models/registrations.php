<?php
class Registration_Model
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    public function create_user($username, $password, $password2,
        $address_id, $visitor_id, $avatar_url)
    {
        //to do
    }

    public function get_attribute($attribute)
    {
        $this->db->query("Select " . $attribute . " FROM members");
        $result = $this->db->get();
        return $result;
    }

    public function exist_attribute($attribute, $value)
    {
        $value = "\"" . $value . "\"";
        $this->db->query("Select " . $attribute . " FROM members WHERE " . $attribute . "=" . $value);
        if (count($this->db->get()) > 0)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
}
