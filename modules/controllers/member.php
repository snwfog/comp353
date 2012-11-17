<?php

class Member_Controller extends Controller implements IRedirectable
{
    public function __construct()
    {
        // Check for login and session
        parent::__construct();

        $email = new Email_Model;

	    $restitched = $email->getEmailById($this->getMemberId());
        
        $avatar = new Avatar_Model;
	    $avatar_url = $avatar->getGravatarURL($restitched);

        $data = array
        (
            "username" => "Charles",
            "avatar_url" => $avatar_url
        );

        $this->display("member.twig", $data);
    }

}
