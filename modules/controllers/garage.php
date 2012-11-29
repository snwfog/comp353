<?php

class Garage_Controller extends Controller implements IRedirectable
{
    public function __construct(array $args)
    {
        parent::__construct();

        $this->data["title"] = "Garage";
        $this->data["specifier"] = "Admin";
        // Double security check for user is admin
        // The constructor checks only for signin and member
        if ($this->isAdmin())
        {
            $this->m_storages = new Storage_Model();

            if (isset($args['pickup']) && $args['pickup'])
            {
                $this->m_storages->pickup($args['pickup']);
                $this->back();
            }
            if (isset($args['receive']) && $args['receive'])
            {
                if(isset($_POST["volume"]) AND isset($_POST["weight"]) AND $_POST["volume"] !== "" AND $_POST["weight"] !== "" ){
                    $this->m_storages->receive($args['receive'], $_POST["volume"], $_POST["weight"]);   
                }
                //$this->back();
            }

            $this->data['storages'] = $this->m_storages->getAllActiveStorageItems();


            $this->display('garage.twig', $this->data);
        }
    }
}
