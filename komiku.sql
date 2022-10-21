-- phpMyAdmin SQL Dump
-- version 5.1.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2022 at 06:40 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `komiku`
--

-- --------------------------------------------------------

--
-- Table structure for table `chapters`
--

CREATE TABLE `chapters` (
  `id` int(11) NOT NULL,
  `comic_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `total_view` int(11) NOT NULL,
  `release_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `chapters`
--

INSERT INTO `chapters` (`id`, `comic_id`, `number`, `total_view`, `release_date`) VALUES
(1, 1, 1, 30, '0000-00-00 00:00:00'),
(2, 1, 2, 40, '0000-00-00 00:00:00'),
(3, 1, 3, 50, '0000-00-00 00:00:00'),
(4, 1, 4, 60, '0000-00-00 00:00:00'),
(5, 2, 1, 100, '0000-00-00 00:00:00'),
(6, 2, 2, 100, '0000-00-00 00:00:00'),
(7, 2, 3, 300, '0000-00-00 00:00:00'),
(8, 3, 1, 10, '0000-00-00 00:00:00'),
(9, 3, 2, 30, '0000-00-00 00:00:00'),
(10, 3, 4, 40, '0000-00-00 00:00:00'),
(11, 3, 3, 50, '0000-00-00 00:00:00'),
(12, 4, 1, 60, '0000-00-00 00:00:00'),
(13, 4, 2, 100, '0000-00-00 00:00:00'),
(14, 5, 1, 100, '0000-00-00 00:00:00'),
(15, 5, 2, 300, '0000-00-00 00:00:00'),
(16, 6, 1, 10, '0000-00-00 00:00:00'),
(17, 6, 2, 30, '0000-00-00 00:00:00'),
(18, 6, 3, 40, '0000-00-00 00:00:00'),
(19, 7, 1, 50, '0000-00-00 00:00:00'),
(20, 7, 2, 60, '0000-00-00 00:00:00'),
(21, 8, 1, 100, '0000-00-00 00:00:00'),
(22, 8, 2, 100, '0000-00-00 00:00:00'),
(23, 9, 1, 300, '0000-00-00 00:00:00'),
(24, 9, 2, 10, '0000-00-00 00:00:00'),
(25, 10, 1, 30, '0000-00-00 00:00:00'),
(26, 11, 1, 40, '0000-00-00 00:00:00'),
(27, 12, 1, 50, '0000-00-00 00:00:00'),
(28, 12, 2, 60, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `comics`
--

CREATE TABLE `comics` (
  `id` int(11) NOT NULL,
  `url_poster` text NOT NULL,
  `name` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `summary` text NOT NULL,
  `status` enum('OnGoing','Completed') NOT NULL,
  `latest_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `total_view` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comics`
--

INSERT INTO `comics` (`id`, `url_poster`, `name`, `author`, `summary`, `status`, `latest_update`, `total_view`) VALUES
(1, 'assets/data/Overgeared/poster.jpg', 'Overgeared', 'LEE Dong Wook', 'Komik Overgeared merupakan serial Manhwa yang terbit pertama kali pada tahun 2020, salah satu seri populer karya LEE Dong Wook yang juga di ilustrasikan oleh Team Argo. Manhwa Overgeared telah sukses dan resmi di serialisasikan oleh Kakaopage (Kakao). Komik berikut telah ditambah kedalam daftar koleksi Komikcast pada Maret 6, 2022. Chapter terbaru Manhwa Overgeared telah kami update pada Oktober 16, 2022.', 'OnGoing', '2022-10-20 21:33:22', 2000),
(2, 'assets/data/Omniscient Readers Viewpoint/poster.jpg', 'Omniscient Readers Viewpoint', 'sing N song', 'Komik Omniscient Reader’s Viewpoint yang dibuat oleh komikus bernama sing N song, UMI (i) ini bercerita tentang \'Ini adalah perkembangan yang saya ketahui.\' Saat dia mengira bahwa dunia telah dihancurkan, dan alam semesta baru telah terbuka. Kehidupan baru seorang pembaca biasa dimulai dalam dunia novel, sebuah novel yang dia selesaikan sendiri.', 'Completed', '2022-10-20 21:33:22', 1500),
(3, 'assets/data/Swormasters Youngest Son/poster.jpg', 'Swormasters Youngest Son', 'Theofilus Arifin', 'Komik Swordmaster’s Youngest Son yang dibuat oleh komikus bernama ini bercerita tentang Jin Runcandel adalah putra bungsu dari swordmaster klan terhebat di kontinen, dan merupakan anak paling tidak berbakat di sejarah klannya. Setelah diusir dengan menyedihkan dan bertemu dan menemui akhir yang tidak ada artinya, dia di berikan kesempatan lainnya. ‘Bagaimana kau ingin menggunakan kekuatan ini?’ ‘Aku ingin menggunakan kekuatan ini untuk diriku sendiri’ Dengan ingatan dari kehidupan sebelumnya, bakat yang mendominasi, dan kontrak dengan dewa, persiapan untuk menjadi yang terhebat telah sempurna. Dengan bantuan dewa, dia menjadi magic swordman yg dapat menggunakan sihir dan ilmu pedang… Tapi dia bearkhir meninggal setelah terlibat dalam sebuah kecelakaan. Saat dia berpikir semua telah berakhir dan hendak menyerah… Dia bangun sebagai seorang bayi!?', 'Completed', '2022-10-20 21:33:22', 3012),
(4, 'assets/data/The Tutorial is Too Hard/poster.jpg', 'The Tutorial is Too Hard', 'Gandara', 'Komik The Tutorial is Too Hard yang dibuat oleh komikus bernama Gandara ini bercerita tentang Novel fantasi fusi Gandara, \'The Tutorial is Too Hard\', sekarang hadir sebagai webtoon. Suatu hari, di tengah kehidupan yang membosankan, sebuah pesan undangan muncul di depan mata saya. [Apakah Anda ingin memasuki dunia tutorial?] Setelah itu adalah jendela pemilihan kesulitan. [Mudah] [Normal] [Sulit] [Neraka]. Saya memilih neraka-kesulitan tanpa ragu-ragu. Dan saya menyesalinya. Aku tahu itu mengatakan kesulitan, tapi ini terlalu berlebihan.', 'OnGoing', '2022-10-20 21:33:22', 1100),
(5, 'assets/data/Black Clover/poster.jpg', 'Black Clover', 'TABATA Yuuki', 'Komik Black Clover yang dibuat oleh komikus bernama TABATA Yuuki ini bercerita tentang Asta dan Yuno ditinggalkan bersama di gereja yang sama, dan tidak dapat dipisahkan sejak saat itu. Sebagai anak-anak, mereka berjanji bahwa mereka akan bersaing satu sama lain untuk melihat siapa yang akan menjadi Kaisar Magus berikutnya. Namun, saat mereka dewasa, beberapa perbedaan di antara mereka menjadi jelas. Yuno adalah seorang jenius dengan sihir, dengan kekuatan dan kontrol yang luar biasa, sementara Asta tidak dapat menggunakan sihir sama sekali, dan mencoba untuk menutupi kekurangannya dengan melatih secara fisik. Ketika mereka menerima Grimoires pada usia 15 tahun, Yuno mendapatkan buku spektakuler dengan semanggi berdaun empat (kebanyakan orang menerima semanggi berdaun tiga), sementara Asta tidak menerima apa-apa. Namun, ketika Yuno diancam, kebenaran tentang kekuatan Asta terungkap, dia menerima Grimoire semanggi lima daun, \"semanggi hitam\"! Sekarang kedua sahabat itu sedang menuju dunia luar, keduanya mencari tujuan yang sama!', 'Completed', '2022-10-20 21:33:22', 1500),
(6, 'assets/data/Attack On Titan/poster.jpg', 'Attack On Titan', 'Hajime Isayama', 'Attack on Titan Manga is a comic created by Hajime Isayama. The series is based on a fictional story of humanity’s last stand against man-eating giant creatures known as Titans. The series commenced in 2009 and has been going on for 6 years now. Attack on Titans manga is expected to continue with the success, and even get better with time. According to the series’ editor Kuwakubo Shintaro, there are approximately 3 years’ worth of chapters yet to be published for the extensively popular manga.', 'OnGoing', '2022-10-20 21:33:22', 1900),
(7, 'assets/data/Ranker Who Lives A Second Time/poster.jpg', 'Ranker Who Lives A Second Time', 'Sadoyeon', 'Komik Ranker Who Lives a Second Time yang dibuat oleh komikus bernama Sadoyeon ini bercerita tentang Yeon-woo memiliki saudara kembar yang menghilang lima tahun lalu. Suatu hari, arloji saku yang ditinggalkan oleh kakaknya kembali menjadi miliknya. Di dalam, dia menemukan buku harian tersembunyi yang terekam \"Saat kamu mendengar ini, kurasa aku sudah mati….\" Obelisk, Menara Dewa Matahari, dunia tempat beberapa alam semesta dan dimensi berpotongan. Di dunia ini, saudaranya telah menjadi korban pengkhianatan saat memanjat menara. Setelah mengetahui kebenarannya, Yeon-woo memutuskan untuk memanjat menara bersama dengan buku harian kakaknya. Yeon-woo kemudian melanjutkan untuk melalui cobaan dan perkelahian yang sama seperti yang dilakukan adik laki-lakinya sebagai pemain anonim. Tujuannya? Mengalahkan Menara Obelisk dan membalas dendam untuk saudaranya.', 'Completed', '2022-10-20 21:33:22', 2800),
(8, 'assets/data/Player Who Cant Level Up/poster.jpg', 'Player Who Cant Level Up', 'GaVinGe', 'Komik Player Who Can’t Level Up yang dibuat oleh komikus bernama GaVinGe, Parrot Kim ini bercerita tentang Kim GiGyu terbangun sebagai pemain pada usia 18 tahun. Dia mengira hidupnya berada di jalur menuju kesuksesan, memanjat \'menara\' dan menutup \'gerbang\' ... Tetapi bahkan setelah menyelesaikan tutorial, dia berada di level 1. Dia membunuh seorang goblin sehari, dan dia masih level 1. Bahkan setelah 5 tahun, dia masih level 1. \"Siapa yang mengira bahwa pemain seperti ini akan ada.\" Tidak ada yang tahu.', 'Completed', '2022-10-20 21:33:22', 50),
(9, 'assets/data/Solo Max-Level Newbie/poster.jpg', 'Solo Max-Level Newbie', 'Maslow', 'Komik Solo Max-Level Newbie yang dibuat oleh komikus bernama Maslow, WAN.Z ini bercerita tentang Jinhyuk, seorang Nutuber game, adalah satu-satunya orang yang melihat akhir dari game [Tower of Trials]. Namun, ketika popularitas game tersebut menurun, menjadi sulit baginya untuk terus mencari nafkah sebagai Nutuber game. Karena dia sudah melihat akhir permainan, dia akan berhenti bermain. Tapi hari itu, [Tower of Trials] menjadi kenyataan, dan Jinhyuk, yang tahu tentang setiap hal dalam game, mengambil alih segalanya lebih cepat daripada yang seharusnya.', 'OnGoing', '2022-10-20 21:33:22', 155),
(10, 'assets/data/A Grandcross Story/poster.jpg', 'A Grandcross Story', 'Seungyong', 'Komik A Grandcross Story yang dibuat oleh komikus bernama ], Seungyong [Add, Studio Grigo [Add ini bercerita tentang Dia akan melakukan apa saja untuk meningkatkan jumlah suka dan pelanggan, BJ Dosa Jeon Woo-chi ada di sini untuk mengirim angin puyuh melalui streaming Internet Korea abad ke-21! Jeon Woochi adalah seorang pendeta Tao yang pernah membalikkan Joseon. Sejak itu, 500 tahun telah berlalu, dan dia sekarang berada di era media sosial. Dia hidup dengan menarik perhatian orang melalui siaran internet dan media sosial. Namun, suatu hari, Jinhee, putri keluarga yang kakeknya ia bantu di masa lalu, datang dengan gulungan misterius milik objek Jeon Woochi, untuk meminta bantuan. Namun, monster tak dikenal yang menargetkan gulungan itu menyerang Jeon Woochi. Dengan munculnya monster tak dikenal, banyak peristiwa mulai terjadi di sekitar Jeon Woochi. Pada saat yang sama, dia diundang ke turnamen streaming pemenang penghargaan, Channel Exceed, dan dia melihat konspirasi besar di baliknya…', 'Completed', '2022-10-20 21:33:22', 231),
(11, 'assets/data/The Tutorial Tower Of The Advanced Player/poster.jpg', 'The Tutorial Tower Of The Advanced Player', 'Bangguseokgimssi', 'Komik The Tutorial Tower of the Advanced Player yang dibuat oleh komikus bernama Bangguseokgimssi ini bercerita tentang Setelah terjebak di [Tutorial Tower] selama lebih dari 12 tahun, MC kita akhirnya berhasil keluar, tapi bagaimana dunia berubah? Meninggalkan menara setelah 12 tahun!', 'OnGoing', '2022-10-20 21:33:22', 211),
(12, 'assets/data/The Beginning After The End/poster.jpg', 'The Beginning After The End', 'TurtleMe', 'Komik The Beginning After the End yang dibuat oleh komikus bernama TurtleMe ini bercerita tentang Raja Grey memiliki kekuatan, kekayaan, dan prestise yang tak tertandingi di dunia yang diatur oleh kemampuan bela diri. Namun, kesendirian tetap ada di belakang mereka yang memiliki kekuatan besar. Di bawah eksterior glamor dari seorang raja yang kuat mengintai cangkang manusia, tanpa tujuan dan kemauan. Bereinkarnasi ke dunia baru yang penuh dengan sihir dan monster, raja memiliki kesempatan kedua untuk menghidupkan kembali hidupnya. Namun, mengoreksi kesalahan di masa lalunya bukanlah satu-satunya tantangannya. Di bawah kedamaian dan kemakmuran dunia baru adalah arus bawah yang mengancam untuk menghancurkan semua yang telah dia kerjakan, mempertanyakan peran dan alasannya untuk dilahirkan kembali.', 'Completed', '2022-10-20 21:33:22', 566);

-- --------------------------------------------------------

--
-- Table structure for table `comic_genre`
--

CREATE TABLE `comic_genre` (
  `comic_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `comic_genre`
--

INSERT INTO `comic_genre` (`comic_id`, `genre_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 1),
(3, 6),
(4, 2),
(4, 3),
(4, 4),
(5, 1),
(5, 5),
(5, 6),
(6, 2),
(6, 3),
(7, 1),
(7, 2),
(7, 4),
(8, 2),
(8, 5),
(8, 6),
(9, 3),
(9, 4),
(10, 1),
(10, 5),
(10, 6),
(11, 2),
(11, 3),
(12, 2),
(12, 5),
(12, 6);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `comic_id` int(11) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `comment_reply`
--

CREATE TABLE `comment_reply` (
  `reply_id` int(11) NOT NULL,
  `replier_email` varchar(100) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `comic_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `genres`
--

INSERT INTO `genres` (`id`, `name`, `description`) VALUES
(1, 'Action', 'Action is about conflict. Whether with guns, blades, fists, or mysterious powers, these manga feature characters in combat - either to protect themselves or the things or people they value, or simply as a way of life.'),
(2, 'Adventure', 'Someone leaves everything he or she knows, faces danger and excitement along the way, and with a little luck, gets to his or her final destination safely and with a story to tell.'),
(3, 'Horror', 'Also called paranormal, supernatural events are those modern science has difficulty explaining. Supernaturally oriented titles are often steeped in folklore, myth, or Urban Legend. They may involve strange or inexplicable phenomena, Psychic Powers or emanations, and/or ghosts or other fantastic creatures. Supernatural events are those that lie at the edge of our understanding - they are easy to believe in, but difficult to prove.'),
(4, 'Sci-fi', 'Sci-fi, or science fiction, is a speculative genre which builds on imagination. Sci-fi manga ask, \"what if things were different?\" They explore a new world, whether it\'s the world of the future or past, a present Earth with a changed history, a land that was previously unknown, or another planet entirely. The genre commonly features humanity\'s inquisitiveness and innovation, as they grapple with new technologies, new societies, or new frontiers in Outer Space'),
(5, 'Mystery', 'Mystery manga focus on unresolved questions, and the efforts of characters to discover the answers to them. Whether curious and deadly events are afoot, or some part of the world itself is strange or inexplicable, or someone\'s past or identity seems strangely shrouded, these characters are set on learning the truth.'),
(6, 'Magic', 'Magic realism, chiefly Latin-American narrative strategy that is characterized by the matter-of-fact inclusion of fantastic or mythical elements into seemingly realistic fiction');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `chapter_id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  `img_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `chapter_id`, `order`, `img_url`) VALUES
(1, 1, 1, 'assets\\data\\Overgeared\\1\\1.jpg'),
(2, 1, 2, 'assets\\data\\Overgeared\\1\\2.jpg'),
(3, 1, 3, 'assets\\data\\Overgeared\\1\\3.jpg'),
(4, 1, 4, 'assets\\data\\Overgeared\\1\\4.jpg'),
(5, 1, 5, 'assets\\data\\Overgeared\\1\\5.jpg'),
(6, 2, 1, 'assets\\data\\Overgeared\\2\\1.jpg'),
(7, 2, 2, 'assets\\data\\Overgeared\\2\\2.jpg'),
(8, 2, 3, 'assets\\data\\Overgeared\\2\\3.jpg'),
(9, 2, 4, 'assets\\data\\Overgeared\\2\\4.jpg'),
(10, 2, 5, 'assets\\data\\Overgeared\\2\\5.jpg'),
(11, 3, 1, 'assets\\data\\Overgeared\\3\\1.jpg'),
(12, 3, 2, 'assets\\data\\Overgeared\\3\\2.jpg'),
(13, 3, 3, 'assets\\data\\Overgeared\\3\\3.jpg'),
(14, 3, 4, 'assets\\data\\Overgeared\\3\\4.jpg'),
(15, 4, 1, 'assets\\data\\Overgeared\\4\\1.jpg'),
(16, 4, 2, 'assets\\data\\Overgeared\\4\\2.jpg'),
(17, 4, 3, 'assets\\data\\Overgeared\\4\\3.jpg'),
(18, 4, 4, 'assets\\data\\Overgeared\\4\\4.jpg'),
(19, 4, 5, 'assets\\data\\Overgeared\\4\\5.jpg'),
(20, 5, 1, 'assets\\data\\Omniscient Readers Viewpoint\\1\\1.jpg'),
(21, 5, 2, 'assets\\data\\Omniscient Readers Viewpoint\\1\\2.jpg'),
(22, 5, 3, 'assets\\data\\Omniscient Readers Viewpoint\\1\\3.jpg'),
(23, 5, 4, 'assets\\data\\Omniscient Readers Viewpoint\\1\\4.jpg'),
(24, 6, 1, 'assets\\data\\Omniscient Readers Viewpoint\\2\\1.jpg'),
(25, 6, 2, 'assets\\data\\Omniscient Readers Viewpoint\\2\\2.jpg'),
(26, 6, 3, 'assets\\data\\Omniscient Readers Viewpoint\\2\\3.jpg'),
(27, 6, 4, 'assets\\data\\Omniscient Readers Viewpoint\\2\\4.jpg'),
(28, 7, 1, 'assets\\data\\Omniscient Readers Viewpoint\\3\\1.jpg'),
(29, 7, 2, 'assets\\data\\Omniscient Readers Viewpoint\\3\\2.jpg'),
(30, 7, 3, 'assets\\data\\Omniscient Readers Viewpoint\\3\\3.jpg'),
(31, 7, 4, 'assets\\data\\Omniscient Readers Viewpoint\\3\\4.jpg'),
(32, 8, 1, 'assets\\data\\Swormasters Youngest Son\\1\\1.jpg'),
(33, 8, 2, 'assets\\data\\Swormasters Youngest Son\\1\\2.jpg'),
(34, 8, 3, 'assets\\data\\Swormasters Youngest Son\\1\\3.jpg'),
(35, 8, 4, 'assets\\data\\Swormasters Youngest Son\\1\\4.jpg'),
(36, 9, 1, 'assets\\data\\Swormasters Youngest Son\\2\\1.jpg'),
(37, 9, 2, 'assets\\data\\Swormasters Youngest Son\\2\\2.jpg'),
(38, 9, 3, 'assets\\data\\Swormasters Youngest Son\\2\\3.jpg'),
(39, 9, 4, 'assets\\data\\Swormasters Youngest Son\\2\\4.jpg'),
(40, 10, 1, 'assets\\data\\Swormasters Youngest Son\\3\\1.jpg'),
(41, 10, 2, 'assets\\data\\Swormasters Youngest Son\\3\\2.jpg'),
(42, 10, 3, 'assets\\data\\Swormasters Youngest Son\\3\\3.jpg'),
(43, 10, 4, 'assets\\data\\Swormasters Youngest Son\\3\\4.jpg'),
(44, 11, 1, 'assets\\data\\Swormasters Youngest Son\\4\\1.jpg'),
(45, 11, 2, 'assets\\data\\Swormasters Youngest Son\\4\\2.jpg'),
(46, 11, 3, 'assets\\data\\Swormasters Youngest Son\\4\\3.jpg'),
(47, 11, 4, 'assets\\data\\Swormasters Youngest Son\\4\\4.jpg'),
(48, 12, 1, 'assets\\data\\The Tutorial is Too Hard\\1\\1.jpg'),
(49, 12, 2, 'assets\\data\\The Tutorial is Too Hard\\1\\2.jpg'),
(50, 12, 3, 'assets\\data\\The Tutorial is Too Hard\\1\\3.jpg'),
(51, 12, 4, 'assets\\data\\The Tutorial is Too Hard\\1\\4.jpg'),
(52, 13, 1, 'assets\\data\\The Tutorial is Too Hard\\2\\1.jpg'),
(53, 13, 2, 'assets\\data\\The Tutorial is Too Hard\\2\\2.jpg'),
(54, 13, 3, 'assets\\data\\The Tutorial is Too Hard\\2\\3.jpg'),
(55, 13, 4, 'assets\\data\\The Tutorial is Too Hard\\2\\4.jpg'),
(56, 14, 1, 'assets\\data\\Black Clover\\1\\1.jpg'),
(57, 14, 2, 'assets\\data\\Black Clover\\1\\2.jpg'),
(58, 14, 3, 'assets\\data\\Black Clover\\1\\3.jpg'),
(59, 14, 4, 'assets\\data\\Black Clover\\1\\4.jpg'),
(60, 15, 1, 'assets\\data\\Black Clover\\2\\1.jpg'),
(61, 15, 2, 'assets\\data\\Black Clover\\2\\2.jpg'),
(62, 15, 3, 'assets\\data\\Black Clover\\2\\3.jpg'),
(63, 15, 4, 'assets\\data\\Black Clover\\2\\4.jpg'),
(64, 16, 1, 'assets\\data\\Attack On Titan\\1\\1.jpeg'),
(65, 16, 2, 'assets\\data\\Attack On Titan\\1\\2.jpeg'),
(66, 16, 3, 'assets\\data\\Attack On Titan\\1\\3.jpeg'),
(67, 16, 4, 'assets\\data\\Attack On Titan\\1\\4.jpeg'),
(68, 17, 1, 'assets\\data\\Attack On Titan\\2\\1.jpeg'),
(69, 17, 2, 'assets\\data\\Attack On Titan\\2\\2.jpeg'),
(70, 17, 3, 'assets\\data\\Attack On Titan\\2\\3.jpeg'),
(71, 17, 4, 'assets\\data\\Attack On Titan\\2\\4.jpeg'),
(72, 18, 1, 'assets\\data\\Attack On Titan\\3\\1.jpeg'),
(73, 18, 2, 'assets\\data\\Attack On Titan\\3\\2.jpeg'),
(74, 18, 3, 'assets\\data\\Attack On Titan\\3\\3.jpeg'),
(75, 18, 4, 'assets\\data\\Attack On Titan\\3\\4.jpeg'),
(76, 19, 1, 'assets\\data\\Ranker Who Lives A Second Time\\1\\1.webp'),
(77, 19, 2, 'assets\\data\\Ranker Who Lives A Second Time\\1\\2.webp'),
(78, 19, 3, 'assets\\data\\Ranker Who Lives A Second Time\\1\\3.webp'),
(79, 19, 4, 'assets\\data\\Ranker Who Lives A Second Time\\1\\4.webp'),
(80, 20, 1, 'assets\\data\\Ranker Who Lives A Second Time\\2\\1.webp'),
(81, 20, 2, 'assets\\data\\Ranker Who Lives A Second Time\\2\\2.webp'),
(82, 20, 3, 'assets\\data\\Ranker Who Lives A Second Time\\2\\3.webp'),
(83, 20, 4, 'assets\\data\\Ranker Who Lives A Second Time\\2\\4.webp'),
(84, 21, 1, 'assets\\data\\Player Who Cant Level Up\\1\\1.webp'),
(85, 21, 2, 'assets\\data\\Player Who Cant Level Up\\1\\2.webp'),
(86, 21, 3, 'assets\\data\\Player Who Cant Level Up\\1\\3.webp'),
(87, 21, 4, 'assets\\data\\Player Who Cant Level Up\\1\\4.webp'),
(88, 22, 1, 'assets\\data\\Player Who Cant Level Up\\2\\1.webp'),
(89, 22, 2, 'assets\\data\\Player Who Cant Level Up\\2\\2.webp'),
(90, 22, 3, 'assets\\data\\Player Who Cant Level Up\\2\\3.webp'),
(91, 22, 4, 'assets\\data\\Player Who Cant Level Up\\2\\4.webp'),
(92, 23, 1, 'assets\\data\\Solo Max-Level Newbie\\1\\1.webp'),
(93, 23, 2, 'assets\\data\\Solo Max-Level Newbie\\1\\2.webp'),
(94, 23, 3, 'assets\\data\\Solo Max-Level Newbie\\1\\3.webp'),
(95, 23, 4, 'assets\\data\\Solo Max-Level Newbie\\1\\4.webp'),
(96, 24, 1, 'assets\\data\\Solo Max-Level Newbie\\2\\1.webp'),
(97, 24, 2, 'assets\\data\\Solo Max-Level Newbie\\2\\2.webp'),
(98, 24, 3, 'assets\\data\\Solo Max-Level Newbie\\2\\3.webp'),
(99, 24, 4, 'assets\\data\\Solo Max-Level Newbie\\2\\4.webp'),
(100, 25, 1, 'assets\\data\\A Grandcross Story\\1\\1.webp'),
(101, 25, 2, 'assets\\data\\A Grandcross Story\\1\\2.webp'),
(102, 25, 3, 'assets\\data\\A Grandcross Story\\1\\3.webp'),
(103, 25, 4, 'assets\\data\\A Grandcross Story\\1\\4.webp'),
(104, 26, 1, 'assets\\data\\The Tutorial Tower Of The Advanced Player\\1\\1.webp'),
(105, 26, 2, 'assets\\data\\The Tutorial Tower Of The Advanced Player\\1\\2.webp'),
(106, 26, 3, 'assets\\data\\The Tutorial Tower Of The Advanced Player\\1\\3.webp'),
(107, 26, 4, 'assets\\data\\The Tutorial Tower Of The Advanced Player\\1\\4.webp'),
(108, 27, 1, 'assets\\data\\The Beginning After The End\\1\\1.webp'),
(109, 27, 2, 'assets\\data\\The Beginning After The End\\1\\2.webp'),
(110, 27, 3, 'assets\\data\\The Beginning After The End\\1\\3.webp'),
(111, 27, 4, 'assets\\data\\The Beginning After The End\\1\\4.webp'),
(112, 28, 1, 'assets\\data\\The Beginning After The End\\2\\1.webp'),
(113, 28, 2, 'assets\\data\\The Beginning After The End\\2\\2.webp'),
(114, 28, 3, 'assets\\data\\The Beginning After The End\\2\\3.webp'),
(115, 28, 4, 'assets\\data\\The Beginning After The End\\2\\4.webp');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(100) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `salt` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `username`, `password`, `salt`) VALUES
('a@gmail.com', 'finz', 'f18ec580d81348cf470182feadac4a47', 'egifts nlnagiamnmka'),
('b@gmail.com', 'theoz', '056d24e90999ce1c5e0bd5fe3c01b187', 'nnnatelggsf mmkiaai'),
('c@gmai.com', 'theo', '9ad97022ec9b97d9988d76f3be68fd61', 'mlmknaiefaang gistn');

-- --------------------------------------------------------

--
-- Table structure for table `user_favorite`
--

CREATE TABLE `user_favorite` (
  `user_email` varchar(100) NOT NULL,
  `comic_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_favorite`
--

INSERT INTO `user_favorite` (`user_email`, `comic_id`) VALUES
('a@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_rating`
--

CREATE TABLE `user_rating` (
  `user_email` varchar(100) NOT NULL,
  `comic_id` int(11) NOT NULL,
  `number` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`id`,`comic_id`),
  ADD KEY `fk_chapters_comics1_idx` (`comic_id`);

--
-- Indexes for table `comics`
--
ALTER TABLE `comics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comic_genre`
--
ALTER TABLE `comic_genre`
  ADD PRIMARY KEY (`comic_id`,`genre_id`),
  ADD KEY `fk_comics_has_genres_genres1_idx` (`genre_id`),
  ADD KEY `fk_comics_has_genres_comics1_idx` (`comic_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`,`comic_id`),
  ADD KEY `fk_users_has_comics_comics2_idx` (`comic_id`),
  ADD KEY `fk_users_has_comics_users1_idx` (`user_email`);

--
-- Indexes for table `comment_reply`
--
ALTER TABLE `comment_reply`
  ADD PRIMARY KEY (`reply_id`),
  ADD KEY `fk_users_has_comments_users1_idx` (`replier_email`),
  ADD KEY `fk_comment_reply_comments1_idx` (`comment_id`,`comic_id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`,`chapter_id`),
  ADD KEY `fk_pages_chapters1_idx` (`chapter_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `user_favorite`
--
ALTER TABLE `user_favorite`
  ADD PRIMARY KEY (`user_email`,`comic_id`),
  ADD KEY `fk_users_has_comics_comics1_idx` (`comic_id`),
  ADD KEY `fk_users_has_comics_users_idx` (`user_email`);

--
-- Indexes for table `user_rating`
--
ALTER TABLE `user_rating`
  ADD PRIMARY KEY (`user_email`,`comic_id`),
  ADD KEY `fk_users_has_comics_comics3_idx` (`comic_id`),
  ADD KEY `fk_users_has_comics_users2_idx` (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chapters`
--
ALTER TABLE `chapters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `comics`
--
ALTER TABLE `comics`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `comment_reply`
--
ALTER TABLE `comment_reply`
  MODIFY `reply_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chapters`
--
ALTER TABLE `chapters`
  ADD CONSTRAINT `fk_chapters_comics1` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `comic_genre`
--
ALTER TABLE `comic_genre`
  ADD CONSTRAINT `fk_comics_has_genres_comics1` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_comics_has_genres_genres1` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `fk_users_has_comics_comics2` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_comics_users1` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `comment_reply`
--
ALTER TABLE `comment_reply`
  ADD CONSTRAINT `fk_comment_reply_comments1` FOREIGN KEY (`comment_id`,`comic_id`) REFERENCES `comments` (`id`, `comic_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_comments_users1` FOREIGN KEY (`replier_email`) REFERENCES `users` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `fk_pages_chapters1` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_favorite`
--
ALTER TABLE `user_favorite`
  ADD CONSTRAINT `fk_users_has_comics_comics1` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_comics_users` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_rating`
--
ALTER TABLE `user_rating`
  ADD CONSTRAINT `fk_users_has_comics_comics3` FOREIGN KEY (`comic_id`) REFERENCES `comics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_has_comics_users2` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
