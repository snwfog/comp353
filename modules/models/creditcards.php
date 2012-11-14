<?php

class CreditCard_Model extends Model
{
    protected $db;
    public function __construct() {
        $this->db = Database::getInstance();
    }
}
?>