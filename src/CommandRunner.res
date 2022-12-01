let executeCommand = (simulation, command) =>
  switch (simulation, command->Js.String2.split(" ")) {
  | (Some(simulation), ["MOVE"]) => (Some(simulation->Simulation.move), None)
  | (Some(simulation), ["LEFT"]) => (Some(simulation->Simulation.turnLeft), None)
  | (Some(simulation), ["RIGHT"]) => (Some(simulation->Simulation.turnRight), None)
  | (Some(simulation), ["REPORT"]) => (Some(simulation), Some(simulation->Simulation.report))
  | (_, ["PLACE", coords]) =>
    switch coords->Js.String2.split(",") {
    | [east, north, facing] =>
      switch (east->Belt.Int.fromString, north->Belt.Int.fromString, facing->Robot.parseFacing) {
      | (Some(east), Some(north), Some(facing)) =>
        switch Table.make()->Simulation.place(~east, ~north, ~facing) {
        | Ok(simulation) => (Some(simulation), None)
        | Error(_) => (None, None)
        }
      | _ => (None, None)
      }
    | _ => (None, None)
    }
  | (simulation, _) => (simulation, None)
  }

let rec runRecursive = (simulation, commandList, output) =>
  switch (simulation, commandList) {
  | (simulation, list{finalCommand}) =>
    switch simulation->executeCommand(finalCommand) {
    | (_, None) => output
    | (_, Some(robot)) => output->Js.Array2.concat([robot])
    }
  | (simulation, list{command, ...tail}) =>
    switch simulation->executeCommand(command) {
    | (simulation, None) => simulation->runRecursive(tail, output)
    | (simulation, Some(robot)) => simulation->runRecursive(tail, output->Js.Array2.concat([robot]))
    }
  | (_, list{}) => output
  }

let run = commands => runRecursive(None, Belt.List.fromArray(commands), [])
