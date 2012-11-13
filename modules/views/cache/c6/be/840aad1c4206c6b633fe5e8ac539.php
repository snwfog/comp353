<?php

/* static/footer.twig */
class __TwigTemplate_c6be840aad1c4206c6b633fe5e8ac539 extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
            'footer' => array($this, 'block_footer'),
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        $this->displayBlock('footer', $context, $blocks);
    }

    public function block_footer($context, array $blocks = array())
    {
        // line 2
        echo "\t<p>You are viewing this page on ";
        echo twig_escape_filter($this->env, twig_date_format_filter($this->env, "now", "D, d M Y H:i:s"), "html", null, true);
        echo ".</p>
\t<p>Copyright 2012 by Team SuperSexyAwesome</p>\t
";
    }

    public function getTemplateName()
    {
        return "static/footer.twig";
    }

    public function getDebugInfo()
    {
        return array (  30 => 5,  28 => 4,  24 => 2,  55 => 15,  47 => 19,  40 => 15,  27 => 7,  25 => 6,  18 => 1,  63 => 12,  53 => 10,  48 => 9,  42 => 16,  37 => 6,  32 => 10,  29 => 4,  26 => 3,);
    }
}
