<?php header("Access-Control-Allow-Origin: *");
//@author Douglas Mendes Barreto

class Response{
	var $status = 0;
}

//Recieving the variables from Matheus Flash. 
$faceBookID = $_POST['faceBookID'];
$cityID = $_POST['cityID'];
$points = $_POST['points'];

//Para teste
/*$faceBookID = 1;
$cityID = 4;
$points = 300;*/

//Seting connection to mysql
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");
$mysqli = new mysqli("infografia.cxehtohpr1qf.us-east-1.rds.amazonaws.com", "infografia_user", "edinfoepoca0506", "quiz_revista_futuro");

//Verifica se nao deu algum erro de conect
if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}

if (!($mysqli->multi_query(("CALL SET_PLAYER_POINTS($faceBookID,$cityID,$points)")))) {
    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

if ($res = $mysqli->store_result()) {  
	if(mysqli_error($mysqli) == "")
	{
		$response[0] = new Response();
		$response[0]->status = $res->fetch_assoc();
		echo utf8_decode(json_encode($response));
		mysqli_free_result($res);
	}else{
		echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
	}
}
$thread = $mysqli->thread_id;
$mysqli->kill($thread);
$mysqli->close();

?>