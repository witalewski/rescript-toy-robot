type t = {
  robot: Robot.t,
  table: Table.t,
}

let place = (table, ~north, ~east, ~facing) =>
  table->Table.isValidPosition(~north, ~east)
    ? Ok({
        robot: {
          north,
          east,
          facing,
        },
        table,
      })
    : Error("Placement outside bounds")

let move = simulation => {
  let movedRobot = simulation.robot->Robot.move
  {
    ...simulation,
    robot: simulation.table->Table.isValidPosition(~north=movedRobot.north, ~east=movedRobot.east)
      ? movedRobot
      : simulation.robot,
  }
}

let turnLeft = simulation => {
  ...simulation,
  robot: simulation.robot->Robot.turnLeft,
}
let turnRight = simulation => {
  ...simulation,
  robot: simulation.robot->Robot.turnRight,
}

let report = simulation => simulation.robot
