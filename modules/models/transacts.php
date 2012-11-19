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
}
?>