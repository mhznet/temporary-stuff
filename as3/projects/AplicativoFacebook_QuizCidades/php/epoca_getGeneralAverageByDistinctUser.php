<?php header("Access-Control-Allow-Origin: *");

class Average{
	var $average = 0;
}

$mysqli = new mysqli("177.71.254.92", "douglasmendes", "131213", "Quiz");

//Seting connection to mysql
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
} else{
	  
	 // echo "Connection Ready \n <br>"; 
  }

  if (!($mysqli->multi_query("CALL GET_GENERAL_AVERAGE_BY_DISTINCT_USER()"))) {
    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}


if ($res = $mysqli->store_result()) {
		
		$generalAverage[0] = new Average();
		$generalAverage[0]->average = $res->fetch_assoc();
		
		echo json_encode($generalAverage);

    } else {
        if ($stmt->errno) {
            echo "Store failed: (" . $stmt->errno . ") " . $stmt->error;
        }
		
		 echo "No result"; 
    }

mysqli_close($mysqli);

?>