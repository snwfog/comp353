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

            //to-do take percentage of the sale from transacted offers
            $this->back();
        }

    }
}
