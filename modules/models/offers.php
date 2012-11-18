<?php

class Offer_Model extends Model
{
	public function __construct()
	{
		parent::__construct();
	}

	public function setRowAndGetId($value, $attribute, $table)
	{
		return parent::setRowAndGetId($value, $attribute, $table);
	}

    public function getOffer($offer_id)
    {
        $query = "SELECT
            o.id AS id,
            t.name AS type,
            c.name AS category,
            o.title AS title,
            o.price AS price,
            o.image_url AS image_url,
            o.description AS description
        FROM offers AS o
          INNER JOIN categories AS c
            ON o.category_id = c.id
          INNER JOIN types AS t
            ON c.type_id = t.id
        WHERE o.id = $offer_id";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result[0];
    }

    public function getOwner($offer_id)
    {
        $query = "SELECT m.username AS username, m.id AS id
          FROM members AS m
            INNER JOIN posts AS p
              ON p.member_id = m.id
            INNER JOIN offers AS o
              ON p.offer_id = o.id
          WHERE o.id = $offer_id";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return (empty($result)) ? NULL : $result[0];
    }
}
