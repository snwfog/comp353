<?php

class Index_Controller extends Controller
{ 
    public function __construct(array $args)
    {
        $this->startSession();

        $this->data["title"] = "Auction Max";

        if ($this->isValidSession())
        {
            $this->data["specifier"] = "Member";
            $this->data["is_logged_in"] = TRUE;

        }
        else
        {
            $this->data["specifier"] = "Visitor";
        }


        $hot_offer_threshold = 7;
        $m_offer = new Offer_Model();
        $this->data["offers"] = $m_offer->getAllActiveOffer();
        $this->data["hot_offers"] = $m_offer->getHotOfferByPrice($hot_offer_threshold);
        $this->data["hot_offer_threshold"] = $hot_offer_threshold;
        $this->data['giveaways'] = $m_offer->getGiveaways();
        $this->display('index.twig', $this->data);
    }
}
