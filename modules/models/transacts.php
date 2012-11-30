<?php

class Transact_Model extends Model
{
    protected $db;
    public function __construct()
    {
        parent::__construct();
    }
    
    public function createTransaction($offer_id, $buyer_id, $seller_id, $bid_id){
      $attribute = array("offer_id, buyer_id, seller_id, transact_date, bid_id");
      $value = array($offer_id, $buyer_id, $seller_id, date("Y-n-d"), $bid_id);
      return $this->setRowAndGetId($value, $attribute, "transacts");
    }

    public function getSoldTransactionByMemberId($id)
    {
        $query = "SELECT t.id, t.transact_date,
          t.offer_id, t.buyer_id, o.title,
          o.description, o.price, m.username,
          types.name AS type
        FROM transacts t
          JOIN offers o ON t.offer_id = o.id
          JOIN members m ON m.id = t.buyer_id
          JOIN categories c ON c.id = o.category_id
          JOIN types ON types.id = c.type_id
        WHERE t.seller_id = '$id'";

        $this->db->query($query);

//      $this->db->query("SELECT t.id, t.transact_date,
//                          t.offer_id, t.buyer_id, O.title,
//                          O.description, O.price, M.username,
//                          types.name AS type
//                        FROM transacts t
//                        INNER JOIN offers AS O
//                            ON (t.offer_id = O.id)
//                        INNER JOIN members AS M
//                            ON (M.id = t.buyer_id)
//                        JOIN categories
//                          ON offers.category_id = categories.id
//                        JOIN types
//                          ON categories.type_id = types.id
//                        WHERE
//                            t.seller_id = $id");
        $bought = $this->db->fetch();
        return empty($bought) ? NULL : $bought;
    }

    public function getBoughtTransactionByMemberId($id){
      $this->db->query("SELECT t.id, t.transact_date, t.offer_id, t.seller_id, O.title, O.description, O.price, M.username
                        FROM transacts t
                        INNER JOIN offers AS O
                            ON (t.offer_id = O.id)
                        INNER JOIN members AS M 
                            ON (M.id = t.seller_id)
                        WHERE
                            t.buyer_id = $id");
      $sold = $this->db->fetch(MYSQL_ASSOC);
      return $sold;
    }

    public function getTransactionByOfferId($id){
      $this->db->query("SELECT *
                        FROM transacts t
                        WHERE
                            t.offer_id = $id");
      $sold = $this->db->fetch(MYSQL_ASSOC);
      return $sold;
    }

    public function getTransactionById($id){
      $this->db->query("SELECT *
                        FROM transacts t
                        WHERE
                            t.id = $id");
      $result = $this->db->fetch(MYSQL_ASSOC);
      return $result;
    }
}
?>