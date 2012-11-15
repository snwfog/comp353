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

        $tld_id = $this->getTopLevelDomain("id", "name", $top_level_domain);
        if (isset($tld_id))
            $tld_id = Helper::getIndex($tld_id[0], "id");
        else
            $tld_id = $this->setTopLevelDomainAndGetId($top_level_domain);

        $domain_id = $this->getDomain("id", "name", $domain);
        if (isset($domain_id))
            $domain_id = Helper::getIndex($domain_id[0], "id");
        else
            $domain_id = $this->setDomainAndGetId($domain);

		// Prepare the data
		$value = array($name, $member_id, $domain_id, $tld_id);
		$attribute = array('name', 'member_id', 'domain_id', 'top_level_domain_id');
		$table = "emails";

		return $this->setRowAndGetId($value, $attribute, $table);
    }

    public function getEmailById($id)
    {
        $result = $this->getUnique(ALL, "id", $id, "emails");

        if (isset($result))
        {
            // Restitches the email
            // Since email from id is unique, assume email is at index 0
            $name = $result['name'];
            $domain = Helper::getFirstIndex($this->getDomain("name", "id",
                $result['domain_id']), "name");

            $tld = Helper::getFirstIndex($this->getTopLevelDomain("name", "id",
                $result['top_level_domain_id']), "name");

            return "$name@$domain.$tld";
        }
    }

    public function getIdByEmail($email)
    {
        list($name, $domain) = explode("@", $email);
        list($domain, $top_level_domain) = explode(".", $domain);

		// The dump way
		$top_level_domain_id = Helper::getIndex($this->getUnique("id", "name",
			$top_level_domain, "top_level_domains"), "id");

		$domain_id = Helper::getIndex($this->getUnique("id", "name", $domain, "domains"), "id");

		if (!isset($top_level_domain_id) || !isset($domain_id))
			return NULL;

		$select = "id";
		$where = array("name", "domain_id", "top_level_domain_id");
		$what = array($name, $domain_id, $top_level_domain_id);
		$table = "emails";

		$mysqli_result = $this->getUnique($select, $where, $what, $table);

		// The smart way
		// Maybe later...
		return Helper::getIndex($mysqli_result, "id");
	}

    /**
     * <pre>SELECT $select FROM $table WHERE $where = $what</pre>
	 * <pre>getAll($select, $where, $what, $table)</pre>
     */
    public function getTopLevelDomain($select, $where, $what, $table = "top_level_domains")
    {
        return $this->getAll($select, $where, $what, $table);
    }

    public function setTopLevelDomainAndGetId($top_level_domain)
    {
        return $this->setRowAndGetId($top_level_domain, "name", "top_level_domains");
    }


    public function getDomain($select, $where, $what, $table = "domains")
    {
        return $this->getAll($select, $where, $what, $table);
    }


    public function setDomainAndGetId($domain)
    {
		return $this->setRowAndGetId($domain, "name", "domains");
    }
}
