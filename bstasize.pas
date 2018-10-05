uses crt,graph,alles;

var feld : array [1..13,1..13] of byte;
    akfarbe : Byte;
    Name : String;

procedure zeichnen;

var x,y : Integer;

begin
 akfarbe:=black;
 for x:=1 to 13 DO
 for y:=1 to 13 DO feld[x,y]:=white;
 setfillstyle(1,white);
 bar (200,100,486,386);
 x:=200;
 y:=100;
 setcolor(black);
 repeat
  line(x,100,x,386);
  x:=x+22;
 until x>=486;
 repeat
  line(200,y,486,y);
  y:=y+22;
 until y>=386;
 x:=12;
 y:=0;
 repeat
  if y <> 0 then begin
   setfillstyle(1,y);
   bar(x,440,x+30,470);
  end
  else begin
   setcolor(white);
   rectangle(x,440,x+30,470);
  end;
  y:=y+1;
  x:=x+39;
 until y=16;
 buttonschrift(560,0,639,30,'Beenden');
 buttonschrift(0,0,79,30,'Speichern');
 buttonschrift(90,0,169,30,'Laden');
 button(0,45,169,75);
 mouseinit;
 mouseshow;
end;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 zeichnen;
 readln;
 closegraph;
end.

 readtextlange(10,60,Name,8);
{13 x 13}