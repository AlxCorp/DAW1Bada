<?php
$servername = "database-1.cq5joh1r47jb.us-east-1.rds.amazonaws.com";
$username = "admin";
$password = "Root1234$";
$bd="biblioteca";
// Create connection
$conn = new mysqli($servername, $username, $password,$bd);

// Check connection
if ($conn->connect_error) {
    die("Conexión falla " . $conn->connect_error);
}
echo "Conexión exitosa";

?>