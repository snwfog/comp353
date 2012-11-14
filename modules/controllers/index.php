<?php

class Index_Controller extends Controller
{
    public function __construct()
    {
        if (isset($this->session) && $this->session->isLogin)
        {

        }
        else
        {
            $this->display('index.twig');

            $emails = new Email_Model;
            $emails->setEmail("charles@charlescy.com", 3);
        }
    }
}
