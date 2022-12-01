type t

let isValidPosition: (t, ~north: int, ~east: int) => bool

let make: (~northBoundary: int=?, ~eastBoundary: int=?, unit) => t
