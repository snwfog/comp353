<?php

class Post_Controller extends Controller implements IRedirectable
{
	public function __construct()
	{
		parent::__construct();

		if (isset($_POST["submit"]) && $_POST["submit"] == "TRUE")
		{
			$data = array();
			$this->title = $_POST["title"];
			$this->category_id = $_POST["category"];
			$this->price = $_POST["price"];
			$this->description = $_POST["description"];
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