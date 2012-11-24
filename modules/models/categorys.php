<?php

class Category_Model extends Model
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getAllCategories()
	{
		// Get all the types
		$query = "SELECT
					c.id AS id,
					t.name AS type,
					c.name AS category "
			. "FROM types AS t "
			. "INNER JOIN categories AS c "
			. "ON t.id = c.type_id";

		$mysqli_result = $this->db->query($query);
		$result = $this->db->fetch(MYSQLI_ASSOC);

		$category_hash = array();

		foreach ($result as $row)
		{
			$category_hash[$row["type"]][] = array
			(
				"name" => $row["category"],
				"id" => $row["id"]
			);
		}


		return $category_hash;
	}


    	public function getAllCategoriesByType($type_name)
	{
		// Get all the types
		$query = "SELECT
      			 FROM types t
      			 INNER JOIN categories AS c
      			 ON t.id = c.type_id
`                WHERE t.name = $type_name";

		$mysqli_result = $this->db->query($query);
		$result = $this->db->fetch(MYSQLI_ASSOC);
        print_r($result);
	}
}