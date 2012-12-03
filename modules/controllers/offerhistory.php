<?php

class OfferHistory_Controller extends Controller Implements IRedirectable
{
    public function __construct($args)
    {
        parent::__construct();

        $m_offers = new Offer_Model();
		
		if (isset($args['id']))
        	$this->data['offers'] = $m_offers->getExpireOfferByMember($args['id']);
				
        $this->display('offer-history.twig', $this->data);
    }
}
