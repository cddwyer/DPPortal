 <?php
$servername = "localhost";
$username = "dpportaluser";
$password = "GREGWALLACE";
$dbname = "dpportal";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

echo "Connection Successful";

?> 