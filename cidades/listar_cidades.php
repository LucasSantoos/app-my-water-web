<?php
	include('../validar.php');
	include('../conexao.php');
?>
<!DOCTYPE html>
<html lang="pt-br">
	<head>
		<link rel="stylesheet" type="text/css" href="../style.css">
		<title>Cidades</title>
		<script type="text/javascript" src="../jquery-3.4.1.min.js"></script>
		<script>
		$(document).ready(function () {
				$('.btn-excluir').on('click', function () {
					var id = $(this).val();
					var confirma = confirm("Deseja excluir o item: "+id+"?");
					if(confirma){
						var tr = '#tr'+id;
						$.ajax({
							url: 'excluir_cidades_db.php',
							method: 'POST',
							data: {
								id: id
							}
						}).done(function (html) {
							if(html == 1) {
								alert('Cidade excluída com sucesso!');
								$(tr).empty();
							} else {
								alert('Não foi possível excluir este item pois o mesmo está sendo usado em outro cadastro.');
							}
						});
					}
				});
				$('.buscar').on('click', function () {
					var nome = $('#nome').val();
					$.ajax({
						url: 'buscar_cidades_db.php',
						method: 'POST',
						data: {
							nome: nome
						}
					}).done(function (html) {
						$('#cidades tbody').empty();
						$('#cidades tbody').html(html);
					});
				});
			});
		</script>
	</head>
		<body>
		<?php
			include('../menu.php');
		?>
		<br><br>
		Usuário:
		<?php
			echo $_SESSION['usuario']['LOGIN'];
		?>
		<br><br>
		<input type="text" name="nome" id="nome">
		<input type="button" class="buscar" name="buscar" id="buscar" value="Buscar">
		<br><br><a class="btn-cadastrar" href="cadastrar_cidades.php">Cadastrar</a>
		<table id="cidades">
			<thead>
				<tr>
					<th>Código</th>
					<th>Descrição</th>
					<th>Código estado</th>
					<th>Descrição estado</th>
					<th></th>
					<th></th>
				</tr>
			</thead>
			<tbody>
		<?php
			$sql = 'SELECT c.id, c.descricao, c.id_estado, e.descricao as descricao_estado  
					FROM cidades c 
					INNER JOIN estados e ON c.id_estado = e.id';
			$query = mysqli_query($con, $sql);

			if (!$query) {
				echo 'Erro: ' . mysqli_error($con);
			}
			while ($item = mysqli_fetch_array($query, MYSQLI_ASSOC)) {		
		?>
				<tr id="tr<?= $item['id']?>">
					<td><?php echo $item['id']; ?></td>
					<td><?php echo $item['descricao']; ?></td>
					<td><?php echo $item['id_estado']; ?></td>
					<td><?php echo $item['descricao_estado']; ?></td>
					<td><a class="btn-alterar" href="alterar_cidades.php?id=<?php echo $item['id']; ?>">Alterar</a></td>
					<td><button id="<?= $item['id']?>" class="btn-excluir" value="<?= $item['id']?>">Excluir</button></td>
				</tr>
		<?php
			}
		?>
			</tbody>
		</table>
		Existe(m) <?php echo mysqli_num_rows($query); ?> Registro(s)
	</body>
</html>
<?php
	mysqli_close($con);
?>