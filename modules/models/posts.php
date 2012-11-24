<?php

class Post_Model extends Model
{
	public function __construct()
	{
		parent::__construct();
	}

	public function setPost($member_id, $offer_id)
	{
		$value = array($member_id, $offer_id);
		$attribute = array("member_id", "offer_id");
		$table = "posts";

		return parent::setRowAndGetId($value, $attribute, $table);
	}

	public function getPostByMemberId($member_id)
	{
		$query = "SELECT member_id, 
  					o.id AS id,
  					t.name AS type,
  					c.name AS category,
 					o.title AS title,
  					o.price AS price,
                    expire
  				  FROM posts p 
    				INNER JOIN offers AS o 
    					ON p.offer_id = o.id 
   				 	INNER JOIN categories AS c 
   				 		ON o.category_id = c.id
    				INNER JOIN types AS t 
    					ON c.type_id = t.id
				  WHERE member_id = $member_id";

		$result_object = $this->db->query($query);
		$result = $this->db->fetch(MYSQLI_ASSOC);

		return isset($result) ? $result : NULL;
	}
}