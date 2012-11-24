<?php

class Bid_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getBidByOfferId($offer_id)
    {
        $query = "SELECT b.id,
          m.id AS bidder_id,
          m.username AS bidder,
          t.name AS type,
          t.id AS type_id,
          c.name AS category,
          c.id AS category_id,
          b.price AS price,
          b.description AS description,
          b.expire AS expire
        FROM bids AS b
          INNER JOIN members AS m ON m.id = b.member_id
          INNER JOIN categories AS c ON c.id = b.category_id
          INNER JOIN types AS t ON c.type_id = t.id
        WHERE
          offer_id = $offer_id";

        $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result;
    }

    public function getAllBidByMemberId($member_id)
    {
        $query = "SELECT b.id,
          b.offer_id AS offer_id,
          m.id AS bidder_id,
          m.username AS bidder,
          t.name AS type,
          t.id AS type_id,
          c.name AS category,
          c.id AS category_id,
          b.price AS price,
          b.description AS description,
          b.expire AS expire
        FROM bids AS b
          INNER JOIN members AS m ON m.id = b.member_id
          INNER JOIN categories AS c ON c.id = b.category_id
          INNER JOIN types AS t ON c.type_id = t.id
        WHERE
          member_id = $member_id";

        $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result;
    }

    public function getOngoingBidByMemberId($member_id)
    {
        $query = "SELECT b.id,
          b.offer_id AS offer_id,
          m.id AS bidder_id,
          m.username AS bidder,
          t.name AS type,
          t.id AS type_id,
          c.name AS category,
          c.id AS category_id,
          b.price AS price,
          b.description AS description,
          b.expire AS expire
        FROM bids AS b
          INNER JOIN members AS m ON m.id = b.member_id
          INNER JOIN categories AS c ON c.id = b.category_id
          INNER JOIN types AS t ON c.type_id = t.id
        WHERE
          member_id = $member_id AND b.expire != 1";

        $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result;
    }

    public function setBid($member_id, $offer_id, $category_id, $price,
        $description)
    {
        $value = array
        (
            $member_id, $offer_id,
            $category_id, $price,
            $description, "0"
        );

        $attribute = array
        (
            "member_id", "offer_id",
            "category_id", "price",
            "description", "expire"
        );

        return $this->setRowAndGetId($value, $attribute, "bids");
    }
}
