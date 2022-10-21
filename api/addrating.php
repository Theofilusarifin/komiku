<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql_check = "SELECT * FROM user_rating where user_email = ? AND comic_id = ?";
    $stmt_check = $conn->prepare($sql_check);
    $stmt_check->bind_param("si", $user_email, $comic_id);
    $stmt_check->execute();
    $result = $stmt_check->get_result()->fetch_assoc();

    if ($result != null) {
        $data = ["result" => "error", "message" => "You have already rate this comic with ".$result['number']." star!"];
    } else {
        $sql = "INSERT INTO user_rating (user_email, comic_id, number) VALUES (?,?,?)";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sii", $user_email, $comic_id, $number);
        $stmt->execute();

        $row_num = $stmt->affected_rows;
        if ($row_num > 0) {
            $data = ["result" => "success"];
        } else {
            $data = ["result" => "error", "message" => "Insert Failed!"];
        }
    }
}
echo json_encode($data);
$conn->close();
