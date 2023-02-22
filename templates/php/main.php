<?php
// composer require donatj/drop
require "vendor/autoload.php";

$pdo = new \PDO( "sqlite:file.db", "", "" );
$pdo->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

$dbConn = new PDO\SQLite\Wrapper($pdo, true);
$mapper = new mapper($dbConn);
