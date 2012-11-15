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
            $data = array
            (
                "title" => "Auction Max",
                "specifier" => "Visitor"
            );

            $this->display('index.twig', $data);
        }
    }
}
