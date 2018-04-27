<?php

// define variables and set to empty values
$name = $email = $gender = $comment = $website = "";
$db = new SQLite3('page.db');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
  $name = test_input($_POST["name"]);
  $address = test_input($_POST["address"]);
  $email = test_input($_POST["email"]);
  $mobileno = test_input($_POST["mobile"]);
  $accno = test_input($_POST["accno"]);
  $qstr = "insert into records values ('$name', '$address', '$email', '$mobileno', '$accno')";
  $insres = $db->query($qstr);
}

function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

$insres = $db->exec($qstr);
   if(!$insres){
      echo $db->lastErrorMsg();
   } else {
      echo "Table created successfully\n";
   }



echo "<h2>Records:</h2>";

$email_query = "select * from records where email='".$email."'";
$results = $db->query($email_query);


//$results = $db->query('SELECT * FROM records');
$counter=0;
while ($row = $results->fetchArray()) {
	//echo "<br> $row[0] $row[1] $row[2] $row[3] $row[4]";
	$counter++;
  
}
if($counter>=1){
	//echo $counter;
	echo "Already Registered\n";
}


 $sql =<<<EOF
      INSERT INTO newtable (accno,accbal,psd)
      VALUES (67890, 800 , 'qwerty');

      INSERT INTO newtable (accno,accbal,psd)
      VALUES (56789, 1800 , 'uiop');

EOF;

  $ret = $db->exec($sql);
   if(!$ret) {
      echo $db->lastErrorMsg();
   } else {
      echo "  Records created successfully\n";
   }

$accbal_query = "select * from newtable where accbal=".$accbal;
$accbal_output = $db->query($accbal_query);

while ($row1 = $accbal_output->fetchArray()) {
	if($row1[1] < 1000){
	   echo $row1[1];
	   echo "Insufficient Balance";
}
	else{
	    $sql =<<<EOF
            UPDATE newtable set accbal = $row1[1]-1000;
EOF;
  }	  
}

//$accno_query = "select * from records where accno=".$accno;
//$accno_output = $db->query($accno_query);


/*echo $name;
echo "<br>";
echo $email;
echo "<br>";
echo $website;
echo "<br>";
echo $comment;
echo "<br>";
echo $gender;*/
?>
