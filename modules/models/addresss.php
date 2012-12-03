<?php

class Address_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }


    public function get_attribute($attribute)
    {
        $result = $this->db->query("Select " . $attribute . " FROM addresses");
        $result = $this->db->fetch(MYSQL_ASSOC);
        return $result;
    }

    public function exist_attribute($attribute, $value)
    {
        $value = "\"" . $value . "\"";
        $result = $this->db->query("Select " . $attribute . " FROM addresses WHERE " . $attribute . "=" . $value);
        $result = $this->db->fetch(MYSQL_ASSOC);
        if (count($result) > 0) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

    public function create_address($address, $city, $province, $country, $postal_code, $registration_controller)
    {
        $address = "\"" . $address . "\"";
        $city = "\"" . $city . "\"";
        $province = "\"" . $province . "\"";
        $country = "\"" . $country . "\"";
        $postal_code = "\"" . $postal_code . "\"";
        $insert = array(
            $address,
            $city,
            $province,
            $country,
            $postal_code
        );
        $insert = implode(",", $insert);
        if ($this->db->query("INSERT INTO addresses (address, city, province, country, postal_code) VALUES(" . $insert . ");")) {
            $new = $this->db->getLastInsertId();
            $this->db->query("Select * FROM addresses WHERE id=" . $new);
            $new = $this->db->fetch(MYSQL_ASSOC);
            return $new[0];
        } else {
            //error handling
        }

    }

    public function getCityStats()
    {
        $query = "SELECT a.city AS location, COUNT(*) AS counts
        FROM members m
          JOIN addresses a ON a.id = m.address_id
          JOIN posts p ON p.member_id = m.id
        GROUP BY a.city
        ORDER BY counts DESC";

        $this->db->query($query);
        $result = $this->db->fetch();

        return empty($result) ? NULL : $result;
    }

    public function getCountryStats()
    {
        $query = "SELECT a.country AS location, COUNT(*) AS counts
        FROM members m
          JOIN addresses a ON a.id = m.address_id
          JOIN posts p ON p.member_id = m.id
        GROUP BY a.country
        ORDER BY counts DESC";

        $this->db->query($query);
        $result = $this->db->fetch();

        return empty($result) ? NULL : $result;
    }


}
?>