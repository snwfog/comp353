<?php

class Admin_Controller extends Controller implements IRedirectable
{
    public function __construct()
    {
        parent::__construct();

        // Extra security for admin check
        if ($this->isAdmin())
        {
            $this->display('admin.twig', $this->data);
        }
        else
        {
            $this->redirect($this::REDIRECT_INDEX);
        }
    }


}
