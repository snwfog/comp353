<?php

/* static/header.twig */
class __TwigTemplate_3e83a537bc23ebe85d496e19ec9131f8 extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
            'header' => array($this, 'block_header'),
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        $this->displayBlock('header', $context, $blocks);
    }

    public function block_header($context, array $blocks = array())
    {
        // line 2
        echo "\t<h1 class=\"title\">Auction Max, Biatch</h1>
\t<form action=\"\">
\t\t<input type=\"text\" name=\"search\" value=\"";
        // line 4
        if (isset($context["search"])) { $_search_ = $context["search"]; } else { $_search_ = null; }
        echo twig_escape_filter($this->env, $_search_, "html", null, true);
        echo "\" />
        <input type=\"submit\" value=\"Search\" />
\t</form>
";
    }

    public function getTemplateName()
    {
        return "static/header.twig";
    }

    public function getDebugInfo()
    {
        return array (  30 => 5,  28 => 4,  24 => 2,  55 => 15,  47 => 19,  40 => 15,  27 => 7,  25 => 6,  18 => 1,  63 => 12,  53 => 10,  48 => 9,  42 => 16,  37 => 6,  32 => 10,  29 => 4,  26 => 3,);
    }
}
