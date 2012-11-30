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
            else if (isset($args['buys_and_sells']))
                $this->display('admin-buys-and-sells.twig', $this->data);
            else if (isset($args['transactions']))
                $this->display('admin-transactions.twig', $this->data);
            else if (isset($args['categories']))
                $this->display('admin-categories.twig', $this->data);
            else if (isset($args['regions_and_territories']))
                $this->display('admin-regions-and-territories.twig', $this->data);
            else
                $this->display('admin.twig', $this->data);
        }
        else
        {
            $this->redirect($this::REDIRECT_INDEX);
        }
    }


}
