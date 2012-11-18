<?php

class Feedback_Model extends Model
{
    public function __construct()
    {
        parent::__construct();
    }

    public function getFeedback($member_id)
    {
         $query = "SELECT
           f.id AS feedback_id,
           m2.id AS ratee_id,
           m2.username AS ratee,
           m1.id AS rater_id,
           m1.username AS rater,
           f.rating AS rating,
           f.comment AS comment
         FROM feedbacks AS f
           INNER JOIN members AS m1 ON m1.id = f.rater_id
           INNER JOIN members AS m2 ON m2.id = f.ratee_id
         WHERE f.ratee_id = $member_id";

        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result;
    }

    public function getRating($member_id)
    {
        $query = "SELECT AVG(f.rating) AS rating
                  FROM feedbacks AS f
                  WHERE f.ratee_id = $member_id";
        $mysqli_result = $this->db->query($query);
        $result = $this->db->fetch(MYSQLI_ASSOC);

        return empty($result) ? NULL : $result[0]["rating"];
    }

    public function setFeedback($rater_id, $ratee_id, $rating, $comments)
    {
        $value = array($rater_id, $ratee_id, $rating, $comments);
        $attribute = array("rater_id", "ratee_id", "rating", "comment");
        $table = "feedbacks";

        return $this->setRowAndGetId($value, $attribute, $table);
    }
}
