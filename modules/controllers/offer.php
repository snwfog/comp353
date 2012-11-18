<?php

class Offer_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        parent::__construct();


        // Check if the offer id is set
        if (isset($args['id']))
        {

            $m_offer = new Offer_Model();
            $this->offer = $m_offer->getOffer($args['id']);

            if ($this->offer)
            {

                // There is such an offer.. okay
                // Hold on tho, are we making a bid?
                // Process the bid first before displaying the offer
                if (isset($_POST["bid"]))
                {
                    $this->makeBid();
                }

                $this->data["title"] = "Offer";
                $this->data["specifier"] = $this->offer["category"];

                $this->data["offer"] = $this->offer;

                // Get owner of this offer
                $owner = $m_offer->getOwner($args['id']);
                $this->data["owner"] = $owner;

                // Construct the bidding area
                $m_category = new Category_Model();
                $categories = $m_category->getAllCategories();

                $this->data["categories"] = $categories;

                // Check if the current viewer is the offer owner
                // To disallow owner bidding on his own item
                if ($this->getMemberId() == $owner["id"])
//                    $this->data["is_owner"] = TRUE;


                // Prepare all the bidding information for this offer
                $this->getBids($this->offer["id"]);

                $this->display("offer.twig", $this->data);
            }
            else
            {
                $this->redirect(self::REDIRECT_ERROR);
            }
        }
        else
        {
            // Go back to where the user come from
            $this->back();
        }

    }

    public function getBids($offer_id)
    {
        $m_bid = new Bid_Model();
        $bids = $m_bid->getBidByOfferId($offer_id);

        $this->data["bids"] = $bids;
    }


    public function makeBid()
    {
        $this->member_id = $this->getMemberId();
        $this->id = $this->offer["id"];
        $this->category_id = $_POST["category"];
        $this->price = $_POST["price"];
        $this->description = $_POST["description"];

        $m_bid = new Bid_Model();
        $bid_id = $m_bid->setBid(
            $this->member_id,
            $this->id,
            $this->category_id,
            $this->price,
            $this->description
        );

        return $bid_id;
    }
}
