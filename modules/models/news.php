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

    public function __construct() {

        $dbconfig = array();
        $dbconfig['host'] = 'localhost';
        $dbconfig['user'] = 'root';
        $dbconfig['pass'] = 'root';
        $dbconfig['table'] = 'comp353';


        require_once('libs/mysqli.class.php');
        // Then simply connect to your DB this way:
        $db = new DB($dbconfig);

        // Run a Query:
        $db->query('SELECT * FROM states');

        // Get an array of items:
        $result = $db->get();

        print "<pre>";
        print_r($result);
        print "</pre>";
    }

    public function getArticles($articleName)
    {
        $article = $this->articles[$articleName];
        return $article;
    }
}
