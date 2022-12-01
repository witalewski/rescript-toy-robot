switch FileReader.readCommands("commands.txt") {
| Ok(commands) =>
  CommandRunner.run(commands)
  ->Js.Array2.map(robot => robot->Robot.toString)
  ->Js.Array2.joinWith("\n")
  ->Js.Console.log
| Error(message) => message->Js.Console.error
}
