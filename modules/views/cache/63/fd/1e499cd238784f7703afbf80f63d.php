<?php

/* registration_form.html */
class __TwigTemplate_63fd1e499cd238784f7703afbf80f63d extends Twig_Template
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
        echo "
<h2>Registration</h2>
<form name=\"registration\" method=\"post\" action=\"index.php?login&controller=&quot;register&quot;\">
\t<p>
\t\tUsername<br/>
\t\t<input name=\"Username\" type=\"text\" id=\"username\">
\t</p>
\t<p>
\t\tPassword<br/>
\t\t<input name=\"Password\" type=\"text\" id=\"password\">
\t</p>
\t<p>
\t\tPhone<br/>
\t\t<input name=\"Phone\" type=\"text\" id=\"phone\">
\t</p>
\t<p>
\t\tEmail<br/>
\t\t<input name=\"Email\" type=\"text\" id=\"email\">
\t</p>\t
\t<p> 
\t\tAddress</br>
\t\t<table border=\"0\">
\t\t<tr>
\t\t  <td>Number</td>
\t\t  <td>Street</td>
\t\t  <td>City</td>
\t\t  <td>Province</td>
\t\t  <td>PCode</td>
\t\t</tr>
\t\t<tr>
\t\t  <td><input name=\"Address\" type=\"text\" id=\"address\"></td>
\t\t  <td><input name=\"City\" type=\"text\" id=\"city\"></td>
\t\t  <td><input name=\"Province\" type=\"text\" id=\"province\"></td>
\t\t  <td><input name=\"Country\" type=\"text\" id=\"country\"></td>
\t\t  <td><input name=\"Postal_code\" type=\"text\" id=\"postal_code\"></td>
\t\t</tr>
\t\t</table>
\t</p>
\t<p>
\t\tCredit Card</br>
\t\t<table border=\"0\">
\t\t<tr>
\t\t\t<td>CardNo</td>
\t\t\t<td>ExpDate</td>
\t\t</tr>
\t\t<tr>
\t\t\t<td><input name=\"CardNo\" type=\"text\" id=\"number\"></td>
\t\t</tr>
\t\t</table>
\t</p>
\t
\t<p>
\t\t<input type=\"submit\" name=\"submit\" value=\"Registration\"/>
\t</p>
</form>
";
    }

    public function getTemplateName()
    {
        return "registration_form.html";
    }

    public function getDebugInfo()
    {
        return array (  17 => 1,);
    }
}
