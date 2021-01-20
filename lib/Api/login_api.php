<?php
include 'connection.php';

$username = $_GET['username'];
$password = $_GET['password'];

$queryResult = mysqli_query($conn,"SELECT * FROM member WHERE username='$username' and password='$password'");

    $result = array();
if ($queryResult)
{

    $count = mysqli_num_rows($queryResult);
    
    if($count == 1)
    {
    	$msg="Success";
    	array_push($result,$msg); 
       
    }
    else
    {
        $msg="Error";
    	array_push($result,$msg);
    } 
    
    echo json_encode($result);
}
else

{
    echo mysqli_error($queryResult);
}
?>