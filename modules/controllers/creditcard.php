<?php

class CreditCard_Controller extends Controller implements IRedirectable
{
    protected $data;
    public function __construct(array $args)
    {
        parent::__construct();
        $this->data["errors"] = array();
        $creditcardModel = new CreditCard_Model();
        $this->data['type'] = $creditcardModel->getCreditCardTypes();
        if (isset($_POST["creditcardform"])) {
            if ($creditcard = $creditcardModel->getMemberCreditCard($this->getMemberId())) {
                $this->checkNumber();
                $creditcardModel->update_credit_card($this->getMemberId(), $_POST['credit_card_type'], $_POST["credit_card_number"], $_POST["expiration_month"] . $_POST["expiration_year"], $_POST["verification_number"], $_POST["card_holder"]);
                header('Location: ' . $_POST["previous_page"]);
            } else {
                $this->checkNumber();
                $creditcardModel->create_credit_card($this->getMemberId(), $_POST['credit_card_type'], $_POST["credit_card_number"], $_POST["expiration_month"] . $_POST["expiration_year"], $_POST["verification_number"], $_POST["card_holder"], $this);
                header('Location: ' . $_POST["previous_page"]);

            }
        } else {
            $this->data["previous_page"] = $_SERVER['HTTP_REFERER'];
            $this->display("creditcard.twig", $this->data);

        }

    }



    public function checkNumber()
    {
        $creditcardModel = new CreditCard_Model();
        if (!$creditcardModel->isUniqueCreditCard($_POST["credit_card_number"], $this->getMemberId())) {
            array_push($this->data["errors"], "Credit Card Exists!");
            $this->display("creditcard.twig", $this->data);
            exit;
        }
    }
}
