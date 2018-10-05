PROGRAM GRAPHICS;

uses Graph, Crt;

var grDriver, grMode : Integer;
var x, x1, y, y1 : LONGINT;

begin
 CLRSCR;
 x1 := 0;
 x  := 320;
 y  := 240;
 grDriver := Detect;
 InitGraph(grDriver,grMode,'');
  RANDOMIZE;
  SETCOLOR (RANDOM (50));
  REPEAT;
   BEGIN
    X1:= X1 + 2;
    CIRCLE (X,Y,X1);
    DELAY (30);
   END;
  UNTIL X1 = 150;
  MoveTo (180,235);
  SETCOLOR (BLACK);
  SetTextStyle (DefaultFont,0,2);
  OutText ('Offizeller Fanclub');
  readln;
 CLOSEGRAPH;
end.
