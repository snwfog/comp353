<?php

class Index_Controller extends Controller
{ 
    public function __construct(array $args)
    {
        $this->startSession();

        $this->data["title"] = "Auction Max";

        if ($this->isValidSession())
        {
            $this->data["specifier"] = "Member";
            $this->data["is_logged_in"] = TRUE;
        }
        else
        {
            $this->data["specifier"] = "Visitor";
        }

        $this->display('index.twig', $this->data);
    }
}
