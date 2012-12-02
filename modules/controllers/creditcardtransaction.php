<?php
class CreditCardTransaction_Controller extends Controller implements IRedirectable{
	protected $data;
	public function __construct(){
		parent::__construct();
		$m_CCT = new CreditCardTransaction_Model();
		$AllTransaction = $m_CCT->getAllTransactionByMemberId($this->getMemberId());

        $sorted = array();
        // Format the data into date arrays
        if(count($AllTransaction)>0){
            foreach ($AllTransaction as $value)
            {
                $sorted[$value['fee_date_month']." ".$value['fee_date_year']][] = $value;
            }

            $this->data["transactions"] = $sorted;
        }  


        $this->display("creditcardtransaction.twig", $this->data);
	}
}
?>