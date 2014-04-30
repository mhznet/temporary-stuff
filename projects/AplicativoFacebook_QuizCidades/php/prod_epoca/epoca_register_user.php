<?php header("Access-Control-Allow-Origin: *");
//@author Douglas Mendes Barreto

class Response{
	var $status = 0;
}

//Recieving the variables from Matheus Flash. 
$sex = $_POST['sex'];
$faceBookID = $_POST['faceBookID'];
$name = $_POST['name'];
$date = date($_POST['date']); 
$city = $_POST['city'];


//Para teste
/*
$faceBookID = 60727223;
$name = "Matheus Zanetti";
$date = date('2007-10-01'); 
$city = "Eu amo SP";
$sex = "M";
*/

//Seting connection to mysql
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");
$mysqli = new mysqli("infografia.cxehtohpr1qf.us-east-1.rds.amazonaws.com", "infografia_user", "edinfoepoca0506", "quiz_revista_futuro");

//Verifica se nao deu algum erro de conect
if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}

if (!($mysqli->multi_query(("CALL REGISTER_PLAYER($faceBookID,'$name','$date','$city','$sex')")))) {
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
