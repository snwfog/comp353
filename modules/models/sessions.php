<?php

class Sessions_Model
{
    private $db;

    public function __construct()
    {
        $this->db = Database::getInstance();
    }

    public function setSession($username, $password)
    {
//        $session = hash('sha256', $session);

        $query = "INSERT INTO test_sessions (
            username, password, session, expire
        ) VALUES ( '$username', '$password', '123123', 0 )";


        if (isset($this->db))
            $this->db->set($query);
        else
            die("Error inserting into sessions table.");
    }
}
