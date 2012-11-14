<?php

class Member_Controller extends Controller implements IRedirectable
{
    public function __construct()
    {
        // Check for login and session
        // parent::__construct();

        $e = "donchoa@gmail.com";

        $email = new Email_Model;
//        $email_id = $email->getIdByEmail($e);
//        if (empty($email_id))
//        {
//            $email_id = $email->setEmailAndGetId($e, 2);
//            if (!$email_id)
//                echo "Your email has serious problem";
//
//        }
//
//        // Try to restitch the email
//        $restitched = $email->getEmailById($email_id);
//
//        $avatar = new Avatar_Model;
//        $avatar_url = $avatar->getGravatarURL($restitched);
//
//        $data = array
//        (
//            "username" => "Charles",
//            "avatar_url" => $avatar_url
//        );
//
//        $this->display("member.twig", $data);
    }

}
