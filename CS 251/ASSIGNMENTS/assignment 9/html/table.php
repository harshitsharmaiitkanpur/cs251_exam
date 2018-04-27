<?php
   class MyDB extends SQLite3 {
      function __construct() {
         $this->open('page.db');
      }
   }
   $db = new MyDB();
   if(!$db) {
      echo $db->lastErrorMsg();
   } else {
      echo "Opened database successfully\n";
   }

   $sql =<<<EOF
      CREATE TABLE records
      (name          TEXT      NOT NULL,
      address        TEXT      NOT NULL,
      email          TEXT      NOT NULL,
      mobileno       INT       NOT NULL,
      accno          INT       NOT NULL);
EOF;


   $sql1 =<<<EOF
      CREATE TABLE newtable
      (accno         INT       NOT NULL,
       accbal        INT       NOT NULL,
       psd           TEXT      NOT NULL);
EOF;


   $ret = $db->exec($sql);
   if(!$ret){
      echo $db->lastErrorMsg();
   } else {
      echo "Table created successfully\n";
   }

    $ret1 = $db->exec($sql1);
   if(!$ret){
      echo $db->lastErrorMsg();
   } else {
      echo "Table1 created successfully\n";
   }

  
   $db->close();
?>
