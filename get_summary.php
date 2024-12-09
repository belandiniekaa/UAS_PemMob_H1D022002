<?php
header("Content-Type: application/json");
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

$conn = new mysqli("localhost", "root", "", "pos_db");

if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Connection failed"]);
    exit();
}

$query = "SELECT SUM(total_price) AS total_sales FROM transactions WHERE DATE(created_at) = CURDATE()";
$result = $conn->query($query);
$row = $result->fetch_assoc();
$total_sales = $row['total_sales'] ?? 0;

$query = "SELECT COUNT(*) AS total_transactions FROM transactions WHERE DATE(created_at) = CURDATE()";
$result = $conn->query($query);
$row = $result->fetch_assoc();
$total_transactions = $row['total_transactions'] ?? 0;

echo json_encode([
    "status" => "success",
    "total_sales" => $total_sales,
    "total_transactions" => $total_transactions
]);

$conn->close();
?>
