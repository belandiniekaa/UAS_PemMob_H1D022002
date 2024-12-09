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

$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['products'])) {
    $products = $data['products'];
    $total_price = 0.0;
    $product_details = [];

    foreach ($products as $product) {
        if (isset($product['name']) && isset($product['price'])) {
            $total_price += $product['price'];
            $product_details[] = $product;
        }
    }

    $query = "INSERT INTO transactions (total_price) VALUES (?)";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("d", $total_price);

    if ($stmt->execute()) {
        $transaction_id = $stmt->insert_id;

        foreach ($product_details as $product) {
            $product_name = $product['name'];
            $product_price = $product['price'];

            $product_query = "INSERT INTO transaction_products (transaction_id, name, price) VALUES (?, ?, ?)";
            $product_stmt = $conn->prepare($product_query);
            $product_stmt->bind_param("isd", $transaction_id, $product_name, $product_price);
            $product_stmt->execute();
        }

        echo json_encode(["status" => "success", "message" => "Transaction added successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to add transaction"]);
    }

    $stmt->close();
} else {
    echo json_encode(["status" => "error", "message" => "No products data received"]);
}

$conn->close();
?>
