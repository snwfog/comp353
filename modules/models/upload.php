<?php
//$name = $_FILES['file']['name'];
//$tmp_name = $_FILES['file']['tmp_name'];
/*
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
*/
//-------Security-File uploading-----------
if (isset($_FILES['upload'])) 
{

	$allowed_exts = array('jpg','jpeg','png', 'gif');
	$ext = strtolower(substr($_FILES['upload']['name'], strrpos($_FILES['upload']['name'], '.') + 1));
	$errors = array();

	if(in_array($ext, $allowed_exts) == false)
	{
		$errors[] = 'You can upload only images.';
	}

	if($_FILES['upload']['size'] > 10000000)
	{

		$errors[] = 'The file was too big';

	}

	if(empty($errors))
	{
		move_uploaded_file($_FILES['upload']['tmp_name'], "files/{$_FILES['upload']['name']}");
		//to get ONLY the extention of the file uploaded

	}

}



//$error = $_FILES['file']['error'];

?>



<!DOCTYPE html>
<html>


<body>
	<div>
		<?php
			if(isset($errors))
			{
				if(empty($errors))
				{
					echo '<a href="files/', $_FILES['upload']['name'], '" >View Image</a>'; 
				}
				else
				{
					foreach($errors as $error)
					{
						echo $error;
					}
				}
			}
		?>
	</div>

<form action= "" method="POST" enctype="multipart/form-data">
	<input type="file" name="upload"><br><br>
	<input type="submit" value="Upload">
</form>

</body>


</html>