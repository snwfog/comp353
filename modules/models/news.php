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

    private $memberName = array();

    public function __construct() {
        // Get a database object
        $db = Database::getInstance();

        $db->query('SELECT name FROM members');

        // Get an array of items:
        $this->memberName = $db->get();

        // print "<pre>";
        // print_r($result);
        // print "</pre>";
    }

    public function getArticles($articleName)
    {
        $article = $this->articles[$articleName];
        return $article;
    }

    public function getMemberName($id)
    {
        return $this->memberName[$id];
    }
}
