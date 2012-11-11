<?php

abstract class View
{
    public function display($file, $data)
    {
        Renderer::getInstance()->display($file, $data);
    }
}
