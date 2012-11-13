<?php
$error = $_FILES['file']['error'];

?>
<form action= "upload.php" method="POST" enctype="multipart/form-data">
	<input type="file" name="file"><br><br>
	<input type="submit" value="Submit">
</form>
