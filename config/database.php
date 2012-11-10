<?php
/**-----------------------------------------------------------------------------
 * Database singleton class.
 * This class should be used when accessing database in object's models.
 *
 *                                ~ ~ ~ ~
 *                THE VARIABLE $dbconfig MUST BE MODIFIED
 *                TO WORK IN ANOTHER PLATFORM OR SYSTEM
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
		'table' => 'comp353'
	);


	/**-------------------------------------------------------------------------
	 * END OF DATABASE CONFIGURATION
     * -------------------------------------------------------------------------
	 */
	private static $dbInstance;

	private function __construct() { }

	public static function getInstance()
	{
		if (!isset(self::$dbInstance))
			self::$dbInstance = new DB(self::$dbconfig);

		return self::$dbInstance;
	}
}