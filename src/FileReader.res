let readCommands = fileName =>
  try {
    Ok(NodeJs.Fs.readFileSync(fileName)->NodeJs.Buffer.toString->Js.String2.split("\n"))
  } catch {
  | _ => Error("Failed to read commands from " ++ fileName)
  }
