<?php

class Ajax_Controller extends Controller
{
    public function __construct(array $args)
    {
        parent::__construct();

        // Check for what type of ajax function we are calling
        if (isset($args['notify_bid']))
            $this->_notifyBids();

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

        if (isset($args['warn']))
            $this->notifyWarn();

        return false;
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
