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
    <div class="m-5">


        {{if .flash.notice }}
        <div class="alert alert-info" id="alert_message" role="alert">
            {{ .flash.notice }}
        </div>
        {{ end}}


        <form method="post" action="/enter" autocomplete="off">
            <div class="form-group">
                <label for="group" class="text-light">Gruppe</label>
                <input type="text" name="groupname" list="groups" class="form-control bg-dark text-light" id="group"
                       placeholder="Gruppe">
            </div>
            <div class="form-group">
                <label for="anzahl" class="text-light">Anzahl Shots gekauft</label>
                <input type="number" name="shotcount" class="form-control bg-dark text-light" id="anzahl"
                       placeholder="Anzahl">
            </div>
            <button type="submit" class="btn btn-primary">speichern</button>

            <datalist id="groups">
                {{ range $key, $val := .groups }}
                <option value="{{ $val }}">{{ $val }}</option>
                {{ end }}
            </datalist>

        </form>


    </div>
    <script>
        window.setTimeout(function () {
            $("#alert_message").fadeTo(500, 0).slideUp(500, function () {
                $(this).remove();
            });
        }, 3000);
    </script>
</div>

<script src="/static/js/jquery-3.2.1.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-confirmation.min.js"></script>

</body>
</html>