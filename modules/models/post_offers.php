<?
include 'upload.php';

if (isset($_POST['description']) && issset($_POST['price']))
{	
	$description=$_POST['description'];
	$price=$_POST['price'];
	$image=$_POST['image_url']

	if(!empty($description) && !empty($price))
	{
	
		$query = "INSERT INTO 'offers' VALUES('','".mysql_real_escape_string($description)."','".mysql_real_escape_string($price)."','','".mysql_real_escape_string($image)."')";
		
					if ($query_run = mysql_query($query))
					{
						echo 'Your offer has been successfuly posted.';
					}else
					{
						echo 'Sorry, we could post your offer. Try again later.'; 
					}
	}else
	{
		echo 'All fields are required.';
	}
	
}	
?>

<form action = "post.php" method="POST">
	Description:<br> 
	<textarea name="description" id="description "rows="6" cols="30"></textarea><br><br>
	Price: <input type="text" name="price" id="price"><br><br>
	Image: <form action= "upload.php" method="POST" enctype="multipart/form-data">
			<input type="image_url" name="image_url" id="image_url"><br><br>
			</form>
	<input type="submit" value="Submit">
	
</form>