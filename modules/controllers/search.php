<?php

class Search_Controller extends Controller implements IRedirectable
{
    protected $data = null;
    public function __construct(array $args)
    {
       //parent::__construct();
       $categoryModel = new Category_Model();
       $categories = $categoryModel->getAllCategories();
       $this->data["categories"] = $categories;
       if(isset($_POST["search_form"])){
            $offerModel = new Offer_Model();
            $offers = $offerModel->FilterActiveOffer($_POST["type"], $_POST["category"], $_POST["price_range"]);
            $this->data["offers"] = $offers;
            $this->display("search.twig", $this->data);
       }else{
         $this->display("search.twig", $this->data);
       }
    }
}
