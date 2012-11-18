<?php

class Member_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {

        define("VIEW_MODE_PRIVATE", 1); // Member's own view mode
        define("VIEW_MODE_PUBLIC", 0);  // Somebody's else is viewing

        // Check for login and session
        parent::__construct();

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
        }

        $m_email = new Email_Model;
        $email = $m_email->getEmailById($this->getMemberId());

        $avatar = new Avatar_Model;
        $avatar_url = $avatar->getGravatarURL($email);

        $m_post = new Post_Model();
        $offers = $m_post->getPostByMemberId($this->id);

        $this->getFeedback();

        $this->data["username"]= "Charles";
        $this->data["title"]= "Member";
        $this->data["specifier"]= "Charles";
        $this->data["offers"] = $offers;
        $this->data["avatar_url"] = "$avatar_url";
        $this->data["id"] = $this->id;

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
        $this->data["avg_rating"] = $m_feedback->getRating($this->id);
    }
}
