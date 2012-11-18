<?php

class Post_Model extends Model
{
	public function __construct()
	{
		parent::__construct();
	}

	public function setPost($member_id, $offer_id)
	{
		$value = array($member_id, $offer_id);
		$attribute = array("member_id", "offer_id");
		$table = "posts";

		return parent::setRowAndGetId($value, $attribute, $table);
	}
}