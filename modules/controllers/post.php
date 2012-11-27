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
            $data['image_url'] = $this->handleImage();

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

            // Move image to destination folder
            if (!move_uploaded_file($_FILES['image']['tmp_name'],
                IMAGE_PATH . $data["image_url"]))
                echo "Error upload";

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

    private function handleImage()
    {
        $allowedFiletypes = array('jpg', 'png', 'jpeg');
        $maxFilesize = 524288;
        $filename = $_FILES['image']['name'];

        if (!empty($filename))
        {
            list($name, $ext) = explode(".", $filename);

            if (!in_array($ext, $allowedFiletypes))
                die('The file you attempted to ulpload is not allowed.');
            if (filesize($_FILES['image']['tmp_name']) > $maxFilesize)
                die('The file you attempted to upload is too large.');
            if (!is_writeable(IMAGE_PATH))
                die('You cannot upload to the specified directory.');

            $safeName = hash('sha256', $name + date('l jS \of F Y h:i:s A'));
            return $safeName . "." . $ext;
        }

        return NULL;
    }
}