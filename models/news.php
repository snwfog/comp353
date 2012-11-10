<?php

class News_Model
{
    private $articles = array
    (
        'new' => array
        (
            'title' => 'New Website',
            'content' => 'Welcome to the site! We are glad to have you here'
        ),

        'mvc' => array
        (
            'title' => 'PHP MVC Frameworks',
            'content' => 'It really is very easy, take it from us'
        ),

        'test' => array
        (
            'title' => 'Testing',
            'content' => 'Testing content here bla bla bla'
        )

    );

    public function __construct() { }

    public function getArticles($articleName)
    {
        $article = $this->articles[$articleName];
        return $article;
    }
}
