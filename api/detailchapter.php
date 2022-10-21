<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);

    $sql = "SELECT c.* FROM comics c WHERE c.id = $comic_id";
    $comic = $conn->query($sql)->fetch_assoc();

    $sql2 = "SELECT * FROM chapters WHERE id = $chapter_id";
    $chapter = $conn->query($sql2)->fetch_assoc();

    $sql3 = "SELECT COUNT(*) as total FROM chapters ch WHERE ch.comic_id = $comic_id";
    $total_chapter = $conn->query($sql3)->fetch_assoc();

    $sql4 = "SELECT * FROM pages p INNER JOIN chapters c on p.chapter_id = c.id WHERE c.comic_id = $comic_id AND p.chapter_id = $chapter_id ORDER BY p.order";
    $pages = $conn->query($sql4);

    $arr_pages = [];
    if ($pages->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($pages)) {
            array_push($arr_pages, $row);
        }
    }

    $data = [
        "result" => "success",
        "comic" => $comic,
        "chapter" => $chapter,
        "total_chapter" => $total_chapter,
        "pages" => $arr_pages,
    ];
}
echo json_encode($data);
$conn->close();
