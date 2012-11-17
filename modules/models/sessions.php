<?php

class Session_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    private $table = "sessions";

    public function getSessionId($member_id)
    {
        return $this->getAll("id", "member_id", $member_id, $this->table);
    }

    public function getAllUnexpiredSessionId($member_id)
    {
        return $this->getAll("id", array("member_id", "expire"),
            array($member_id, "0"), $this->table);
    }

    public function setAllExpire($member_id)
    {
        $query = "UPDATE $this->table SET expire='1'
                  WHERE member_id='$member_id' AND expire='0'";

        $this->db->query($query);
    }

    public function setAllUnexpire($member_id)
    {
        $query = "UPDATE $this->table SET expire='0'
                  WHERE member_id='$member_id' AND expire='1'";

        $this->db->query($query);
    }

    public function generateNewSession($member_id)
    {
        $session_hash = hash(ENCRYPTION_TYPE, date("Y-m-d H:i:s"));

        $attributes = array("member_id", "session", "expire");
        $values = array($member_id, $session_hash, "0");

        return $this->setRowAndGetId($values, $attributes, $this->table);
    }

    public function destroySessionByMemberId($member_id)
    {
        $query = "UPDATE $this->table SET expire='1'
                  WHERE member_id='$member_id' AND expire='0'";

        $this->db->query($query);

    }

    public function destroySessionBySessionId($session_id)
    {
        $query = "UPDATE $this->table SET expire='1'
                  WHERE id='$session_id' AND expire='0'";

        $this->db->query($query);
    }

    public function getUser($session_id)
    {
        $query = "SELECT username FROM members WHERE username = (
                  SELECT username FROM $this->table WHERE id = '$session_id')";

        if (isset($this->db))
        {
            $this->db->query($query);
            $result = $this->db->get();
            return $result;
        }
        else
            throw new Exception("Error getting user.");
    }

    public function setExpire($session_id, $value)
    {
        $expire = ($value) ? 1 : 0;
        $query = "UPDATE $this->table
                  SET expire = $expire
                  WHERE id = $session_id";

        if (isset($this->db))
            $this->db->set($query);
        else
            throw new Exception("Could not set session expiration.");
    }
}
