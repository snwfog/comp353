<?php

class Member_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {

        define("VIEW_MODE_PRIVATE", 1); // Member's own view mode
        define("VIEW_MODE_PUBLIC", 0);  // Somebody's else is viewing

        // Check for login and session
        parent::__construct();

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

        $email = new Email_Model;

        $restitched = $email->getEmailById($this->getMemberId());

        $avatar = new Avatar_Model;
        $avatar_url = $avatar->getGravatarURL($restitched);

        $m_post = new Post_Model();
        $offers = $m_post->getPostByMemberId($this->getMemberId());

        $this->data["username"]= "Charles";
        $this->data["title"]= "Member";
        $this->data["specifier"]= "Charles";
        $this->data["offers"] = $offers;
        $this->data["avatar_url"] = "$avatar_url";

        $this->display("member.twig", $this->data);
    }

}
