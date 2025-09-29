<?php
$servername = "localhost";
$database = "DPPortal";
$username = "dpuser";
$password = "Eggy123";
 
// Create connection
 
// $conn = mysqli_connect($servername, $username, $password, $database);
 
$conn = new mysqli($servername, $username, $password, $database);

 
// Check connection
 
if (!$conn) {
 
    die("Connection failed: " . $conn->connect_error);
 
}

?>