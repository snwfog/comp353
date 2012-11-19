<?php

class Transact_Model extends Model
{
    protected $db;
    public function __construct()
    {
        parent::__construct();
    }
    
    public function createTransaction($offer_id, $buyer_id, $seller_id){
      $attribute = array("offer_id, buyer_id, seller_id, transact_date");
      $value = array($offer_id, $buyer_id, $seller_id, date("Y-n-d"));
      return $this->setRowAndGetId($value, $attribute, "transacts");
    }

    public function getSoldTransactionByMemberId($id){
      $this->db->query("SELECT t.id, t.offer_id, t.buyer_id, O.title, O.description, O.price, M.username
                        FROM transacts T
                        INNER JOIN offers AS O 
                            ON (T.offer_id = O.id)
                        INNER JOIN members AS M 
                            ON (M.id = T.buyer_id)
                        WHERE
                            t.seller_id = $id");
      $bought = $this->db->fetch(MYSQL_ASSOC);
      return $bought;
    }

    public function getBoughtTransactionByMemberId($id){
      $this->db->query("SELECT t.id, t.offer_id, t.seller_id, O.title, O.description, O.price, M.username
                        FROM transacts T
                        INNER JOIN offers AS O
                            ON (T.offer_id = O.id)
                        INNER JOIN members AS M 
                            ON (M.id = T.seller_id)
                        WHERE
                            t.buyer_id = $id");
      $sold = $this->db->fetch(MYSQL_ASSOC);
      return $sold;
    }

    public function getTransactionByOfferId($id){
      $this->db->query("SELECT *
                        FROM transacts T
                        WHERE
                            t.offer_id = $id");
      $sold = $this->db->fetch(MYSQL_ASSOC);
      return $sold;
    }

}
?>