<?php

class News_Controller
{
	public $template = 'news';

	public function main(array $getVars)
	{
		$newModel = new News_Model;

        $article = $newModel->getArticles($getVars['article']);

        //$view = new View_Model($this->template);

        //$view->assign('title', $article['title']);
        //$view->assign('content', $article['content']);

        echo Renderer::getInstance()->render()

    }
}