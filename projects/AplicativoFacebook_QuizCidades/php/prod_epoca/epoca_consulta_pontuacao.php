<?php header("Access-Control-Allow-Origin: *");
class Points{
	var $city = 0;
	var $points = 0;
}

$faceBookID = $_POST['faceBookID'];
//$faceBookID = 34885038;

$mysqli = new mysqli("infografia.cxehtohpr1qf.us-east-1.rds.amazonaws.com", "infografia_user", "edinfoepoca0506", "quiz_revista_futuro");
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");



//$faceBookID =  34885038;
if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}
  
  
  if (!($mysqli->multi_query(("CALL CONSULTAR_PONTUACAO($faceBookID)")))){
    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

$points;
$i = 0;
do {
    if ($res = $mysqli->store_result()) {   
	   while( $row = $res->fetch_row() ) {
		$points[$i] = new Points();
		$points[$i]->city = $row[1];
		$points[$i]->points = $row[2];
		$i += 1;
      }
    } else {
        if ($res->errno) {
            echo "Store failed: (" . $stmt->errno . ") " . $stmt->error . "<br>";
        }
    }
	
} while ($mysqli->next_result());


echo json_encode($points);

if($res != null){
	mysqli_free_result($res);
}

$thread = $mysqli->thread_id;
$mysqli->kill($thread);
$mysqli->close();

?>