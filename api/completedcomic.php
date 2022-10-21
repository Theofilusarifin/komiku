<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "SELECT c.*, COUNT(c.id) as comic_chapter FROM comics c LEFT JOIN chapters ch ON c.id = ch.comic_id WHERE c.status = 'Completed' GROUP BY c.id";
    $result = $conn->query($sql);

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
