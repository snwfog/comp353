<?php

class Ajax_Controller extends Controller
{
    public function __construct(array $args)
    {
        parent::__construct();

        // Check for what type of ajax function we are calling
        if (isset($args['notify_bid']))
            $this->_notifyBids();

        if (isset($args['notify_winning_bid']))
            $this->_notifyWinningBid();

        if (isset($args['notify_expired_bids']))
            $this->notifyExpiredBids();

        if (isset($args['is_admin']))
            $this->notifyIsAdmin();

        if (isset($args['notify_receive']))
            $this->notifyReceive();

        if (isset($args['notify_acquire']))
            $this->notifyAcquire();

        if (isset($args['notify_modify']))
            $this->notifyModify();

        if (isset($args['admin_member_search']))
            $this->adminMemberSearch($args);

        if (isset($args['admin_category']))
            $this->_adminCategory($args);

        if (isset($args['admin_transaction']))
            $this->_adminTransaction($args);

        if (isset($args['admin_regions_and_territories']))
            $this->_adminRegion($args);

        if (isset($args['admin_buys_and_sells']))
            $this->_adminBuyAndSell($args);

        if (isset($args['warn']))
            $this->notifyWarn();

        return false;
    }

    private function _adminBuyAndSell($args)
    {
        $json = array();
        $m_creditcardtransactions = new CreditCardTransaction_Model();

        if (isset($args['by_storage']))
            $result = $m_creditcardtransactions->getMonthlyStorageCharges();
        else if (isset($args['by_service']))
            $result = $m_creditcardtransactions->getMonthlyServiceCharges();

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    private function _notifyWinningBid()
    {
        $json = array();
        $this->m_notifications = new Notification_Model();
        $result = $this->m_notifications->getWinningBids($this->getMemberId());

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    private function _adminRegion($args)
    {
        $json = array();
        $m_transact = new Address_Model();

        if (isset($args['by_city']))
            $result = $m_transact->getCityStats();
        else if (isset($args['by_country']))
            $result = $m_transact->getCountryStats();

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    private function _adminTransaction($args)
    {
        $json = array();
        $m_transact = new Transact_Model();

        if (isset($args['by_week']))
            $result = $m_transact->getTransactionStatsByWeek();
        else if (isset($args['by_month']))
            $result = $m_transact->getTransactionStatsByMonth();

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }


    private function _notifyBids()
    {
        $json = array();
        $this->m_notifications = new Notification_Model();
        $result = $this->m_notifications->getNewBids($this->getMemberId());

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    private function notifyWarn()
    {
        $json = array();
        $this->m_notifications = new Notification_Model();
        $result = $this->m_notifications->getWarnings($this->getMemberId());

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }


    private function _adminCategory($args)
    {
        $json = array();
        $m_category = new Category_Model();
        $result = $m_category->getCategoryStats($args);

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    private function adminMemberSearch($args)
    {
        $json = array();
        $this->m_members = new Member_Model();
        $result = $this->m_members->getMemberStatsByName($args);

        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    public function notifyModify()
    {
        $json = array();
        $this->m_notifications = new Notification_Model();
        $result = $this->m_notifications->getModifiedOffers($this->getMemberId());
        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }


    public function notifyExpiredBids()
    {
        $this->m_notifications = new Notification_Model();
        $result = $this->m_notifications->getExpiredBids($this->getMemberId());
        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    public function notifyReceive()
    {
        $json = array();
        $this->m_notifications = new Notification_Model();
        $result = $this->m_notifications->getReceivedOffers($this->getMemberId());
        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }

    public function notifyAcquire()
    {
        $json = array();
        $this->m_notifications = new Notification_Model();
        $result = $this->m_notifications->getAcquireOffers($this->getMemberId());
        print_r($result);
        if (!empty($result))
        {
            $json = array();

            foreach($result as $row)
                $json[] = $row;

            echo json_encode($json);
        }
    }


    public function notifyIsAdmin()
    {
        $json = array();
        if ($this->isAdmin())
        {
            $json['is_admin'] = $this->isAdmin();
            $json['admin_username'] = $this->getUsername();

            echo json_encode($json);
        }

    }






}
