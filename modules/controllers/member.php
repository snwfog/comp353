<?php

class Member_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        define("VIEW_MODE_PRIVATE", 1); // Member's own view mode
        define("VIEW_MODE_PUBLIC", 0); // Somebody's else is viewing

        // Check for login and session
        parent::__construct();

        // Load the member model
        $m_member = new Member_Model();

        // Check if we are making any feedbacks
        $this->setFeedback();

        // Check delete comment
        if (isset($args['delete_feedback']))
            $this->deleteFeedback($args['delete_feedback']);

        if (isset($args['id']) && empty($args['id']))
            $this->redirect(self::REDIRECT_INDEX);


        $m_transact = new Transact_Model();

        if (isset($args['id']) && $args['id'] != $this->getMemberId()) {
            // If id is set, we are looking at somebody
            $this->id = $args['id'];
            $this->data["private"] = VIEW_MODE_PUBLIC;
            $this->data['has_transact'] = $m_transact->hasTransactedWith($this->getMemberId(), $args['id']);
        } else {
            // If id is not set, we are looking at the owner of the session
            $this->id = $this->getMemberId();
            $this->data["private"] = VIEW_MODE_PRIVATE;
            $this->data["is_owner"] = TRUE;
            $private_info = $m_member->getPrivateMemberInfo($this->id);
            $this->data["private_info"] = $private_info;
        }

        $m_email = new Email_Model;
        $email = $m_email->getEmailById($this->getMemberId());

        $avatar = new Avatar_Model;
        $avatar_url = $avatar->getGravatarURL($email);

        $m_post = new Post_Model();
        $offers = $m_post->getPostByMemberId($this->id);

        //transaction preparing
        $boughts = $m_transact->getBoughtTransactionByMemberId($this->getMemberId());
        $solds = $m_transact->getSoldTransactionByMemberId($this->getMemberId());

        $m_storage = new Storage_Model();

        if (!empty($boughts)) {
            foreach ($boughts as $key => $value) {
                if ($m_storage->in_storage($value["id"])) {
                    if ($m_storage->ready_for_pick_up($value["id"])) {
                        $boughts[$key]["status"] = "Ready for pickup";
                    } else {
                        $boughts[$key]["status"] = "Not yet received";
                    }
                } else {
                    $boughts[$key]["status"] = "n/a";
                }
            }
        }

        if (!empty($solds)) {
            foreach ($solds as $key => $value) {
                if ($m_storage->in_storage($value["id"])) {
                    if ($m_storage->picked_up($value["id"])) {
                        $solds[$key]["status"] = "Completed";
                        $boughts[$key]["status"] = "--";
                    } elseif ($m_storage->ready_for_pick_up($value["id"])) {
                        $boughts[$key]["status"] = "Waiting for pickup";
                    } else {
                        $solds[$key]["status"] = "Pending...";
                    }

                } else {
                    $solds[$key]["status"] = "link";
                }
            }
        }
        //end transaction




        $m_creditcard = new CreditCard_Model();
        $creditcard = $m_creditcard->getMemberCreditCard($this->getMemberId());

        if (isset($creditcard)) {
            $creditcard = $creditcard[0];
            $type_name = $m_creditcard->getCreditCardTypeName($creditcard["credit_card_type_id"]);
            $creditcard["credit_card_type"] = $type_name[0]["type"];
        }

        $this->getFeedback();
        $this->getOngoingBid();

        $public_info = $m_member->getPublicMemberInfo($this->id);
        $this->data["public_info"] = $public_info;
        $this->data["title"] = "Member";
        $this->data["specifier"] = "Charles";

        $this->data["offers"] = $offers;
        $this->data["avatar_url"] = $avatar_url;
        $this->data["id"] = $this->id;
        $this->data["boughts"] = $boughts;
        $this->data["solds"] = $solds;
        $this->data["creditcard"] = $creditcard;
        $this->display("member.twig", $this->data);
    }


    private function setFeedback()
    {
        if (isset($_POST['feedback'])) {
            $rater_id = $this->getMemberId();
            $ratee_id = $_POST['ratee_id'];
            $rating = intval($_POST["rating"]);
            $comment = $_POST["comment"];

            $m_feedback = new Feedback_Model();
            $feedback_id = $m_feedback->setFeedback($rater_id, $ratee_id, $rating, $comment);
        }
    }

    private function getFeedback()
    {
        $m_feedback = new Feedback_Model();
        $this->data["comments"] = $m_feedback->getFeedback($this->id);
        $this->data["avg_rating"] = intval($m_feedback->getRating($this->id));
    }

    private function getOngoingBid()
    {
        $m_bids = new Bid_Model();
        $this->data["bids"] = $m_bids->getOngoingBidByMemberId($this->id);
    }

    private function deleteFeedback($feedback_id)
    {
        if ($this->isAdmin()) {
            $this->m_feedbacks = new Feedback_Model();
            $this->m_feedbacks->deleteFeedback($feedback_id);
            $this->back();
        }
    }
}
