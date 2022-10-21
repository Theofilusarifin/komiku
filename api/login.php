<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    // Check the user is exist or not
    $sql = "SELECT * FROM users WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Password Checking
        if ($row = $result->fetch_assoc()) {
            // Encrypt inputted password
            $salt = $row['salt'];
            $md5pass = md5($password);
            $combinedpass = $md5pass . $salt;
            $finalpass = md5($combinedpass);
            // Check wether the result is the same or not
            if ($finalpass == $row['password']) {
                $data = ["result" => "success", "username" => $row['username']];
            }
            // Wrong Password 
            else {
                $data = ["result" => "fail", "message" => "This credential does not exist on our database!"];
            }
        }
    } else {
        $data = ["result" => "fail", "message" => "This credential does not exist on our database!"];
    }
    $stmt->close();
}
echo json_encode($data);
$conn->close();
