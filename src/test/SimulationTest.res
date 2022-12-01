open Test
open Simulation

let eq = (a, b) => a == b

test("Simulation places a robot", () => {
  let table = Table.make(~northBoundary=5, ~eastBoundary=3, ())
  assertion(
    eq,
    table->place(~east=1, ~north=2, ~facing=North),
    Ok({
      table,
      robot: {
        east: 1,
        north: 2,
        facing: North,
      },
    }),
    ~message="returns ok of simulation if placement is valid",
  )
  assertion(
    eq,
    table->place(~east=5, ~north=2, ~facing=North),
    Error("Placement outside bounds"),
    ~message="returns error if placement isn't valid",
  )
})

test("Simulation moves a robot and reports", () => {
  let robot: Robot.t = {
    east: 0,
    north: 0,
    facing: North,
  }
  let table = Table.make(~northBoundary=4, ~eastBoundary=4, ())
  let simulation = {
    table,
    robot,
  }
  assertion(
    eq,
    simulation
    ->turnRight
    ->move
    ->move
    ->turnLeft
    ->move
    ->move
    ->move
    ->move
    ->move
    ->move
    ->move
    ->move
    ->turnRight
    ->report,
    {
      north: 4,
      east: 2,
      facing: East,
    },
    ~message="robot follows a set of commands successfully",
  )
  assertion(
    eq,
    simulation->move->move->move->turnLeft->move->turnLeft->move->report,
    {
      north: 2,
      east: 0,
      facing: South,
    },
    ~message="robot follows all commands except those that would make it fall",
  )
  assertion(
    eq,
    simulation->move->turnRight->move->turnRight->move->turnRight->move->turnRight->report,
    {
      north: 0,
      east: 0,
      facing: North,
    },
    ~message="robot makes a small loop",
  )
  assertion(
    eq,
    simulation
    ->move
    ->move
    ->turnRight
    ->move
    ->move
    ->turnRight
    ->move
    ->move
    ->turnRight
    ->move
    ->move
    ->turnRight
    ->report,
    {
      north: 0,
      east: 0,
      facing: North,
    },
    ~message="robot makes a larger loop",
  )
  assertion(
    eq,
    simulation
    ->move
    ->turnRight
    ->move
    ->turnLeft
    ->move
    ->turnRight
    ->move
    ->turnLeft
    ->move
    ->turnRight
    ->move
    ->turnLeft
    ->move
    ->turnRight
    ->move
    ->turnLeft
    ->report,
    {
      north: 4,
      east: 4,
      facing: North,
    },
    ~message="robot zigzags to the opposite corner",
  )
})
