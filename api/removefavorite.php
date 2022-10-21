<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "DELETE FROM user_favorite WHERE user_email = ? AND comic_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $user_email, $comic_id);
    $stmt->execute();

    $row_num = $stmt->affected_rows;
    if ($row_num > 0) {
        $data = ["result" => "success"];
    } else {
        $data = ["result" => "error", "message" => "Delete Favorite Failed!"];
    }
}
echo json_encode($data);
$conn->close();
