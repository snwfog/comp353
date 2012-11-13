<?

if (isset($_POST['first_name']) && issset($_POST['last_name']) && isset($_POST['email'] && isset($_POST['text'])))
	
	$first_name=$_POST['first_name'];
	$last_name=$_POST['last_name'];
	$email=$_POST['email'];
	$text=$_POST['text'];
	
	if(!empty($first_name) && !empty($last_name) && !empty($email) && !empty($text))
	{
		//fill this	(put seller_id.email)
		//$to =  ;
		$subject = 'Seller contact form';
		$body = $first_name. $last_name. "\n". $text;
		$headers = 'From: '.$email;
	
		if(@mail($to, $ubject, $body, $headers))
		{
			echo 'Thanks for contacting buyer.';
		}  
		else
		{
			echo 'Sorry, an error occurred. Please try again later.';
		}
	}
	else
	{
		echo 'All fields are required.';
	}
 
?>

<form action="contact_form.php" method="POST">
	FirstName:<br><input type="text" name="first_name" id="first_name"><br><br>
	LastName:<br><input type="text" name="last_name" id="last_name"><br><br>
	Email:<br><input type="text" name="email" id="email"><br><br>
	Message:<br>
	<textarea name="text" rows="6" cols="30"></textarea><br><br>
	<input type="submit" value="Send">

</form>