<?php header("Access-Control-Allow-Origin: *");
//@author Douglas Mendes Barreto

class Response{
	var $status = 0;
}


//Recieving the variables from Matheus Flash. 
/*$faceBookID = $_POST['faceBookID'];
$cityID = $_POST['cityID'];
$points = $_POST['points'];
*/
//Para teste
$faceBookID = 1;
$cityID = 2;
$points = 100;
// Verify variables from MHZ
// print "FraceBookID". $faceBookID ."<br>";
// print "User name is:  ". $name . ".<br>";
// print "User age". $age ."<br>";
// print "User sex". $sex ."<br>";
// print "User city". $city ."<br>";

//Seting connection to mysql
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");
$mysqli = new mysqli("177.71.254.92", "douglasmendes", "131213", "Quiz");

//Verifica se nao deu algum erro de conect
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error . "<br>";
}

if (!($mysqli->multi_query(("CALL SET_PLAYER_POINTS($faceBookID,$cityID,$points)")))) {
    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

if ($res = $mysqli->store_result()) {  
	if(mysqli_error($mysqli) == "")
	{
		$response[0] = new Response();
		$response[0]->status = $res->fetch_assoc();
		echo "oi";
		echo utf8_decode(json_encode($response));
	}else{
		echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
	}
}

mysqli_close($mysqli);
?>