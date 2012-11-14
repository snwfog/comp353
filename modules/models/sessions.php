<?php

class Session_Model extends Model
{
    private $table = "test_sessions";

    public function setSession($username, $password)
    {
//        $session = hash('sha256', $session);

        $query = "INSERT INTO $this->table (
            username, password, session, expire
        ) VALUES ( '$username', '$password', '123123', 0 )";


        if (isset($this->db))
            $this->db->set($query);
        else
            throw new Exception("Error inserting into sessions table.");
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
