<?php

require('connection.php');

$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$username = $_POST['username'];
$password = $_POST['password'];

$insert = mysqli_query($conn, "INSERT INTO member VALUES(null,'$firstname','$lastname','$email','$phone', 1, '$username','$password',now(),curdate())") or die (mysqli_error($conn));

if(!$insert)
{
    echo "Unable to Insert Member Records.....Please try again later";
}
else
{
    echo "Member Information Created Successfully!";
}

?>