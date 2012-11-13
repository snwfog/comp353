<?php

class Sessions_Model
{
    private $db;

    public function __construct()
    {
        $db = Database::getInstance();
    }

    public function setSession($member_id, $session)
    {
        $session = hash('sha256', $session);

        $query = "INSERT INTO sessions(member_id, session) " .
                 "VALUES ($member_id, $session)";

        if (isset($db))
            $db->set($query);
        else
            die("Error inserting into sessions table.");
    }
}
