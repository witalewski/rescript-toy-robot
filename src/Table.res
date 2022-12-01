type t = {
  northBoundary: int,
  eastBoundary: int,
}

let isValidPosition = (table, ~north, ~east) =>
  north >= 0 && north <= table.northBoundary && east >= 0 && east <= table.eastBoundary

let make = (~northBoundary=4, ~eastBoundary=4, ()) => {
  northBoundary,
  eastBoundary,
}
