<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "INSERT INTO comment_reply (replier_email, comment_id, comic_id, text, date) VALUES (?,?,?,?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("siis", $replier_email, $comment_id, $comic_id, $comment);
    $stmt->execute();

    $row_num = $stmt->affected_rows;
    if ($row_num > 0) {
        $data = ["result" => "success"];
    } else {
        $data = ["result" => "error", "message" => "Insert Failed!"];
    }
}
echo json_encode($data);
$conn->close();
