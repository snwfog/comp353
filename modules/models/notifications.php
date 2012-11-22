<?php

class Notification_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getExpiredBids($member_id)
    {
        $query = "SELECT
          bids.description AS description,
          bids.price AS price,
          offers.title AS offer,
          expire_date AS date
        FROM notify_queue nq
          JOIN bids ON bids.id = nq.bid_id
          JOIN offers ON offers.id = bids.offer_id
        WHERE bids.member_id = '$member_id'
        ORDER BY expire_date DESC";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();
        return empty($result) ? NULL : $result;
    }
}
