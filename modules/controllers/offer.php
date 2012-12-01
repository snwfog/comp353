<?php

class Offer_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        // Commenting this code will disable login check
        parent::__construct(FALSE);

        // Check if the offer id is set
        $m_offer = new Offer_Model();

        // Check if we are giving a warning
        if (isset($args['warn']))
        {
            $this->warn($args['warn']);
            $this->back();
        }
        else if (isset($args['id']))
        {
            $this->offer = $m_offer->getOffer($args['id']);

            if ($this->offer)
            {

                // There is such an offer.. okay
                // Hold on tho, are we making a bid?
                // Process the bid first before displaying the offer
                if (isset($_POST["bid"]))
                {
                    $this->makeBid();
                    $this->back();
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

                // Get owner transaction
                $m_transact = new Transact_Model();
                $transact = $m_transact->getTransactionByOfferId($args['id']);
                if( $transact ){
                  $this->data["transact"] = $transact[0];
                  $this->data["CanStore"] = $this->canStoreOffer($transact[0]);
                }

                //Can bid? Can Reserve?
                $this->data["CanBid"] = $this->CanBids();
                $this->data["categories"] = $categories;
                $this->data["CanReserve"] = $this->CanReserve();

                // Check if the current viewer is the offer owner
                // To disallow owner bidding on his own item
                if ($this->getMemberId() == $owner["id"])
                    $this->data["is_owner"] = TRUE;

                // Prepare all the bidding/reserves information for this offer
                $this->getBids($this->offer["id"]);
                $reserves = $this->getReserves($this->offer["id"]);


                $this->display("offer.twig", $this->data);
            }
            else
            {
                $this->redirect(self::REDIRECT_ERROR);
            }
        }
        elseif (isset($args['delete']))
        {
          if($m_offer->deleteOffer($args['delete'])){
            $this->back();
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

    public function warn($offer_id)
    {
        $m_posts = new Post_Model();
        $m_posts->warn($offer_id);
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

    public function CanBids()
    {
        // Check if its a valid session
        if ($this->isValidSession())
        {
            $m_card = new CreditCard_Model();
            $result = $m_card->getMemberCreditCard($this->getMemberId());
            return $result ? TRUE : FALSE;
        }

        return FALSE;
    }

    public function canStoreOffer($transact)
    {
        // Check if its a valid session
        if ($this->isValidSession())
        {
            $m_storage = new Storage_Model();
            $result = $m_storage->in_storage($transact["id"]);
            return $result ? FALSE : TRUE;
        }
        return FALSE;
    }

    public function getReserves($offer_id)
    {
       $m_reserves = new Reserve_Model();
       $result = $m_reserves->get_all_reserves($offer_id);
       $this->data["reserves"] = $result;
    }

    public function CanReserve(){
        
        if ($this->isValidSession())
        {
            $m_Reserve = new Reserve_Model();
            $m_member = new Member_Model();
            $result = $m_Reserve->get_all_active_reserves_by_visitor_id(
                        $m_member->get_visitor_id($this->getMemberId())
                    );
            if(count($result)>=3){
                return FALSE;
            }else{
                return TRUE;
            }          
        }

        return FALSE;
    }
}
