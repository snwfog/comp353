<?php

class Price_Model extends Model
{
	public function __construct()
    {
        parent::__construct();
    }

    public function get_fee_by_name($fee_name){
    	if($this->db->query("SELECT * FROM prices WHERE fee_name = \"$fee_name\" ")){
        	$plan = $this->db->fetch(MYSQL_ASSOC);
        	if($plan){
                $plan = $plan[0];
            }
        	return $plan;
        }
    }
}
?>