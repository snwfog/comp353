<?php

class Post_Controller extends Controller implements IRedirectable
{
	public function __construct()
	{
		parent::__construct();

		if (isset($_POST["submit"]) && $_POST["submit"] == "TRUE")
		{
			$data = array();

			$data["title"] = $_POST["title"];
			$data["category_id"] = $_POST["category"];
			$data["price"] = $_POST["price"];
			$data["description"] = $_POST["description"];
			$data["image_url"] = "NULL";

			$m_offer = new Offer_Model();
			$value = array
			(
				$data["title"], 
				$data["description"], 
				$data["price"],
				$data["category_id"],
				$data["image_url"]
			);

			$attribute = array("title", "description", 
				"price", "category_id", "image_url");
			
			$table = "offers";

			$offer_id = $m_offer->setRowAndGetId($value, $attribute, $table);
			
			// Put a link in the post table
			$m_post = new Post_Model();
			$post_id = $m_post->setPost($this->getMemberId(), $offer_id);

			if ($post_id)
				$this->redirect("index.php?member");
		}
		else
		{
			$categories = new Category_Model();
			$cat = $categories->getAllCategories();

			$this->data["categories"] = $cat;
			$this->display("post.twig", $this->data);
		}
	}
}