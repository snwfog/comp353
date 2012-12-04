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
            else if (isset($args['store_variables'])){
                $m_price = new Price_Model();
                if(isset($args['update_variables'])){
                    foreach($_POST as $key => $value){
                        $theFee = $m_price->get_fee_by_name($key);
                        if(!($theFee["amount"] == $value AND $value == NULL)){
                            $m_price->update_fee($key, $value);
                        }
                    }
                }      

                $fees = $m_price->get_all_fees();
                if($fees){
                    $this->data['fees'] = $fees;
                }
                $this->display('admin-variables.twig', $this->data);
            }
            else
                $this->display('admin.twig', $this->data);
        }
        else
        {
            $this->redirect(self::REDIRECT_INDEX);
        }
    }
}
