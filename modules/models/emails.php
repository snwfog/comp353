<?php

class Email_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function setEmailAndGetId($email, $member_id)
    {
        list($name, $domain) = explode("@", $email);
        list($domain, $top_level_domain) = explode(".", $domain);

        $tld_id = $this->getTopLevelDomain($top_level_domain, "name");
        if (empty($tld_id))
        {
            $tld_id = $this->setTopLevelDomainAndGetId($top_level_domain);
        }

        $domain_id = $this->getDomain($domain, "name");
        if (empty($domain_id))
        {
            $domain_id = $this->setDomainAndGetId($domain);
        }

        $query = "INSERT INTO emails (name
                    , member_id
                    , domain_id
                    , top_level_domain_id
                  ) VALUES ('$name'
                    , '$member_id'
                    , '$domain_id'
                    , '$tld_id')";

        // if success then database insert was okay.
        // else if not success, there is some sql error that will be shown.
        $success = $this->db->query($query);

        // If insert is success, get the id
        return $this->db->getLastInsertId();
    }

    public function getEmailById($id)
    {
        // Check if this id exists
        $query = "SELECT * FROM emails WHERE id='$id'";
        $mysqli_raw = $this->db->query($query);
        $result = $this->db->selectField();

        if (empty($result))
            return FALSE;
        else
        {
            // Restitches the email
            // Since email from id is unique, assume email is at index 0
            $name = $result[0]['name'];
            $domain = $this->getDomain($result[0]['domain_id'], "id", "name");
            $tld = $this->getTopLevelDomain($result[0]['top_level_domain_id'], "id", "name");

            return "$name@$domain.$tld";
        }
    }

    public function getIdByEmail($email, $field = "id")
    {
        list($name, $domain) = explode("@", $email);
        list($domain, $top_level_domain) = explode(".", $domain);

        $top_level_domain_id = $this->getTopLevelDomain($top_level_domain, "name");

        $domain_id = $this->getDomain($domain, "name");

        $query = "SELECT id
                  FROM emails
                  WHERE name='$name'
                    AND domain_id = '$domain_id'
                    AND top_level_domain_id = '$top_level_domain_id'";

        $mysqli_raw = $this->db->query($query);
        $result = $this->db->selectField($field);

        return empty($result) ? FALSE : $result;
    }

    /**
     * SELECT $select FROM $table WHERE $what = $where
     *
     */
    public function getTopLevelDomain($where, $what, $select = "id")
    {
        return $this->get($where, $what, $select, "top_level_domains");
    }

    public function setTopLevelDomainAndGetId($top_level_domain)
    {
        $query = "INSERT INTO top_level_domains (name)
                  VALUES ('$top_level_domain')";

        // if success then database insert was okay.
        // else if not success, there is some sql error that will be shown.
        $success = $this->db->query($query);

        // If insert is success, get the id
        return $this->db->getLastInsertId();
    }


    public function getDomain($where, $select, $select_field = "id")
    {
        return $this->get($where, $select, $select_field, "domains");
    }

    public function setDomainAndGetId($domain)
    {
        $query = "INSERT INTO domains (name)
                  VALUES ('$domain')";

        // If success then database insert was okay.
        // else if not success, there is some sql error that will be shown.
        $success = $this->db->query($query);

        // If insert is success, get the id
        return $this->db->getLastInsertId();
    }
}
