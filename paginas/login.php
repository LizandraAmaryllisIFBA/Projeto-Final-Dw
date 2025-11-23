<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>

    <?php
        session_start();
        if (isset($_SESSION["erro_login"])) {
            echo $_SESSION["erro_login"];
            unset($_SESSION["erro_login"]);
        }
    ?>

    <form method="POST" action="/backend/logar.php" class="form">

        <div class = "login">

            <h1>Login</h1>

            <div class = "grupo-email">
                <input required type="email" name = "email">
                <label for="email">Email</label>
                <br><br>
            </div>

            <div class = "grupo-senha">
                <input required type = "password" name = "senha">
                <label for="senha">Senha</label><br><br>
            </div>
        </div>
        
        <button name="botao" type="submit" value="logar" class="button"><strong>Logar</strong></button>
        <a href="cadastro.php" class="link"><strong>cadastro</strong></a>
    </form>
    
</body>
</html>