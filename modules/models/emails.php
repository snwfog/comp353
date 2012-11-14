<?php

class Email_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function setEmail($email, $member_id)
    {
        $email_id = $this->getEmailId($email);

        if (empty($email_id))
        {
            list($name, $domain) = explode("@", $email);
            list($domain, $top_level_domain) = explode(".", $domain);

            $top_level_domain_id = $this->getTopLevelDomainId($top_level_domain);
            if (empty($top_level_domain_id))
            {
                $this->setTopLevelDomain($top_level_domain);
                $top_level_domain_id = $this->getTopLevelDomainId($top_level_domain);
            }

            $domain_id = $this->getDomainId($domain);
            if (empty($domain_id))
            {
                $this->setDomain($domain);
                $domain_id = $this->getDomainId($domain);
            }

            $query = "INSERT INTO emails (name, member_id, domain_id,top_level_domain_id)
                      VALUES ('$name'
                        , '$member_id'
                        , '$domain_id'
                        , '$top_level_domain_id')";

            $this->set($query);
        }
        else
        {
            throw new Exception("Email already exists.");
        }
    }

    public function getEmailId($email)
    {
        list($name, $domain) = explode("@", $email);
        list($domain, $top_level_domain) = explode(".", $domain);

        $top_level_domain_id = $this->getTopLevelDomainId($top_level_domain);

        $domain_id = $this->getDomainId($domain);

        $query = "SELECT id
                  FROM emails
                  WHERE name='$name'
                    AND domain_id = '$domain_id'
                    AND top_level_domain_id = '$top_level_domain_id'";

        $result = $this->get($query);

        return isset($result[0]['id']) ? $result[0]['id'] : "";
    }

    public function getTopLevelDomainId($top_level_domain)
    {
        $query = "SELECT id FROM top_level_domains
                  WHERE name = '$top_level_domain'";

        $result = $this->get($query);
        return isset($result[0]['id']) ? $result[0]['id'] : "";
    }

    public function setTopLevelDomain($top_level_domain)
    {
        $query = "INSERT INTO top_level_domains (name)
                  VALUES ('$top_level_domain')";

        $this->set($query);
    }

    public function getDomainId($domain)
    {
        $query = "SELECT id FROM domains
                  WHERE name = '$domain'";

        $result = $this->get($query);
        return isset($result[0]['id']) ? $result[0]['id'] : "";
    }

    public function setDomain($domain)
    {
        $query = "INSERT INTO domains (name)
                  VALUES ('$domain')";

        $this->set($query);
    }


}
