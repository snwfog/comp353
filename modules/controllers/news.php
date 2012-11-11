<?php

class News_Controller extends View
{
	public $template = 'news';

    public function __construct(array $getVars)
    {
        $newModel = new News_Model;
        // $article = $newModel->getArticles($getVars['article']);

        $member = $newModel->getMemberName($getVars['article']);

        $data = array
        (
            'memberName' => $member['name']

        );

        $this->display("news.twig", $data);
    }
}