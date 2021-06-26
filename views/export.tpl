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


    <div class="card">
        <div class="card-body">
            <h1 class="display-4 mb-4">Export Shotdaten</h1>

            {{if .flash.notice }}
            <div class="alert alert-info" id="alert_message" role="alert">
                {{ .flash.notice }}
            </div>
            {{ end}}

            <form method="post" action="/export">
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="filetype" id="csv" value="csv" checked>
                    <label class="form-check-label" for="csv">CSV</label>

                </div>
                <div class="form-check">
                    <input class="form-check-input" type="radio" name="filetype" id="json" value="json">
                    <label class="form-check-label" for="json">JSON</label>
                </div>
                <button type="submit" class="mt-5 btn btn-success btn-lg">export</button>
            </form>
        </div>
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