<?php
//@author Douglas Mendes Barreto

class Response{
	var $status = 0;
}


//Recieving the variables from Matheus Flash. 
$faceBookID = $_POST['faceBookID'];
$name = $_POST['name'];
$age = $_POST['age']; 
$city = $_POST['city'];
$sex = $_POST['sex'];

// Verify variables from MHZ
// print "FraceBookID". $faceBookID ."<br>";
// print "User name is:  ". $name . ".<br>";
// print "User age". $age ."<br>";
// print "User sex". $sex ."<br>";
// print "User city". $city ."<br>";

//Seting connection to mysql
//$mysqli = new mysqli("localhost", "douglasmendes", "some_pass", "Quiz");
$con = mysql_connect("177.71.254.92:3306","douglasmendes","131213");

//Verifica se nao deu algum erro de conect
if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
}

  if (!($stmt = $mysqli->prepare("CALL REGISTER_PLAYER($faceBookID,'$name',$age,'$city','$sex')"))) {
    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

if (!$stmt->execute()) {
    echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
}else{
	$response[0] = new Response();
	$response[0]->status = "OK";
	//$jsonObj[0] = $response;
	echo json_encode($response);
}

mysqli_close($mysqli);



?>
