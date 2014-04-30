<?php header("Access-Control-Allow-Origin: *");
class Points{
	var $city = 0;
	var $points = 0;
}

$faceBookID = $_POST['faceBookID'];
//$faceBookID = 34885038;

$mysqli = new mysqli("177.71.254.92", "douglasmendes", "131213", "Quiz");
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");



//$faceBookID =  34885038;
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error . "<br>";
} else{
	  
	  //echo "Connection Ready \n \n <br>"; 
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
	  
	  $res->close();
    } else {
        if ($stmt->errno) {
            echo "Store failed: (" . $stmt->errno . ") " . $stmt->error . "<br>";
        }
    }
	
} while ($mysqli->next_result());


echo json_encode($points);

mysqli_close($mysqli);

?>