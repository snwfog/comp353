<?php

abstract class View
{
    public function render($file, $data)
    {
        echo Renderer::getInstance()->render($file, $data);
    }
}
