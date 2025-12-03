<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Canais</title>
    <link rel="stylesheet" href="../css/principal.css"> 
</head>
<body>

    <?php
        require "cabecalho.php";
    ?>

    <!--  -->
    <div class="container-descricao">
        <?php 
            if (!isset($conexao)) {$conexao = conectar_bd();}
            $comando = "SELECT * FROM Canal WHERE idUsuario = '" . $id_usuario . "';";
            $resultado_query = mysqli_query($conexao, $comando);
            if (mysqli_num_rows($resultado_query) === 0) {header("Location: /"); exit();}
            $canal = mysqli_fetch_assoc($resultado_query);
        ?>
        <?= "
            <img src=\"{$canal['Caminho_banner']}\" alt=\"Banner do canal {$canal['Nome']}\" class=\"banner\">
            <img src=\"{$canal['Caminho_foto']}\" alt=\"Foto de perfil do canal {$canal['Nome']}\" class=\"foto_perfil\">
            <h1>{$canal['Nome']}</h1>
            <p>{$canal['sBio']}</p>"
        ?>
    </div>


    <!-- Lista de comentários -->
    <div class="container-canais">

        <!-- Cada comentário -->
        <?php 
            $comando = "SELECT * FROM Comentario 
                            JOIN Usuario ON Comentario.idAutor = Usuario.idUsuario 
                            WHERE Comentario.idCanal = " . $vars["id"] .
                       "    ORDER BY DataPublicacao DESC";
            $resultado_query = mysqli_query($conexao, $comando);
            if (mysqli_num_rows($resultado_query) !== 0) {
                // Loop que escreve os comentários
                // Observação importante que ele é aberto dentro dessa tag php e fechado apenas na tag mais abaixo
                while ($comentario = mysqli_fetch_assoc($resultado_query)) {
                    $canal_autor = idUsuario_para_idCanal($comentario['Comentario.idAutor']);
        ?>
        <?= "<div class=\"comentario\">
                <div class=\"info\">
                    <a href=\"/canal/{$canal_autor}\">
                        <h3>{$comentario['Usuario.Nome']}</h3>
                    </a>
                    <p>{$comentario['Comentario.Texto']}</p>
                </div>
            </div>"
        ?>
        <?php }}?>
    </div>
</div>

</body>
</html>
