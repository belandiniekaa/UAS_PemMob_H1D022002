<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');
header('Content-Type: application/json');

$conn = new mysqli("localhost", "root", "", "pos_db");

if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]);
    exit();
}

$data = json_decode(file_get_contents('php://input'), true);

$username = $data['username'] ?? null;
$password = $data['password'] ?? null;

if (!$username || !$password) {
    echo json_encode(["status" => "fail", "message" => "Username and password are required"]);
    exit();
}

$query = "SELECT * FROM users WHERE username=? AND password=?";
$stmt = $conn->prepare($query);
$stmt->bind_param("ss", $username, $password);

if ($stmt->execute()) {
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo json_encode(["status" => "success", "message" => "Login successful"]);
    } else {
        echo json_encode(["status" => "fail", "message" => "Invalid username or password"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Query execution failed"]);
}

$stmt->close();
$conn->close();
?>
