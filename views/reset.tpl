<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shot-O-Mat</title>
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/main.css" rel="stylesheet">
    <meta name="theme-color" content="#32373A">
</head>
<body>

<div class="container-fluid">

    <div class="jumbotron bg-dark text-light">
        <h1 class="display-4">Shotdaten löschen</h1>
        <p class="lead">Bist du sicher dass du alle Daten löschen möchtest?</p>
        <hr class="my-4" style="color: white; border-color:white">


        <form method="post" action="/reset" autocomplete="off">
            <button type="submit" class="btn btn-danger btn-lg">löschen</button>
        </form>

    </div>
</div>
</body>
</html>