<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    $sql = "SELECT * FROM genres";
    $result = $conn->query($sql);

    $arr_genre = [];
    if ($result->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            array_push($arr_genre, $row);
        }
    }
    $data = ["result" => "success", "genres" => $arr_genre];
}
echo json_encode($data);
$conn->close();
