#!/usr/bin/env node
var fs = require('fs');
var os = require('os');


fs.readFile(process.argv[2], { encoding: 'utf-8' }, function (err, content) {
    if (err) {
        throw err;
    }

    content.toString().split(os.EOL).forEach(function (line) {
        var trimmed = line.trim();
        if (trimmed) {
            console.log(calcSum(JSON.parse(trimmed)));
        }
    });
});


function calcSum(obj) {
    return obj.menu.items.reduce(function (a, b) {
        if (b && b.label) {
            return a + b.id;
        }
        return a;
    }, 0);
}
