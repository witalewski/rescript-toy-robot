// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Robot = require("./Robot.bs.js");
var $$FileReader = require("./FileReader.bs.js");
var CommandRunner = require("./CommandRunner.bs.js");

var commands = $$FileReader.readCommands("commands.txt");

if (commands.TAG === /* Ok */0) {
  console.log(CommandRunner.run(commands._0).map(Robot.toString).join("\n"));
} else {
  console.error(commands._0);
}

/* commands Not a pure module */