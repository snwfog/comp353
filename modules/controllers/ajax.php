<?php

class Ajax_Controller extends Controller
{
    public function __construct(array $args)
    {
        parent::__construct();

        // Check for what type of ajax function we are calling
        if (isset($args['notify_expired_bids']))
            $this->notifyExpiredBids();

        if (isset($args['is_admin']))
            $this->notifyIsAdmin();

        if (isset($args['notify_receive']))
            $this->notifyReceive();

        if (isset($args['notify_acquire']))
            $this->notifyAcquire();

        return false;
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

        // IMPLEMENT DELETES TABLE ENTRY HERE>>>>>>>>>>>
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
