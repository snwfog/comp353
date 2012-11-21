<?php

class Storage_Controller extends Controller implements IRedirectable
{
    protected $data;
    public function __construct(array $args)
    {
      $storageModel = new Storage_Model();
      if(isset($args["transaction_id"])){
          if(!$storageModel->in_storage($args["transaction_id"])){
            $storageModel->create_storage($args["transaction_id"]);
            $this->back();
          }else{
            $this->back();
          }
      }


    }
}
