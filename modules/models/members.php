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

    public function getPublicMemberInfo($member_id)
    {
        // First check if the member exists
        $members = $this->getAll(ALL, "id", $member_id, "members");
        if (count($members) > 1 || empty($members))
            return NULL;
        // Else this member must exists
        $query = "SELECT
          m.username AS username,
          v.join_date AS join_date
        FROM visitors AS v
          INNER JOIN members AS m ON m.visitor_id = v.id
        WHERE m.id = $member_id";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result[0];
    }

    public function getPrivateMemberInfo($member_id)
    {
        // First check if the member exists
        $members = $this->getAll(ALL, "id", $member_id, "members");
        if (count($members) > 1 || empty($members))
            return NULL;
        // Else this member must exists
        $query = "SELECT
          v.first_name AS first_name,
          v.last_name AS last_name,
          v.phone_number AS phone_number,
          a.address AS address,
          a.city AS city,
          a.province AS province,
          a.country AS country,
          a.postal_code AS postal_code
        FROM visitors AS v
          INNER JOIN members AS m ON m.visitor_id = v.id
          INNER JOIN addresses AS a ON m.address_id = a.id
        WHERE m.id = $member_id";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result[0];
    }

    public function get_attribute($attribute)
    {
        $this->db->query("Select " . $attribute . " FROM members");
        $result = $this->db->fetch(MYSQL_ASSSOC);
        return $result;
    }

    public function get_visitor_id($member_id)
    {
        $this->db->query("Select visitor_id FROM members WHERE id = $member_id;");
        $result = $this->db->fetch();
        return empty($result) ? NULL : $result[0]["visitor_id"];
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

    public function getMemberStatsByName($args)
    {

        $query = "SELECT * FROM member_stats WHERE
          username LIKE '%" . $args['admin_member_search'] . "%'";
        if (isset($args['order_by']))
            $query .= " ORDER BY ". $args['order_by'];
            if (isset($args['direction']))
                $query .= " " . $args['direction'];

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        return empty($result) ? NULL : $result;
    }

    public function create_member($username, $password, $email_id, $address_id,
                                  $visitor_id, $registration_controller)
    {
        $username   = "\"" . $username . "\"";
        $password   = "\"" . hash(ENCRYPTION_TYPE, $password) . "\"";
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
