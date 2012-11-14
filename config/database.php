<?php
/**-----------------------------------------------------------------------------
 * Database singleton class.
 * This class should be used when accessing database in object's models.
 *
 *                                ~ ~ ~ ~
 *                THE VARIABLE $dbconfig MUST BE MODIFIED
 *                      TO WORK IN ANOTHER SERVER
 *                                ~ ~ ~ ~
 *
 *
 * -----------------------------------------------------------------------------
 */
class Database
{
	/**-------------------------------------------------------------------------
	 * Database configuration variables.
	 * Replace with appropriate database information during deployment or
	 * during testing.
	 * -------------------------------------------------------------------------
	 */
	private static $dbconfig = array
	(
		'host' 	=> 'localhost',
		'user' 	=> 'root',
		'pass' 	=> 'root',
		'database' => 'comp353'
	);


	/**-------------------------------------------------------------------------
	 * END OF DATABASE CONFIGURATION
     * -------------------------------------------------------------------------
	 */
	private static $dbInstance;

	private function __construct() {
        $this->mysqli = new mysqli
        (
            self::$dbconfig['host'],
            self::$dbconfig['user'],
            self::$dbconfig['pass'],
            self::$dbconfig['database']
        );


        if (mysqli_connect_errno())
        {
            printf("<p>Database connection failed: %s</p>", mysqli_connect_error());
            exit;
        }
    }

    /**
     * Singleton pattern.
     *
     * @return Database
     */
    public static function getInstance()
	{
		if (!isset(self::$dbInstance))
			self::$dbInstance = new Database;

		return self::$dbInstance;
	}

    /**
     * Return mysqli instance in case we really need to do some fancy stuffs.
     * @return Database|mysqli
     */
    public static function getMysqliInstance()
    {
        return isset($this->mysqli) ? $this->mysqli : $this->getInstance();
    }

    /**
     * Execute the sql statement. The statement is escaped.
     *
     * @param $sql
     * @return bool|mysqli_result
     */
    public function query($sql)
    {
        $this->sql = $this->mysqli->real_escape_string($sql);
        $this->result = $this->mysqli->query($sql);

        if (!$this->result)
        {
            printf("<p>Error(%d): %s. The problem is caused by this query: %s</p>",
                    $this->mysqli->errno, $this->mysqli->error, $this->sql);
            return FALSE;
        }

        return $this->result;
    }

    /**
     * A helper method to get the data from sql result. Similar to a database
     * query of "SELECT $select" from a bunch of result in the form of an
     * array.
     *
     * Usage:
     *
     * $db->query($statement);
     * $db->selectField($name);
     *
     * @param null $select
     * @param int $fetchMode
     * @return array
     */
    public function selectField($select = NULL, $fetchMode = MYSQL_BOTH)
    {
        if ($select)
        {
            $row = $this->result->fetch_array($fetchMode);
            $data = $row[$select];
        }
        else
        {
            $data = array();

            while ($row = $this->result->fetch_array($fetchMode))
                $data[] = $row;
        }

        $this->result->close();

        return $data;
    }

    /**
     * Get the id of the last inserted query from "INSERT INTO...".
     * @return mixed
     */
    public function getLastInsertId()
    {
        return $this->mysqli->insert_id;
    }

    /**
     * Return mysqli error if there is any.
     * @return string
     */
    public function getErrorString()
    {
        return isset($this->mysqli->error) ? $this->mysqli->error : "" ;
    }

    /**
     * Return mysqli errno if there is any.
     * @return int
     */
    public function getErrorId()
    {
        return isset($this->mysqli->errno) ? $this->mysqli->errno : 0;
    }

    public function __destruct()
    {
        $this->mysqli->close();
    }

}