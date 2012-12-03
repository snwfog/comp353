<?php

class OfferHistory_Controller extends Controller Implements IRedirectable
{
    public function __construct()
    {
        parent::__construct();

        $m_offers = new Offer_Model();

        $this->data['offers'] = $m_offers->getExpireOfferByMember($this->getMemberId());

        $this->display('offer-history.twig', $this->data);
    }
}
