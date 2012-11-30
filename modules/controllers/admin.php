<?php

class Admin_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        parent::__construct();

        // Extra security for admin check
        if ($this->isAdmin())
        {
            if (isset($args['member_search']))
                $this->display('admin-member-search.twig', $this->data);
            else
                $this->display('admin.twig', $this->data);
        }
        else
        {
            $this->redirect($this::REDIRECT_INDEX);
        }
    }


}
