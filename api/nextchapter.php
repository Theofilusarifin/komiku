<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);
    
    $sql = "SELECT * FROM chapters WHERE comic_id = ? AND number = ?";
    $stmt = $conn->prepare($sql);
    $next_chapter = $chapter_now + 1;
    $stmt->bind_param("ii", $comic_id, $next_chapter);
    $stmt->execute();
    $chapter = $stmt->get_result()->fetch_assoc();

    $row_num = $stmt->affected_rows;
    if ($row_num > 0) {
        $data = ["result" => "success", "chapter" => $chapter];
    } else {
        $data = ["result" => "error", "message" => "Get Data Failed!"];
    }
}
echo json_encode($data);
$conn->close();
