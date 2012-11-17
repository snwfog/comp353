<?php

class Member_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }


    /**
     * Get the user ID provided username and hashed password.
     *
     * @param $username
     * @param $password
     * @return int The member id or NULL
     */
    public function getUserId($username, $password)
    {
        return $this->getUnique("id", array("username", "password"),
            array($username, $password), "members");
    }

    public function get_attribute($attribute)
    {
        $this->db->query("Select " . $attribute . " FROM members");
        $result = $this->db->fetch(MYSQL_ASSSOC);
        return $result;
    }

    public function exist_attribute($attribute, $value)
    {
        $value = "\"" . $value . "\"";
        $this->db->query("Select " . $attribute . " FROM members WHERE " . $attribute . "=" . $value);
        $result = $this->db->fetch(MYSQL_ASSOC);
        if (count($result) > 0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }


    public function create_member($username, $password, $email_id, $address_id, $visitor_id, $registration_controller)
    {
        $username   = "\"" . $username . "\"";
        $password   = "\"" . sha1($password) . "\"";
        $address_id = "\"" . $address_id . "\"";
        $visitor_id = "\"" . $visitor_id . "\"";
        $insert     = array(
            $username,
            $password,
            $email_id,
            $address_id,
            $visitor_id
        );
        $insert     = implode(",", $insert);
        if ($this->db->query("INSERT INTO members (username, password, email_id, address_id, visitor_id) VALUES(" . $insert . ");")) {
            $new = $this->db->getLastInsertId();
            $new = $this->db->query("Select * FROM addresses WHERE id=" . $new);
            $new = $this->db->fetch(MYSQL_ASSOC);
            return $new;
        } else {
            if ($this->db->getErrorId() == 1062) { //1062 = duplicate
                array_push($registration_controller->data["errors"], "User name exists");
            }
            $registration_controller->display("registration.twig", $registration_controller->data);
        }

    }

}
