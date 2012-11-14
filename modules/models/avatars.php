<?php

class Avatar_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getGravatarURL($email, $size = 80,
                                   $default = 'identicon', $rating = 'g')
    {
        $url = 'http://www.gravatar.com/avatar/';
        $url .= md5(strtolower(trim($email)));
        $url .= "?s=$size&d=$default&r=$rating";

        return $url;
    }
}
