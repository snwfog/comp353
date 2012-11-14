<?php

/**
 * Model abstract class
 */
abstract class Model
{
    protected $db;

    protected function __construct()
    {
        $this->db = Database::getInstance();
    }

    /**
     * Helper function to compare one single field and return an unique field.
     * <pre>SELECT $select FROM $table WHERE $where = $what</pre>
     *
     */
    protected function getAll($select, $where, $what, $table)
    {
        if (is_array($select))
		{
			$select_stmt = implode(', ', $select);
			$select = $select_stmt;
		}

		if (is_array($where) && is_array($what)
				&& count($where) == count($what))
		{
			$where_stmt = "$where[0] = $what[0]";

			for ($i = 1; $i < count($where); $i++)
			{
				$where_stmt .= " AND ";
				$where_stmt .= "$where[$i] = '$what[$i]'";
			}
		}
		else if (isset($where) && isset($what))
		{
			$where_stmt = "$where = '$what'";
		}


        $query = "SELECT $select FROM $table";
        if (isset($where_stmt))
            $query .= " WHERE $where_stmt";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();
        $this->db->free();

        return empty($result) ? NULL : $result;
    }

    /**
     * Get a single row of entry assuming that the record is unique.
     */
    protected function getUnique($select, $where, $what, $table)
	{
        $result = $this->getAll($select, $where, $what, $table);
		return empty($result[0]) ? NULL : $result[0];
	}

    /**
     * Get an array of all the attribute in a single column format.
     */
    protected function getColumn($select, $where, $what, $table)
    {
        $result = $this->getAll($select, $where, $what, $table);
        $data = array();

        if (isset($result))
        {
            if (is_array($select))
            {
                foreach ($select as $key)
                {
                    $data[$key] = array();
                }

                foreach ($result as $row)
                {
                    foreach ($select as $key)
                    {
                        $data[$key][] = $row[$key];
                    }
                }
            }
            else
            {
                foreach ($result as $row)
                    $data[$select][] = $row[$select];
            }
        }

        return empty($data) ? NULL : $data;
    }
}
