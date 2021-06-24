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

    <div class="row">
        <img src="/static/img/toplogo.png" alt="TopLogo"
             class="header-image">
    </div>

    <div class="row mt-5">
        <div class="col-6">
            <div class="card bg-transparent border-0">
                <div class="card-body">
                    <div id="chartContainer"></div>
                </div>
            </div>
        </div>

        <div class="col-6">
            <div class="card bg-transparent border-0">
                <div class="card-body">
                    <div class="row">
                        <h1 class="display-4 text-light">Top 15</h1>
                    </div>
                    <table class="table text-light table-sm">
                        <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col">Gruppe</th>
                            <th scope="col">Anzahl</th>
                        </tr>
                        </thead>
                        <tbody id="grouptable"></tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-12 text-center">
            <h1 class="display-4 text-light" id="total">Total</h1>
        </div>
    </div>

    <script src="/static/js/canvasjs.min.js"></script>
    <script type="text/javascript">

        let chartData = [];
        let tbody = document.getElementById('grouptable');

        runner();
        setInterval(runner, 10000);

        function runner() {

            doGet('/getGroups', (err, data) => {
                // console.debug('doing getGroup call');
                if (err !== null) {
                    console.error('could not getting Data. Is the backend Server running?');
                    alert('Cannot calling Group Data \n' +
                        'Error raised: ' + err.number + '\n' +
                        'Is the server running?');
                } else {

                    console.log(data);
                    chartData = data;
                    createChart();

                    // Cleanup Table
                    tbody.innerHTML = '';
                    createTable();
                    // updateTime();
                    updateTotal();
                }
            });

        }

        function updateTotal() {
            doGet('/getTotal', (err, data) => {
                // console.log('hello');
                if (err != null) {
                    alert('Cannot getTotal. Is the server running?');
                } else {
                    console.log(data);
                    // console.log('total is ' + data.data);
                    let totalelem = document.getElementById('total');
                    totalelem.innerHTML = 'Total ' + data;
                    // console.log(totalelem);
                }
            });
        }

        function updateTime() {
            let newDate = new Date();
            let datetime = "LastSync: " + newDate.today() + " @ " + newDate.timeNow();
            let updateNag = document.getElementById("updated");
            updateNag.innerHtml = datetime;
            // console.log(datetime);
        }

        function createChart() {
            let chart = new CanvasJS.Chart("chartContainer", {
                theme: "dark2",
                animationEnabled: false,
                legend: {
                    fontFamily: "Tahoma"
                },
                data: [{
                    type: "pie",
                    indexLabelFontSize: 18,
                    radius: 200,
                    indexLabel: "{label} - {y}",
                    yValueFormatString: "###0",
                    dataPoints: chartData
                }]
            });
            chart.render();
        }

        function createTable() {
            let i = 1;
            chartData.forEach((group) => {
                tbody.innerHTML += "<tr><td>" + i + "</td><td>" + group.label + "</td><td>" + group.y + "</td></tr>";
                i++;
            });
        }

        /**
         * Execute GET Request against Server
         * @param resource
         * @param callback
         */
        function doGet(resource, callback) {

            let port = "";

            if (navigator.platform === "MacIntel") {
                port = ":8080";
            }

            let url = 'http://' + window.location.hostname + port + resource;
            let xhr = new XMLHttpRequest();
            xhr.open('GET', url, true);
            xhr.responseType = 'json';
            xhr.onload = function () {
                let status = xhr.status;
                let message = xhr.statusText;

                if (status === 200) {
                    callback(null, xhr.response);
                } else {

                    let error = {
                        "number": status,
                        "message": message
                    };

                    callback(error, xhr.response);
                }
            };
            xhr.send();
        }

        // For todays date;
        Date.prototype.today = function () {
            return ((this.getDate() < 10) ? "0" : "") + this.getDate() + "." + (((this.getMonth() + 1) < 10) ? "0" : "") + (this.getMonth() + 1) + "." + this.getFullYear();
        }

        // For the time now
        Date.prototype.timeNow = function () {
            return ((this.getHours() < 10) ? "0" : "") + this.getHours() + ":" + ((this.getMinutes() < 10) ? "0" : "") + this.getMinutes() + ":" + ((this.getSeconds() < 10) ? "0" : "") + this.getSeconds();
        }

    </script>

</div>

<script src="/static/js/jquery-3.2.1.min.js"></script>
<script src="/static/js/bootstrap.min.js"></script>
<script src="/static/js/bootstrap-confirmation.min.js"></script>

</body>
</html>