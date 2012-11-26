<?php

class Reserve_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function create_reserve($visitor_id, $offer_id){
        $date_time = "\"". date("Y-m-d H:i:s") . "\"";
        $query = "INSERT INTO reserves (visitor_id, offer_id, reserve_time)
            VALUES ('$visitor_id', '$offer_id', '$date_time')";
        if($this->db->getErrorId()){
            return;
        }
    }
    
    public function get_all_reserves($offer_id){
      $query = "SELECT *
                FROM reserves AS r
                INNER JOIN visitors AS v ON r.visitor_id = v.id
                WHERE r.offer_id = $offer_id
                ORDER BY  `r`.`reserve_time` ASC;";
      $this->db->query($query);
      $result = $this->db->fetch(MYSQL_ASSOC);
      return $result? $result : NULL;
   }
}
