import docopt
import os
import strutils

type
  ParserArgs* = ref object
    t*: string
    height*: uint
    layout*: string
    incremental*: bool
    exact*: bool
    sort*: bool
    case_sensitive*: bool
    multi_select*: bool
    preview*: string
    input*: string

let doc = """
tmenu

Usage:
  tmenu [--type=<t>] [--height=<h>] [--layout=<lay>] [--incremental] [--exact] [+s|--no-sort] [+i] [--multi|--multi-select] [--preview=<prev_cmd>] [--bind=<bindings>] [--delimiter=<del>] [+x|--no-extended]

Options:
  --type=(default|d|dir|f|file)
  --height=<h>
  --layout=(default|reverse|reverse-list)
  --incremental
  --exact
  +s --no-sort
  +i
  --multi --multi-select
  --preview=<prev_cmd>
  --bind=<bindings>
  +x --no-extended
  --delimiter=<del>

Bindings:
  FORMAT:
    key:action1+action2;key2:action3

  keys:
    backspace
    enter
    delete
    

"""

proc readArgs*(): ParserArgs =
  let args = docopt(doc, version="tmenu 0.1")
  var
    t = "default"
    start_dir = getCurrentDir()
    height: uint = 0
    layout = "default"
    incremental = args["--incremental"]
    exact = args["--exact"]
    sort = not args["--no-sort"] and not args["+s"]
    case_sensitive = args["+i"]
    multi_select = args["--multi"] or args["--multi-select"]
    preview = if args["--preview"]: $args["--preview"] else: ""
    input = ""

  try:
    if getFileSize(stdin) > 0:
      input = readAll(stdin)
  except IOError: # An IOError is thrown when you try to read the input from `echo "asdf" | parser`
    input = readAll(stdin)

  if args["--type"]:
    doAssert $args["--type"] in ["default", "d", "dir", "f", "file"]
    t = $args["--type"]
  if args["--start-dir"]:
    doAssert existsDir expandTilde $args["--start-dir"]
    start_dir = $args["--start-dir"]
  if args["--height"]:
    try:
      height = parseUint($args["--height"])
    except ValueError:
      echo "--height=<h> must be an unsigned integer"
      quit(QuitFailure)
  if args["--layout"]:
    doAssert $args["--layout"] in ["default", "reverse", "reverse-list"]
    layout = $args["--layout"]

  return ParserArgs(
    t: t,
    start_dir: start_dir,
    height: height,
    layout: layout,
    exact: exact,
    sort: sort,
    incremental: incremental,
    case_sensitive: case_sensitive,
    multi_select: multi_select,
    preview: preview,
    input: input
  )
