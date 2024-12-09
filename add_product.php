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

$name = $_POST['name'];
$price = $_POST['price'];

$query = "INSERT INTO products (name, price) VALUES (?, ?)";
$stmt = $conn->prepare($query);
$stmt->bind_param("sd", $name, $price);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Product added"]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to add product"]);
}

$stmt->close();
$conn->close();
?>
