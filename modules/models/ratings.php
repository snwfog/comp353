<?php

class Rating_Model
{
	public function __construct()
	{
		parent::__construct();
	}

	public function getRating($member_id)
	{
		$select = "rating";
		$where = "member_id";
		$what = $member_id;
		$table = "ratings";

		$rating = $this->getColumn($select, $where, $what, $table);

	}
}