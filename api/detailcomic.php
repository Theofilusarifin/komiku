<?php
header("Access-Control-Allow-Origin: *");

$data = null;
include("conn.php");

if ($conn->connect_error) {
    $data = ["result" => "error", "message" => "Unable to connect"];
} else {
    extract($_POST);
    $id_comic =  (int)$comicId;

    $sql = "SELECT c.* FROM comics c WHERE c.id = $id_comic";
    $comic = $conn->query($sql)->fetch_assoc();

    $sql2 = "SELECT ch.* FROM chapters ch WHERE ch.comic_id = $id_comic ORDER BY ch.number";
    $chapters = $conn->query($sql2);

    $sql3 = "SELECT g.name FROM genres g INNER JOIN comic_genre cg on g.id = cg.genre_id WHERE cg.comic_id = $id_comic";
    $genres = $conn->query($sql3);

    $sql4 = "SELECT sum(ur.number) as total_rating, count(*) as banyak_rating FROM user_rating ur INNER JOIN comics c on ur.comic_id = c.id WHERE ur.comic_id = $id_comic";
    $rating = $conn->query($sql4)->fetch_assoc();

    $sql5 = "SELECT COUNT(*) as total FROM comments WHERE comic_id = $id_comic";
    $total_comment = $conn->query($sql5)->fetch_assoc()['total'];

    $sql6 = "SELECT COUNT(*) as total FROM comment_reply WHERE comic_id = $id_comic";
    $total_reply = $conn->query($sql6)->fetch_assoc()['total'];
    
    $sql7 = "SELECT COUNT(*) as total FROM user_favorite WHERE comic_id = $id_comic";
    $favorite = $conn->query($sql7)->fetch_assoc();
    
    $sql8 = "SELECT co.*, u.* FROM comments co INNER JOIN comics c on co.comic_id = c.id INNER JOIN users u on co.user_email = u.email WHERE co.comic_id = $id_comic ORDER BY co.date";
    $comments = $conn->query($sql8);

    $sql9 = "SELECT cr.*, u.* FROM comment_reply cr INNER JOIN users u on cr.replier_email = u.email WHERE cr.comic_id = $id_comic ORDER BY cr.date";
    $replies = $conn->query($sql9);

    $sql10 = "SELECT ch.* FROM chapters ch WHERE ch.comic_id = $id_comic ORDER BY ch.number ASC LIMIT 1";
    $first_chapter = $conn->query($sql10)->fetch_assoc();

    $sql11 = "SELECT ch.* FROM chapters ch WHERE ch.comic_id = $id_comic ORDER BY ch.number DESC LIMIT 1";
    $last_chapter = $conn->query($sql11)->fetch_assoc();

    // Ambil Reply

    $arr_chapters = [];
    if ($chapters->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($chapters)) {
            array_push($arr_chapters, $row);
        }
    }

    $arr_genres = [];
    if ($genres->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($genres)) {
            array_push($arr_genres, $row);
        }
    }

    $arr_comments = [];
    if ($comments->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($comments)) {
            array_push($arr_comments, $row);
        }
    }

    $arr_replies = [];
    if ($replies->num_rows > 0) {
        while ($row = mysqli_fetch_assoc($replies)) {
            array_push($arr_replies, $row);
        }
    }

    $data = [
        "result" => "success",
        "comic" => $comic,
        "chapters" => $arr_chapters,
        "genres" => $arr_genres,
        "rating" => $rating,
        "all_comment" => $total_comment+$total_reply,
        "favorite" => $favorite,
        "comments" => $arr_comments,
        "replies" => $arr_replies,
        "first_chapter" => $first_chapter,
        "last_chapter" => $last_chapter,
    ];
}
echo json_encode($data);
$conn->close();
