<?php

/* main_login.html */
class __TwigTemplate_8f9dbf65d27ae7a1746416cc21a505cb extends Twig_Template
{
    public function __construct(Twig_Environment $env)
    {
        parent::__construct($env);

        $this->parent = false;

        $this->blocks = array(
        );
    }

    protected function doDisplay(array $context, array $blocks = array())
    {
        // line 1
        echo "<table width=\"300\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"1\" bgcolor=\"#CCCCCC\">
\t<tr>
\t\t<form name=\"form1\" method=\"post\" action=\"check_login.php\">
\t\t\t<td>
\t\t\t\t<table width=\"100%\" border=\"0\" cellpadding=\"3\" cellspacing=\"1\" bgcolor=\"#FFFFFF\">
\t\t\t\t\t<tr>
\t\t\t\t\t\t\t<td colspan=\"3\"><strong>Member Login </strong></td>
\t\t\t\t\t</tr>
\t\t\t\t\t<tr>
\t\t\t\t\t\t<td width=\"78\">Username</td>
\t\t\t\t\t\t<td width=\"6\">:</td>
\t\t\t\t\t\t<td width=\"294\"><input name=\"myusername\" type=\"text\" id=\"myusername\"></td>
\t\t\t\t\t</tr>
\t\t\t\t\t<tr>
\t\t\t\t\t\t<td>Password</td>
\t\t\t\t\t\t<td>:</td>
\t\t\t\t\t\t<td><input name=\"mypassword\" type=\"password\" id=\"mypassword\"></td>
\t\t\t\t\t</tr>
\t\t\t\t\t<tr>
\t\t\t\t\t\t<td>&nbsp;</td>
\t\t\t\t\t\t<td>&nbsp;</td>
\t\t\t\t\t\t<td><input type=\"submit\" name=\"Submit\" value=\"Login\"></td>
\t\t\t\t\t</tr>
\t\t\t\t</table>
\t\t\t</td>
\t\t</form>
\t</tr>
</table>";
    }

    public function getTemplateName()
    {
        return "main_login.html";
    }

    public function getDebugInfo()
    {
        return array (  17 => 1,);
    }
}
