<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "INSERT INTO user_favorite (user_email, comic_id) VALUES (?,?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $user_email, $comic_id);
    $stmt->execute();

    $row_num = $stmt->affected_rows;
    if ($row_num > 0) {
        $data = ["result" => "success"];
    } else {
        $data = ["result" => "error", "message" => "Insert Favorite Failed!"];
    }
}
echo json_encode($data);
$conn->close();
