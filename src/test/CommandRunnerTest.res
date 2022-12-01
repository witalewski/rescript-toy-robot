open Test
open CommandRunner

let eq = (a, b) => a == b

test("Runs commands", () => {
  assertion(
    eq,
    run(["PLACE 1,2,NORTH", "MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "REPORT"]),
    [{east: 0, north: 4, facing: North}],
    ~message="Valid commands list",
  )

  assertion(eq, run([]), [], ~message="Empty commands list")

  assertion(
    eq,
    run(["PLACE 1,2,NORTH", "MOVE", "LEFT", "MOVE", "SPIN AND TWIRL", "MOVE", "REPORT"]),
    [{east: 0, north: 3, facing: West}],
    ~message="Commands with an unimportant invalid command",
  )

  assertion(
    eq,
    run(["MOVE", "LEFT", "MOVE", "PLACE 1,2,NORTH", "RIGHT", "MOVE", "REPORT"]),
    [{east: 2, north: 2, facing: East}],
    ~message="Commands with PLACE command later in the list",
  )

  assertion(
    eq,
    run([
      "PLACE 1,2,NORTH",
      "PLACE 1,2,NORTH",
      "MOVE",
      "LEFT",
      "REPORT",
      "MOVE",
      "SPIN AND TWIRL",
      "MOVE",
      "REPORT",
    ]),
    [{east: 1, north: 3, facing: West}, {east: 0, north: 3, facing: West}],
    ~message="Commands with duplicate PLACE and REPORT commands",
  )

  assertion(
    eq,
    run([
      "PLACE 1",
      "PLACE",
      "PLACE 1,2,3,4",
      "MOVE",
      "PLACE 1,2,NORTH",
      "MOVE",
      "LEFT",
      "MOVE",
      "SPIN AND TWIRL",
      "MOVE",
      "REPORT",
    ]),
    [{east: 0, north: 3, facing: West}],
    ~message="Commands with valid PLACE command following invalid attempts",
  )

  assertion(
    eq,
    run([
      "PLACE 1,2,NORTH",
      "MOVE",
      "LEFT",
      "MOVE",
      "RIGHT",
      "MOVE",
      "REPORT",
      "MOVE",
      "RIGHT",
      "TWIST AND SHOUT",
    ]),
    [{east: 0, north: 4, facing: North}],
    ~message="Commands with trailing commands after REPORT",
  )

  assertion(
    eq,
    run(["MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "REPORT"]),
    [],
    ~message="Commands with missing PLACE command",
  )

  assertion(
    eq,
    run(["PLACE 1,SOUTH,NORTH", "MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "REPORT"]),
    [],
    ~message="Commands with invalid PLACE argument",
  )

  assertion(
    eq,
    run(["PLACE 1,2,NORTH,42", "MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "REPORT"]),
    [],
    ~message="Commands including PLACE with too many arguments",
  )

  assertion(
    eq,
    run(["PLACE 1", "MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "REPORT"]),
    [],
    ~message="Commands including PLACE with too few arguments",
  )

  assertion(
    eq,
    run(["PLACE", "MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "REPORT"]),
    [],
    ~message="Commands including PLACE with no arguments",
  )

  assertion(
    eq,
    run(["PLACE 1,2,NORTH", "MOVE", "LEFT", "MOVE", "RIGHT", "MOVE", "MOVE"]),
    [],
    ~message="Commands with missing REPORT command in the end",
  )
})
