<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "SELECT * FROM user_favorite WHERE user_email = ? AND comic_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("si", $user_email, $comic_id);
    $stmt->execute();
    $favorite = $stmt->get_result()->fetch_assoc();

    if ($favorite != null) {
        $data = ["result" => "success", "checked" => "checked"];
    } else {
        $data = ["result" => "success", "checked" => ""];
    }
}
echo json_encode($data);
$conn->close();
