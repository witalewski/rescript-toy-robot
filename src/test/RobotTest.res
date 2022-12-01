open Test
open Robot

let eq = (a, b) => a == b

test("Robot facing north", () => {
  let robot = {north: 0, east: 0, facing: North}
  assertion(eq, robot->move, {...robot, north: 1}, ~message="moves north")
  assertion(eq, robot->move->move, {...robot, north: 2}, ~message="moves 2 fields north")
  assertion(eq, robot->turnLeft, {...robot, facing: West}, ~message="turns left to the west")
  assertion(eq, robot->turnRight, {...robot, facing: East}, ~message="turns right to the east")
})

test("Robot facing west", () => {
  let robot = {north: 0, east: 0, facing: West}
  assertion(eq, robot->move, {...robot, east: -1}, ~message="moves west")
  assertion(eq, robot->move->move->move, {...robot, east: -3}, ~message="moves 3 fields west")
  assertion(eq, robot->turnLeft, {...robot, facing: South}, ~message="turns left to the south")
  assertion(eq, robot->turnRight, {...robot, facing: North}, ~message="turns right to the north")
  assertion(
    eq,
    robot->turnRight->turnRight,
    {...robot, facing: East},
    ~message="turns right, then right again to the east",
  )
})

test("Robot facing south", () => {
  let robot = {north: 0, east: 0, facing: South}
  assertion(eq, robot->move, {...robot, north: -1}, ~message="moves south")
  assertion(eq, robot->turnLeft, {...robot, facing: East}, ~message="turns left to the east")
  assertion(eq, robot->turnRight, {...robot, facing: West}, ~message="turns right to the west")
  assertion(
    eq,
    robot->turnLeft->turnRight,
    {...robot, facing: South},
    ~message="turns left, then right back to the south",
  )
})

test("Robot facing east", () => {
  let robot = {north: 0, east: 0, facing: East}
  assertion(eq, robot->move, {...robot, east: 1}, ~message="moves east")
  assertion(eq, robot->turnLeft, {...robot, facing: North}, ~message="turns left to the north")
  assertion(eq, robot->turnRight, {...robot, facing: South}, ~message="turns right to the south")

  assertion(
    eq,
    robot->turnRight->move,
    {...robot, north: -1, facing: South},
    ~message="turns right to the south, then moves",
  )
})
