<?php

class Search_Controller extends Controller implements IRedirectable
{
    protected $data = null;
    public function __construct(array $args)
    {
       parent::__construct(FALSE);
       $categoryModel = new Category_Model();
       $categories = $categoryModel->getAllCategories();
       $this->data["categories"] = $categories;

       if(isset($_POST["search_form"])){
           $this->DisplayFilteredOffer($_POST["type"], $_POST["category"], $_POST["price_range"]);
       }elseif(isset($args["category_id"])){
           $this->DisplayFilteredOffer(NULL, $args["category_id"], NULL);
       }elseif(isset($args["type_name"])){
           $this->DisplayFilteredOffer($args["type_name"], NULL, NULL);
       }else{
           $this->display("search.twig", $this->data);
       }
    }
    
    public function DisplayFilteredOffer($type_name, $category_id, $price_range){
       $offerModel = new Offer_Model();
       $offers = $offerModel->FilterActiveOffer($type_name, $category_id, $price_range);
       $this->data["offers"] = $offers;
       $this->display("search.twig", $this->data);
    }
}
