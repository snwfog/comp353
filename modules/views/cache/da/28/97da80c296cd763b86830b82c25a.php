<?php

/* news.twig */
class __TwigTemplate_da2897da80c296cd763b86830b82c25a extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = $this->env->loadTemplate("static/base.twig");

        $this->blocks = array(
            'content' => array($this, 'block_content'),
        );
    }

    protected function doGetParent(array $context)
    {
        return "static/base.twig";
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        $this->parent->display($context, array_merge($this->blocks, $blocks));
    }

    // line 3
    public function block_content($context, array $blocks = array())
    {
        // line 4
        echo "
    <h1>Welcome to my MVC, ";
        // line 5
        if (isset($context["memberName"])) { $_memberName_ = $context["memberName"]; } else { $_memberName_ = null; }
        echo twig_escape_filter($this->env, $_memberName_, "html", null, true);
        echo ".</h1>
    <h4>";
        // line 6
        if (isset($context["title"])) { $_title_ = $context["title"]; } else { $_title_ = null; }
        echo twig_escape_filter($this->env, $_title_, "html", null, true);
        echo "</h4>
    <p>";
        // line 7
        if (isset($context["content"])) { $_content_ = $context["content"]; } else { $_content_ = null; }
        echo twig_escape_filter($this->env, $_content_, "html", null, true);
        echo "</p>

    ";
        // line 9
        if (isset($context["table"])) { $_table_ = $context["table"]; } else { $_table_ = null; }
        $context['_parent'] = (array) $context;
        $context['_seq'] = twig_ensure_traversable($_table_);
        foreach ($context['_seq'] as $context["_key"] => $context["ALLposts"]) {
            // line 10
            echo "        <h2 class=\"mostRecent\">";
            if (isset($context["mostRecent"])) { $_mostRecent_ = $context["mostRecent"]; } else { $_mostRecent_ = null; }
            echo twig_escape_filter($this->env, $_mostRecent_, "html", null, true);
            echo "</h2>
    ";
        }
        $_parent = $context['_parent'];
        unset($context['_seq'], $context['_iterated'], $context['_key'], $context['ALLposts'], $context['_parent'], $context['loop']);
        $context = array_merge($_parent, array_intersect_key($context, $_parent));
        // line 12
        echo "
";
    }

    public function getTemplateName()
    {
        return "news.twig";
    }

    public function isTraitable()
    {
        return false;
    }

    public function getDebugInfo()
    {
        return array (  63 => 12,  53 => 10,  48 => 9,  42 => 7,  37 => 6,  32 => 5,  29 => 4,  26 => 3,);
    }
}
