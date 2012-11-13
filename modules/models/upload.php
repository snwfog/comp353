<?php
$name = $_FILES['file']['name'];
$tmp_name = $_FILES['file']['tmp_name'];

if (isset($name))
{
	if (!empty($name))
	{
		$location = '/assets/img/web/';
		if(move_uploaded_file($tmp_name, $location.$name))
		{
		   echo 'Uploaded';
		}
	}
	else 
	{	 
		echo 'Please choose a file.';
	}
}

$error = $_FILES['file']['error'];

?>
<form action= "upload.php" method="POST" enctype="multipart/form-data">
	<input type="file" name="file"><br><br>
	<input type="submit" value="Submit">
</form>
