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

    public function getAllTransactionByMemberId($member_id){
        $query = "SELECT 
                    CCT.amount  as charge,
                    CCT.description as charge_description,
                    CCT.fee_type,
                    date_format(CCT.date, '%d') AS fee_date_date,
                    date_format(CCT.date, '%M') as fee_date_month,
                    date_format(CCT.date, '%Y') AS fee_date_year,
                    CC.number as cc_number,
                    CC.holder_name as cc_name,
                    T.type as cc_type,
                    O.title,
                    O.description,
                    O.price,
                    O.id AS offer_id
                  From credit_card_transactions AS CCT
                  INNER JOIN  credit_cards as CC ON CCT.credit_card_id = CC.id
                  INNER JOIN offers as O ON CCT.offer_id = O.id
                  INNER JOIN credit_card_types AS T ON CC.credit_card_type_id = T.id
                  WHERE CC.member_id = '$member_id'
                  ORDER BY fee_date_year DESC, fee_date_month DESC, fee_date_date DESC";
        $result = $this->db->query($query);
        $result = $this->db->fetch(MYSQL_ASSOC);
        return $result ? $result : NULL;
    }
  
}

?>