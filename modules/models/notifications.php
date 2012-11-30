<?php

class Notification_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getModifiedOffers($member_id)
    {
        $query = "SELECT
          o.title AS title,
          o.id AS id
        FROM notify_modify n
          JOIN offers o ON o.id = n.offer_id
        WHERE n.member_id = '$member_id'";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        if (!empty($result))
        {
            $query = "DELETE FROM notify_modify
                WHERE member_id = '$member_id'";
            $this->db->query($query);
        }

        return empty($result) ? NULL : $result;
    }

    public function getExpiredBids($member_id)
    {
        $query = "SELECT
          bids.description AS description,
          bids.price AS price,
          offers.title AS offer,
          expire_date AS date,
          offers.id AS id
        FROM notify_queue nq
          JOIN bids ON bids.id = nq.bid_id
          JOIN offers ON offers.id = bids.offer_id
        WHERE bids.member_id = '$member_id'
        ORDER BY expire_date DESC";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        // Delete after retrieval
        if (!empty($result))
        {
            $query = "DELETE FROM notify_queue q
              JOIN bids ON bids.id = nq.bid_id
            WHERE bids.member_id = '$member_id'";

            $this->db->query($query);
        }

        return empty($result) ? NULL : $result;
    }

    public function getReceivedOffers($member_id)
    {
        $query = "SELECT
          o.title AS title,
          o.id AS id
        FROM notify_receive n
          JOIN storages s ON s.id = n.storage_id
          JOIN transacts t ON t.id = s.transact_id
          JOIN offers o ON o.id = t.offer_id
        WHERE t.seller_id = '$member_id'";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        if (!empty($result))
        {
            $query = "DELETE notify_receive
              FROM notify_receive
                JOIN storages ON storages.id = notify_receive.storage_id
                JOIN transacts ON transacts.id = storages.transact_id
              WHERE transacts.seller_id = '$member_id'";

            $this->db->query($query);
        }

        return empty($result) ? NULL : $result;
    }

    public function getAcquireOffers($member_id)
    {
        $query = "SELECT
          o.title AS title,
          o.id AS id
        FROM notify_receive n
          JOIN storages s ON s.id = n.storage_id
          JOIN transacts t ON t.id = s.transact_id
          JOIN offers o ON o.id = t.
        WHERE t.buyer_id = '$member_id'";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        if (!empty($result))
        {
            $query = "DELETE FROM notify_acquire
              JOIN storages ON storages.id = notify_acquire.storage_id
              JOIN transacts ON transacts.id = storages.transact_id
              JOIN offers ON offers.id = transacts.offer_id
            WHERE transacts.buyer_id = '$member_id'";

            $this->db->query($query);
        }

        return empty($result) ? NULL : $result;
    }
}
