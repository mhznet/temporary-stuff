<?php header("Access-Control-Allow-Origin: *");

class Average{
	var $average = 0;
}

$mysqli = new mysqli("infografia.cxehtohpr1qf.us-east-1.rds.amazonaws.com", "infografia_user", "edinfoepoca0506", "quiz_revista_futuro");

//Seting connection to mysql
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");

if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}

  if (!($mysqli->multi_query("CALL GET_GENERAL_AVERAGE_BY_DISTINCT_USER()"))) {
    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}


if ($res = $mysqli->store_result()) {
		
		$generalAverage[0] = new Average();
		$generalAverage[0]->average = $res->fetch_assoc();
		
		echo json_encode($generalAverage);
		mysqli_free_result($res);
    } else {
        if ($stmt->errno) {
            echo "Store failed: (" . $stmt->errno . ") " . $stmt->error;
        }
		
		 echo "No result"; 
    }



$thread = $mysqli->thread_id;
$mysqli->kill($thread);
$mysqli->close();

?>