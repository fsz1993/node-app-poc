'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';
const ENV = process.env.ENV || 'DEV';
const { Client } = require('pg');
const client = new Client();
var msg;

client.connect();

const query = `
select message from messages where env='${ENV}';
`;

client.query(query, (err, res) => {
    if (err) {
        console.error(err);
        return;
    }
    for (let row of res.rows) {
        console.log(row);
        msg = row;
    }
    client.end();
});

// App
const app = express();
app.get('/', (req, res) => {
  res.send(msg);
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);