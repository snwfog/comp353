<?php

class Member_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {

        define("VIEW_MODE_PRIVATE", 1); // Member's own view mode
        define("VIEW_MODE_PUBLIC", 0);  // Somebody's else is viewing

        // Check for login and session
        parent::__construct();

        // Load the member model
        $m_member = new Member_Model();

        // Check if we are making any feedbacks
        $this->checkForFeedback();

        if (isset($args['id']) && empty($args['id']))
            $this->redirect(self::REDIRECT_INDEX);

        if (isset($args['id']) && $args['id'] != $this->getMemberId())
        {
            // If id is set, we are looking at somebody
            $this->id = $args['id'];
            $this->data["private"] = VIEW_MODE_PUBLIC;
        }
        else
        {
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
        
        $m_transact = new Transact_Model();
        $boughts = $m_transact->getBoughtTransactionByMemberId($this->getMemberId());
        $solds = $m_transact->getSoldTransactionByMemberId($this->getMemberId());

        $this->getFeedback();
        $this->getOngoingBid();

        $public_info = $m_member->getPublicMemberInfo($this->id);
        $this->data["public_info"] = $public_info;
        $this->data["title"]= "Member";
        $this->data["specifier"]= "Charles";

        $this->data["offers"] = $offers;
        $this->data["avatar_url"] = $avatar_url;
        $this->data["id"] = $this->id;
        $this->data["boughts"]= $boughts;
        $this->data["solds"]= $solds;

        $this->display("member.twig", $this->data);
    }


    private function checkForFeedback()
    {
        if (isset($_POST['feedback']))
        {
            $rater_id = $this->getMemberId();
            $ratee_id = $_POST['ratee_id'];
            $rating = intval($_POST["rating"]);
            $comment = $_POST["comment"];

            $m_feedback = new Feedback_Model();
            $feedback_id = $m_feedback->setFeedback($rater_id, $ratee_id,
                $rating, $comment);
        }
    }

    private function getFeedback()
    {
        $m_feedback = new Feedback_Model();
        $this->data["comments"] = $m_feedback->getFeedback($this->id);
        $this->data["avg_rating"] = intval(round($m_feedback->getRating($this->id)));
    }

    private function getOngoingBid()
    {
        $m_bids = new Bid_Model();
        $this->data["bids"] = $m_bids->getBidByMemberId($this->id);
    }
}
