<?php
class CreditCardTransaction_Controller extends Controller implements IRedirectable{
	protected $data;
	public function __construct(){
		parent::__construct();
		$m_CCT = new CreditCardTransaction_Model();
		$AllTransaction = $m_CCT->getAllTransactionByMemberId($this->getMemberId());
		//print_r($AllTransaction);
		$this->data["transactions"] = $AllTransaction;
		$this->display("creditcardtransaction.twig", $this->data);
	}
}
?>