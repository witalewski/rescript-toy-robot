type facing = North | West | South | East

type t = {
  north: int,
  east: int,
  facing: facing,
}

let move = robot =>
  switch robot.facing {
  | North => {...robot, north: robot.north + 1}
  | West => {...robot, east: robot.east - 1}
  | South => {...robot, north: robot.north - 1}
  | East => {...robot, east: robot.east + 1}
  }

let turnLeft = robot =>
  switch robot.facing {
  | North => {...robot, facing: West}
  | West => {...robot, facing: South}
  | South => {...robot, facing: East}
  | East => {...robot, facing: North}
  }

let turnRight = robot =>
  switch robot.facing {
  | North => {...robot, facing: East}
  | West => {...robot, facing: North}
  | South => {...robot, facing: West}
  | East => {...robot, facing: South}
  }

let parseFacing = facingString =>
  switch facingString {
  | "NORTH" => Some(North)
  | "WEST" => Some(West)
  | "SOUTH" => Some(South)
  | "EAST" => Some(East)
  | _ => None
  }

let toString = robot =>
  robot.east->Belt.Int.toString ++
  "," ++
  robot.north->Belt.Int.toString ++
  "," ++
  switch robot.facing {
  | North => "NORTH"
  | West => "WEST"
  | South => "SOUTH"
  | East => "EAST"
  }
