<?php
	include('../conexao.php');
	$id = $_POST['id'];
	$sql = "DELETE FROM emissao_conta WHERE id = $id";
	echo mysqli_query($con, $sql);
	mysqli_close($con);
?>