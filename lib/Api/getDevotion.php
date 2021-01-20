<?php
include 'connection.php';

$queryResult = mysqli_query($conn,"SELECT * FROM daily_devotion order by id desc");

    $result = array();
if ($queryResult)
{

    $count = mysqli_num_rows($queryResult);

    if($count> 1)
    {
        while($row=mysqli_fetch_array($queryResult))
        {
             array_push($result,array("title"=>$row['title'],"things_to_know"=>$row['things_to_know'],"text_to_read"=>$row['text_to_read'],"text_quote"=>$row['text_quote']));   
        }

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