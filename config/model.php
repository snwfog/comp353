<?php

abstract class Model
{
    protected $db;

    protected function __construct()
    {
        $this->db = Database::getInstance();
    }


    /**
     * Helper function to compare one single field and return an unique field.
     *
     */
    protected function get($where, $what, $select, $table)
    {
        // if (is_array($field))
        $query = "SELECT $select FROM $table
                  WHERE $what = '$where'";

        $myqli_raw = $this->db->query($query);
        $result = $this->db->selectField($select);

        return empty($result) ? FALSE : $result;
    }
}
