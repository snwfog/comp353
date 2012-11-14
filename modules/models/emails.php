<?php

class Email_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function setEmail($email, $member_id)
    {
        list($username, $domain) = explode("@", $email);
        list($domain, $top_level_domain) = explode(".", $domain);

        if ($this->getTopLevelDomainId($top_level_domain))
            echo "has this top";
        else
        {
            // Then this must be a new email address
            $query = "INSERT INTO top_level_domain VALUES($top_level_domain)";
            $this->set($query);

            //
        }
    }

    public function getTopLevelDomainId($top_level_domain)
    {
        $query = "SELECT id FROM top_level_domains
                  WHERE name = '$top_level_domain'";
        return $this->get($query);
    }
}
