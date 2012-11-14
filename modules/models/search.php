<?
	if (isset($_POST['description']))
	{
		$description = $_POST['description'];
		if (!empty($description))
		{
		   $query = "SELECT 'description' FROM 'offers' WHERE 'description' LIKE '%".mysql_real_escape_string($description)."%'";
		   $query_run = mysql_query($query);
		   
		   if (mysql_num_rows($query_num_rows)>=1)
		   {
				echo $query_num_rows.' results found: <br>';
				while($query_row=mysql_fetch_assoc($query_run))
				{
					echo $query_row['description'].'<br>';
				}
		   } 
		   else
		   {
				echo 'No results found.';
		   }
		   
		}
	}

?>

<form action = "search.php" method="POST">
	Search: <input type="text" name="description" id="description"> <input type="submit" value="Go">
</form>