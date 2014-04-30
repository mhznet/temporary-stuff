<?php header("Access-Control-Allow-Origin: *");
class City {
	var $id;
	var $average;
}

$con = mysql_connect("infografia.cxehtohpr1qf.us-east-1.rds.amazonaws.com:3306","infografia_user","edinfoepoca0506");
//$con = mysql_connect("localhost", "douglasmendes", "some_pass");

if (!$con)
  {
  die('Could not connect: ' . mysql_error());
  }
  
$queryPointByCity = mysql_query("SELECT CIDADE_ID,Sum(POINTS) as POINTS FROM quiz_revista_futuro.POINTS_TABLE GROUP BY CIDADE_ID") or die(mysql_error());
$queryUserByCity = mysql_query("SELECT CIDADE_ID,count(FACEBOOK_ID) as FACEBOOK_ID FROM quiz_revista_futuro.POINTS_TABLE GROUP BY CIDADE_ID;") or die(mysql_error());

$city;
$numPointByCity = mysql_numrows($queryPointByCity);
$numUserByCity = mysql_numrows($queryUserByCity);
for($i = 0; $i < $numPointByCity; $i++){
	for($j = 0; $j < $numUserByCity; $j++){
		if(mysql_result($queryPointByCity,$i,"CIDADE_ID") == mysql_result($queryUserByCity,$j,"CIDADE_ID")){
			$city[$i] = new City();
			$city[$i]->id = mysql_result($queryPointByCity,$i,"CIDADE_ID");
			
			$resultNumber = mysql_result($queryPointByCity,$i,"POINTS")/mysql_result($queryUserByCity,$j,"FACEBOOK_ID");
			$city[$i]->average = number_format($resultNumber,1,'.','');
			break;
		}
	}
}

mysql_free_result($queryPointByCity);
mysql_free_result($queryUserByCity);

echo json_encode($city);

// some code
mysql_close($con);

?>