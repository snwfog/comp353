<?php

/* static/title.twig */
class __TwigTemplate_13a38e80aeb61b9d083d3290e4177a1d extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
            'title' => array($this, 'block_title'),
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        $this->displayBlock('title', $context, $blocks);
    }

    public function block_title($context, array $blocks = array())
    {
        // line 2
        echo "    ";
        // line 3
        echo "    ";
        // line 4
        echo "    ";
        // line 5
        echo "    ";
        if (isset($context["title"])) { $_title_ = $context["title"]; } else { $_title_ = null; }
        echo twig_escape_filter($this->env, $_title_, "html", null, true);
        echo " - ";
        if (isset($context["specifier"])) { $_specifier_ = $context["specifier"]; } else { $_specifier_ = null; }
        echo twig_escape_filter($this->env, $_specifier_, "html", null, true);
        echo "
";
    }

    public function getTemplateName()
    {
        return "static/title.twig";
    }

    public function getDebugInfo()
    {
        return array (  30 => 5,  28 => 4,  24 => 2,  55 => 15,  47 => 19,  40 => 15,  27 => 7,  25 => 6,  18 => 1,  63 => 12,  53 => 10,  48 => 9,  42 => 16,  37 => 6,  32 => 10,  29 => 4,  26 => 3,);
    }
}
