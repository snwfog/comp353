<?
include 'upload.php';

if (isset($_POST['description']) && isset($_POST['price']))
{	
	$description=$_POST['description'];
	$price=$_POST['price'];
	$image=$_POST['image_url'];
	$type=$_POST['type'];



	if(!empty($description) && !empty($price) && !empty($type))
	{
	
		$query = "INSERT INTO 'offers' VALUES('','".mysql_real_escape_string($description)."','".mysql_real_escape_string($price)."','','".mysql_real_escape_string($image)."')";
		
					if ($query_run = mysql_query($query))
					{
						echo 'Your offer has been successfuly posted.';
					}else
					{
						echo 'Sorry, we could not post your offer. Try again later.'; 
    				}

	}else
	{
		echo 'All fields are required.';
	}	

}


?>

<form action = "post_offers.php" method="POST" enctype="multipart/form-data">
	Title: <input type="text" name="title"><br><br>
	Description:<br> 
	<textarea name="description" id="description" rows="6" cols="30"></textarea><br><br>
	Type: <select name="type">
			<option value="goods" id="name"> Goods </option>
			<option value="service" id="name"> Services </option>
			<option value="giveaways" id="name"> Giveaways </option> 
		 </select><br><br>
	Price: <input type="text" name="price" id="price"><br><br>
	Image: <input type="file" name="file" id="image_url"><br><br>
			
	
	<input type="submit" value="Submit">
</form>