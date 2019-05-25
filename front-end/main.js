$(document).ready(function () {
    $.ajax({
        url: 'http://localhost:3000/currency',
        headers: {'Access-Control-Allow-Origin': '*'},
        method: 'GET',
        contentType: "application/json",
        dataType: 'json',
        crossDomain: true,
        success: function (response) {
            let trHTML = '';
            for (let i = 0; i < response.length; i++) {
                let id = response[i].id;
                let from1 = response[i].from;
                let to = response[i].to;
                trHTML = trHTML +
                    '<tr>' +
                    '<td>' + from1 + '</td>' +
                    '<td>' + to + '</td>' +
                    '<td>' +
                    '<button onclick="showCurrency(\'' + id  +'\',\'' + from1 + '\',\'' + to  + '\');">Show</button>' +
                    '<button onclick="deleteCurrency(' + id + ');">Delete</button>' + '<td>' +
                    '<p>Rate</p><input type="text" id="rate" value="">' + '</td>' + '<td>' +
                    '<p>Date</p><input type="date" id="date" value="">' + 
                    '<button onclick="insertRate(' +id + ')">Insert</button>' + '</td>' +
                    '</td>' +
                    '</tr>';
            }
            $('#tBody').append(trHTML);
        },
        error: function (response) {
        }
    });
});

function deleteCurrency(url_id) {
    $.ajax({
        url: 'http://localhost:3000/currency/' + url_id,
        headers: {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json',
            'Access-Control-Allow-Methods': '*'
        },
        type: 'DELETE',
        crossDomain: true,
        success: function (result) {
            // Do something with the result
            alert('deleted')
        }
    });
}

function showCurrency(url_id, from1, to) {

    console.log(from1, to);
    $.ajax({
        url: 'http://localhost:3000/history/' + url_id,
        headers: {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json',
            'Access-Control-Allow-Methods': '*'
        },
        type: 'GET',
        crossDomain: true,
        success: function (response) {
            // Do something with the result
            let trHTML = '';
            console.log(response);
            trHTML = trHTML +
                '<p>From : ' + from1 + '</p>' +
                '<p>To : ' + to + '</p>' +
                '<p>Average : ' + response.average + '</p>' +
                '<p>Variance : ' + response.variance + '</p>'
            let rates = response.rates;
            let trHTML1 = '';
            for (let i = 0; i < rates.length; i++) {
                let id = rates[i].id;
                trHTML1 = trHTML1 +
                    '<tr>' +
                    '<td>' + rates[i].date + '</td>' +
                    '<td>' + rates[i].rate + '</td>' +
                    '</tr>';
            }
            $('#detailCurrency').append(trHTML);
            $('#detailWeeks').append(trHTML1)
        }
    });
}

function rateIndex() {
    var date = document.getElementById("date").value;
    $.ajax({
        url: 'http://localhost:3000/history/index/' + date,
        headers: {
            'Access-Control-Allow-Origin': '*',
            'Content-Type': 'application/json',
            'Access-Control-Allow-Methods': '*'
        },
        type: 'GET',
        crossDomain: true,
        success: function (response) {
            let trHTML = ''
            for (let i = 0; i < response.length; i++) {
                let average = response[i].average;
                let currency = response[i].currency;
                trHTML = trHTML +
                    '<tr>' +
                    '<td>' + currency.from + '</td>' +
                    '<td>' + currency.to + '</td>' +
                    '<td>' + average + '</td>' +
                    '</tr>';
            }
            $('#tAverage').append(trHTML);
        }
    });
}
function createCurrency() {
    var from = document.getElementById("from").value;
    var to = document.getElementById("to").value;
    $.ajax(
        {
            type: 'POST',
            url: 'http://localhost:3000/currency',
            data: {
                exchangeable_currency: {
                    "from": from,
                    "to": to
                }
            },
            success: function (response) {
                alert("Success !!");
            },
            error: function () {
                alert("Error !!");
            }
        }
    );
}

function insertRate(id) {
    var rate = document.getElementById("rate").value;
    var date = document.getElementById("date").value;
    $.ajax(
        {
            type: 'POST',
            url: 'http://localhost:3000/history',
            data: {
                    "rate": rate,
                    "date": date,
                    "exchangeable_currency_id": id
            },
            success: function (response) {
                alert("Success !!");
            },
            error: function () {
                alert("Error !!");
            }
        }
    );
}