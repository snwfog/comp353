<?
include 'upload.php';

if (isset($_POST['description']) && issset($_POST['price']))
{	
	$description=$_POST['description'];
	$price=$_POST['price'];

	if(!empty($description) && !empty($price))
	{
			//fill in 
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
			<input type="file" name="file"><br><br>
			</form>
	<input type="submit" value="Submit">
	
</form>