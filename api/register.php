<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    // Check wether email are registered or not yet
    $sql = "SELECT * FROM users WHERE email= ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();

    $result = $stmt->get_result();
    if ($result->num_rows == 0) {
        // Encryption
        $salt = str_shuffle("finganteng maksimal");
        $md5pass = md5($password);
        $combinedpass = $md5pass . $salt;
        $finalpass = md5($combinedpass);

        // Register process
        $sql = "INSERT INTO users (email, password, username, salt) VALUES (?, ?, ?, ?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ssss", $email, $finalpass, $username, $salt);
        $stmt->execute();

        if ($stmt->affected_rows > 0) {
            $data = ["result" => "success"];
        } else {
            $data = ["result" => "error", "message" => "sql error: $sql"];
        }
    } else if ($result->num_rows > 0) {
        $data = ["result" => "fail", "message" => "This email is already registered!"];
    } else {
        $data = ["result" => "error", "message" => "sql error: $sql"];
    }
    $stmt->close();
}
echo json_encode($data);
$conn->close();
