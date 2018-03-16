import strutils, 
  sets

type

  Settings* = object
    targetFile*: string
    searchPattern*: string
    columnsCount*: int
    countMatches*: bool

    error*: string

proc fromError(message: string): Settings =
  return Settings(error: message)

proc fillFrom*(params: seq[string]): Settings =
  if params.len < 2:
    return fromError("file name and search pattern must be specified")
  let result = Settings(
    targetFile: params[0],
    searchPattern: params[1])
  
  let paramsSet = params.toSet()

  if paramsSet.contains()