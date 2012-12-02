<?php

class Post_Controller extends Controller implements IRedirectable
{
	public function __construct(array $args)
	{
		parent::__construct();

        // Modify post
        if (isset($args['modify']) && $args['modify'] &&
            !isset($_POST["submit"]))
        {
            $m_offer = new Offer_Model();
            $offer = $m_offer->getOffer($args['modify']);
            $this->data["offerId"] = $offer["id"];
            $this->data["offerTitle"] = $offer["title"];
            $this->data["offerPrice"] = $offer["price"];
            $this->data["offerDescription"] = $offer["description"];
            $this->data["offerType"] = $offer["type"];
            $this->data["offerCategory"] = $offer["category"];

            $categories = new Category_Model();
            $cat = $categories->getAllCategories();

            $this->data["categories"] = $cat;
            $this->display("post.twig", $this->data);
        }
        else if (isset($args['modify']) && $args['modify'] &&
            isset($_POST["submit"]) && $_POST["submit"])
        {
            $data["title"] = $_POST["title"];
            $data["category"] = $_POST["category"];
            $data["price"] = $_POST["price"];
            $data["description"] = $_POST["description"];
            $data["image_url"] = $this->handleImage();

            $m_offer = new Offer_Model();

            $m_offer->updateOffer($data, $args["modify"]);

            $this->redirect("index.php?offer&id=".$args["modify"]);
        }
        else if (isset($_POST["submit"]) && $_POST["submit"] == "TRUE")
		{
            // Post a new post
			$data = array();

			$data["title"] = $_POST["title"];
			$data["category_id"] = $_POST["category"];
			$data["price"] = $_POST["price"];
			$data["description"] = $_POST["description"];
            $data["image_url"] = $this->handleImage();

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
				$this->redirect("index.php?offer&id=".$offer_id);
		}
		else
		{
            // Display empty form
			$categories = new Category_Model();
			$cat = $categories->getAllCategories();

			$this->data["categories"] = $cat;
			$this->display("post.twig", $this->data);
		}
	}

    private function handleImage()
    {
        $allowedFiletypes = array('jpg', 'png', 'jpeg');
        $maxFilesize = 524288;
        $filename = $_FILES['image']['name'];

        if (!empty($filename))
        {
            list($name, $ext) = explode(".", $filename);

            if (!preg_grep("/$ext/i" , $allowedFiletypes))
                die('The file you attempted to ulpload is not allowed.');
            if (filesize($_FILES['image']['tmp_name']) > $maxFilesize)
                die('The file you attempted to upload is too large.');
            if (!is_writeable(IMAGE_PATH))
                die('You cannot upload to the specified directory.');

            $safeName = hash('sha256', $name + date('l jS \of F Y h:i:s A') + rand());

            // Move image to destination folder
            if (!move_uploaded_file($_FILES['image']['tmp_name'],
                IMAGE_PATH . $safeName . "." . $ext))
                echo "Error upload image. (post.php)";

            $this->data["image_url"] = $safeName . "." . $ext;

            return $this->data["image_url"];
        }

        return "";
    }
}