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
					c.name AS category " . "FROM types AS t " . "INNER JOIN categories AS c " . "ON t.id = c.type_id
			ORDER BY category ASC";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        $category_hash = array();

        foreach ($result as $row) {
            $category_hash[$row["type"]][] = array(
                "name" => $row["category"],
                "id" => $row["id"]
            );
        }


        return $category_hash;
    }

    public function getAllCategoriesByType($type_name)
    {
        // Get all the types
        $query = "SELECT FROM types t
      			  INNER JOIN categories AS c
      			  ON t.id = c.type_id
                  WHERE t.name = $type_name";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);
    }

    public function getCategoryStats($args)
    {
        $query = "SELECT c.name, SUM(o.price) AS volume, COUNT(*) AS counts FROM posts p
          JOIN offers o ON o.id = p.offer_id
          JOIN categories c ON c.id = o.category_id
        GROUP BY c.name";

        if (isset($args['order_by']))
            $query .= " ORDER BY ".$args['order_by'];
            if (isset($args['direction']))
                $query .= " ".$args['direction'];

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        return empty($result) ? NULL : $result;
    }
}