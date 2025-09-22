```php
<?php
header('Content-Type: application/json');

// Database connection configuration
$host = 'localhost';
$dbname = 'login_tracker';
$username = 'root';
$password = '';

try {
    // Create PDO connection
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Query to get the latest login data
    $stmt = $pdo->query("SELECT service, username, password, DATE_FORMAT(timestamp, '%Y-%m-%d %H:%i:%s') as timestamp FROM logins ORDER BY timestamp DESC LIMIT 50");
    $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Return JSON response
    echo json_encode($data);

} catch (PDOException $e) {
    // Handle database errors
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
}
?>
```