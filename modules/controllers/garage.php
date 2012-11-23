<?php

class Garage_Controller extends Controller implements IRedirectable
{
    public function __construct()
    {
        parent::__construct();

        // Double security check for user is admin
        // The constructor checks only for signin and member
        if ($this->isAdmin())
        {
            $this->m_storages = new Storage_Model();
            $this->data['storages'] = $this->m_storages->getAllActiveStorageItems();
            $this->display('garage.twig', $this->data);
        }
    }

}
