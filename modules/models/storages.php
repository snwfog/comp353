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


}
?>