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
     * SELECT $select FROM $table WHERE $what = $where.
     */
    protected function getAll($where, $what, $select, $table)
    {
        if (is_array($select))
		{
			$select_stmt = implode(', ', $select);
			$select = $select_stmt;
		}
		
		if (is_array($what) && is_array($where)
				&& count($what) == count($where))
		{
			$where_stmt = "$what[0] = $where[0]";
			
			for ($i = 1; $i < count($what); $i++)
			{
				$where_stmt .= " AND ";
				$where_stmt .= "$what[$i] = '$where[$i]'";
			}
		}
		else
		{
			$where_stmt = "$what[$i] = '$where[$i]'";
		}

		$query = "SELECT $select FROM $table
				  WHERE $where_stmt";
		
        $myqli_raw = $this->db->query($query);
        $result = $this->db->selectField();

        return empty($result) ? FALSE : $result;
    }
	
	protected function getUnique($where, $what, $select, $table)
	{
        $result = $this->getAll($where, $what, $select, $table);
		return empty($result[0]) ? FALSE : $result[0];
	}
}
