 <?php
$servername = "127.0.0.1";
$username = "DPDBUSER";
$password = "DPDBPASSWORD";
$dbname = "DPPortal";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

// Check connection state
if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
}

echo "Connection Successful";

?> 
