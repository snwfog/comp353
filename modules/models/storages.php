<?php

class Storage_Model extends Model
{
    protected $db;
    public function __construct()
    {
        parent::__construct();
    }
    
    public function create_storage($transaction_id){
      $this->db->query("INSERT INTO storages (transact_id) VALUES ($transaction_id);");
    }

    public function in_storage($transaction_id){
      $this->db->query("Select * FROM storages WHERE transact_id = $transaction_id");
      $result = $this->db->fetch(MYSQL_ASSOC);
      return $result;
    }

    public function ready_for_pick_up($transaction_id){
      $this->db->query("Select * FROM storages WHERE transact_id = $transaction_id and acquire_date <> NULL");
      $result = $this->db->fetch(MYSQL_ASSOC);
      return $result;
    }

    public function picked_up($transaction_id){
      $this->db->query("Select * FROM storages WHERE transact_id = $transaction_id and  pickup_date <> NULL");
      $result = $this->db->fetch(MYSQL_ASSOC);
      return $result;
    }

    public function getAllActiveStorageItems()
    {
        $query = "SELECT
          s.*,
          m.id AS owner_id,
          m.username AS owner,
          o.id AS offer_id,
          tp.name AS type,
          c.name AS category,
          o.title AS title,
          o.price AS price
        FROM storages s
          JOIN transacts t ON t.id = s.transact_id
          JOIN offers o ON t.offer_id = o.id
          JOIN categories c ON o.category_id = c.id
          JOIN types tp ON c.type_id = tp.id
          JOIN posts p ON p.offer_id = o.id
          JOIN members m ON p.member_id = m.id
        WHERE (acquire_date IS NULL AND pickup_date IS NULL)
          OR (acquire_date IS NOT NULL AND
            DATE(CURDATE()) - DATE(acquire_date) <= 14)";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        return empty($result) ? NULL : $result;
    }

    public function getAllGarageSales()
    {
        $query = "SELECT
          s.*,
          m.id AS owner_id,
          m.username AS owner,
          o.id AS offer_id,
          tp.name AS type,
          c.name AS category,
          o.title AS title,
          o.price AS price
        FROM garages s
          JOIN transacts t ON t.id = s.transact_id
          JOIN offers o ON t.offer_id = o.id
          JOIN categories c ON o.category_id = c.id
          JOIN types tp ON c.type_id = tp.id
          JOIN posts p ON p.offer_id = o.id
          JOIN members m ON p.member_id = m.id";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch();

        return empty($result) ? NULL : $result;
    }

}
?>