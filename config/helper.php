<?

/**
 * Bunch of helper functions
 */

class Helper
{
	public static function getIndex($data, $index)
	{
		if (isset($data) && isset($data[$index]))
			return $data[$index];
		else
			return NULL;
	}

    public static function getFirst($data)
    {
        return self::getIndex($data, 0);
    }

    public static function getFirstIndex($data, $index)
    {
        return self::getIndex(self::getFirst($data), $index);
    }
}