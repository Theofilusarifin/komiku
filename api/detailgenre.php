<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "SELECT c.*, COUNT(c.id) as comic_chapter FROM comic_genre cg INNER JOIN comics c on cg.comic_id = c.id LEFT JOIN chapters ch on c.id = ch.comic_id WHERE cg.genre_id = ?  GROUP BY c.id";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $genreId);
    $stmt->execute();
    $result = $stmt->get_result();

    $sql2 = "SELECT * FROM genres where id=?";
    $stmt2 = $conn->prepare($sql2);
    $stmt2->bind_param("i", $genreId);
    $stmt2->execute();
    $result2 = $stmt2->get_result()->fetch_assoc();

    $arr_comic = [];
    if ($result->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($result)) {
            array_push($arr_comic, $row);
        }
    }
    $data = ["result" => "success", "genre" => $result2, "comics" => $arr_comic];
}
echo json_encode($data);
$conn->close();
