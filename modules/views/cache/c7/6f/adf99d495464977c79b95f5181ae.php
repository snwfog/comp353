<?php

/* static/base.twig */
class __TwigTemplate_c76fadf99d495464977c79b95f5181ae extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
            'content' => array($this, 'block_content'),
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<!doctype html>
<html lang=\"en\">
<head>

\t<title>
\t\t";
        // line 6
        $this->env->loadTemplate("static/title.twig")->display($context);
        // line 7
        echo "\t</title>
</head>
<body>
\t<div id=\"header\">";
        // line 10
        $this->env->loadTemplate("static/header.twig")->display($context);
        echo "</div>
    

    <div id=\"content\">

\t\t";
        // line 15
        $this->displayBlock('content', $context, $blocks);
        // line 16
        echo "
\t</div>

    <div id=\"footer\">";
        // line 19
        $this->env->loadTemplate("static/footer.twig")->display($context);
        echo "</div>

</body>
</html>";
    }

    // line 15
    public function block_content($context, array $blocks = array())
    {
    }

    public function getTemplateName()
    {
        return "static/base.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  55 => 15,  47 => 19,  40 => 15,  27 => 7,  25 => 6,  18 => 1,  63 => 12,  53 => 10,  48 => 9,  42 => 16,  37 => 6,  32 => 10,  29 => 4,  26 => 3,);
    }
}
