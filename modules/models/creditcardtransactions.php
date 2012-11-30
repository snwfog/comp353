<?php 

class CreditCardTransaction_Model extends Model
{

  	protected $db;

    public function __construct()
    {
        parent::__construct();

    }

    public function transact_offer_fee($credit_card_id, $offer_id, $bid_id){
    	if($this->db->query("SELECT * FROM prices WHERE fee_name = \"service\" ")){
        	$plan = $this->db->fetch(MYSQL_ASSOC);
        	$plan = $plan[0];
        }
    	$m_offer = new offer_model();
    	$m_bid = new Bid_model();
    	$the_offer = $m_offer->getOffer($offer_id);
    	$the_bid = $m_bid->getBidById($bid_id);
    	$charge = (float)$the_bid[0]["price"] * (float)$plan['amount'];
    	$description = "\"This is a service charge for offer, ". $the_offer['title'].", at the price of ".$the_bid[0]["price"]."\$\"";
    	$query = "INSERT INTO credit_card_transactions (credit_card_id, offer_id, amount, description, fee_type) 
    		      VALUES ($credit_card_id, $offer_id, $charge, $description, \"service\")";
    	$this->db->query($query);
    } 

    public function transact_storage_fee($credit_card_id, $offer_id, $storage_id){
       $theplan = array();
       if($this->db->query("SELECT * FROM prices")){
            $plans = $this->db->fetch(MYSQL_ASSOC);
            foreach($plans as $plan){
                $theplan[$plan["fee_name"]] = $plan["amount"];
            }
        }
        $m_storage = new Storage_Model();
        $storageItem = $m_storage->getStorage($storage_id);
        $storageItem = $storageItem[0];

        $m_offer = new offer_model();
        $the_offer = $m_offer->getOffer($offer_id);

        $charge = (int)$theplan["weight_".$storageItem["weight"]] + (int)$theplan["volume_".$storageItem["volume"]] + (int)$theplan["base_storage"];
        $description = "\"This is a storage charge for offer, ". $the_offer['title'].".\"";

        $query = "INSERT INTO credit_card_transactions (credit_card_id, offer_id, amount, description, fee_type) 
                  VALUES ($credit_card_id, $offer_id, $charge, $description, \"storage\")";
        $this->db->query($query);
    }   
}

?>