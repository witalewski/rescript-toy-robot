open Test
open Table

let eq = (a, b) => a == b

test("Table checks position validity", () => {
  let table = Table.make(~eastBoundary=3, ~northBoundary=5, ())
  assertion(
    eq,
    table->isValidPosition(~east=2, ~north=6),
    false,
    ~message="returns false if one of the coordinates is over the boundary",
  )
  assertion(
    eq,
    table->isValidPosition(~east=2, ~north=-1),
    false,
    ~message="returns false if one of the coordinates is below zero",
  )
  assertion(
    eq,
    table->isValidPosition(~east=0, ~north=0),
    true,
    ~message="returns true if both coordinates are equal to 0",
  )
  assertion(
    eq,
    table->isValidPosition(~east=3, ~north=5),
    true,
    ~message="returns true if both coordinates are equal to their boundaries",
  )
  assertion(
    eq,
    table->isValidPosition(~east=1, ~north=4),
    true,
    ~message="returns true if both coordinates are between 0 and their boundaries",
  )
})
