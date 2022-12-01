// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Test = require("rescript-test/src/Test.bs.js");
var Table = require("../Table.bs.js");
var Caml_obj = require("rescript/lib/js/caml_obj.js");

var eq = Caml_obj.equal;

Test.test("Table checks position validity", (function (param) {
        var table = Table.make(5, 3, undefined);
        Test.assertion("returns false if one of the coordinates is over the boundary", undefined, eq, Table.isValidPosition(table, 6, 2), false);
        Test.assertion("returns false if one of the coordinates is below zero", undefined, eq, Table.isValidPosition(table, -1, 2), false);
        Test.assertion("returns true if both coordinates are equal to 0", undefined, eq, Table.isValidPosition(table, 0, 0), true);
        Test.assertion("returns true if both coordinates are equal to their boundaries", undefined, eq, Table.isValidPosition(table, 5, 3), true);
        Test.assertion("returns true if both coordinates are between 0 and their boundaries", undefined, eq, Table.isValidPosition(table, 4, 1), true);
      }));

exports.eq = eq;
/*  Not a pure module */