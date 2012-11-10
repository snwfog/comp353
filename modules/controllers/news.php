<?php

class News_Controller extends View
{
	public $template = 'news';

    public function __construct(array $getVars)
    {
        $newModel = new News_Model;
        $article = $newModel->getArticles($getVars['article']);
        $this->render("news.twig", $article);
    }
}