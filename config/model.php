<?php

abstract class Model
{
    protected $db;

    protected function __construct()
    {
        $this->db = Database::getInstance();
    }

    protected function get($query)
    {
        $this->db->query($query);
        return $this->db->get();
    }

    protected function set($query)
    {
        $this->db->query($query);
    }

}
