import os, strutils
import illwill

import parser

when isMainModule:
  var args = readArgs()

#  proc exitProc() {.noconv.} =
#    illwillDeinit()
#    showCursor()
#    quit(0)
#
#  illwillInit(fullscreen=true)
#  setControlCHook(exitProc)
#  hideCursor()
#
#  var tb = newTerminalBuffer(terminalWidth(), terminalHeight())
#  tb.setForegroundColor(fgBlack, true)
#  tb.drawRect(0, 0, 40, 5)
#  tb.drawHorizLine(2, 38, 3, doubleStyle=true)
#
#  tb.write(2, 1, fgWhite, "Press any key to display its name")
#  tb.write(2, 2, "Press ", fgYellow, "ESC", fgWhite, " or ", fgYellow, "Q", fgWhite, " to quit")
#
#  while true:
#    var bb = newBoxBuffer(tb.width, tb.height)
#    bb.draw_rect(0, 0, tb.width - 1, 5)
#    tb.write(fgWhite)
#    tb.write(bb)
#
#    var key = getKey()
#    case key
#    of Key.None: discard
#    of Key.Escape, Key.Q: exitProc()
#    else:
#      tb.write(8, 4, ' '.repeat(31))
#      tb.write(2, 4, resetStyle, "Key pressed: ", fgGreen, $key)
#
#    tb.display()
#    sleep(20)
