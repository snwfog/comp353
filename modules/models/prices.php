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

    public function get_all_fees(){
      $this->db->query("Select * from prices");
      $plan = $this->db->fetch(MYSQL_ASSOC);
      return $plan? $plan : NULL;  
    }

    public function update_fee($fee_name, $amount){
    $fee_name = "\"". $fee_name . "\"";
      $update = $this->db->query("UPDATE prices SET amount = $amount WHERE fee_name = $fee_name");
      return $update? TRUE : NULL;  
    }


}
?>