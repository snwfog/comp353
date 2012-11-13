<?php

class Login_Model{
    private $db;
    public function __construct() {
        $this->db = Database::getInstance();
    }

    public function get_user(){
    }
}
