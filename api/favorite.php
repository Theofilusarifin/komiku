<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "SELECT c.*, COUNT(c.id) as comic_chapter FROM user_favorite uf INNER JOIN comics c on c.id = uf.comic_id LEFT JOIN chapters ch ON c.id = ch.comic_id WHERE uf.user_email = ? GROUP BY c.id";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    $arr_comic = [];
    if ($result->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            array_push($arr_comic, $row);
        }
    }
    $data = ["result" => "success", "comics" => $arr_comic];
}
echo json_encode($data);
$conn->close();
