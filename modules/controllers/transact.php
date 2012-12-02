<?php

class Transact_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        parent::__construct();
        if(isset($args["offer_id"]) && isset($args["bidder_id"])){
            $transactModel = new Transact_Model();
            $offerModel = new Offer_Model();

            $transactModel->createTransaction($args["offer_id"],$args["bidder_id"], $this->getMemberId(), $args["bid_id"]);
            $offerModel->deleteOffer($args["offer_id"]);
            
            //to-do take percentage of the sale from transacted and charge user
            $m_CCT = new CreditCardTransaction_Model();
            $m_CC = new CreditCard_Model();
            $credit_card = $m_CC->getMemberCreditCard($this->getMemberId());
            $m_CCT->transact_offer_fee($credit_card[0]["id"], $args["offer_id"], $args["bid_id"]);

            //transact buyer
            $credit_card = $m_CC->getMemberCreditCard($args["bidder_id"]);
            $m_CCT->transact_offer_fee($credit_card[0]["id"], $args["offer_id"], $args["bid_id"]);
            $this->back();
        }

    }
}
