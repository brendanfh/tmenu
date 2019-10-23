import vendor/ncurses

var 
    mesg = "Enter a string: "
    row: cint
    col: cint

let pwin = initscr()
getmaxyx(pwin, row, col)
mvprintw(row div 2, (cint)((col - mesg.len) div 2), "%s", mesg)
getstr(mesg)
mvprintw(row - 2, 0, "You Entered: %s", mesg)
getch()
endwin()
