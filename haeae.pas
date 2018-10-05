Program Reaktion;

uses crt, graph, mouse, alles;

var grdriver, grmode : Integer;
    x,y,x1,y1,mx,my,schusse : word;
    punkte : integer;
    zeit, ende : real;
    color, knopf, runden, treffer: Byte;

procedure bestimmen;

begin
 x:=zufall(1,599);
 y:=zufall(1,359);
 x1:=x+zufall(5,30);
 y1:=y+zufall(5,30);
 color:=zufall(black+1,256);
end;

procedure hintergrund1;
var x,y : Integer;
begin
 for x := 0 to 640 DO
 for y := 0 to 480 DO
 putpixel(x,y,zufall(0,16));
 setcolor(white);
 SetTextJustify(CenterText, CenterText);
 settextstyle(2,0,20);
 outtextxy (320,240,'Level1');
end;

procedure feuern;
var s : integer;

Begin
 schusse := schusse + 1;
 setcolor(red);
 line(round(599/2),359,mx,my);
 line(round(599/2)-1,359,mx-1,my);
 line(round(599/2)+1,359,mx+1,my);
 for s := 3000 downto 2000 DO sound(s);
 delay(400);
 setcolor(black);
 line(round(599/2),359,mx,my);
 line(round(599/2)-1,359,mx-1,my);
 line(round(599/2)+1,359,mx+1,my);
 nosound;
 cleardevice;
 hintergrund1;
 setcolor(color);
 rectangle (x,y,x1,y1);
 punkte:=punkte-1;
end;

procedure punkten;
var fullx,fully,s : integer;

Begin
 treffer := treffer + 1;
 if x1 - x >= 20 then punkte := punkte + 7;
 if x1 - x >= 10 then punkte := punkte + 13;
 if x1 - x <  10 then punkte := punkte + 26;
 mousehide;
 for fullx := x to x1 DO
 for fully := y to y1 DO putpixel (fullx,fully,color);
 delay (300);
 nosound;
 mouseshow;
end;

Begin
 Mouseinit;
 grdriver:=Detect;
 grmode:=1;
 InitGraph(grDriver,grMode,'');
 mousewindow(1,1,599,359);
 mousegotoxy(round(getmaxx/2),round(getmaxy/2));
 punkte:=0;
 runden:=0;
 treffer:=0;
 schusse:=0;
 ende:=9999;
 repeat
  hintergrund1;
  bestimmen;
  setcolor (color);
  rectangle (x,y,x1,y1);
  mouseshow;
  zeit :=0;
  repeat
   mx:=mousexpos;
   my:=mouseypos;
   knopf:=mousebutton;
   zeit:=zeit+0.1;
   if knopf = mousebuttonleft then feuern;
   if (mx>x) and (mx<x1) and (my>y) and (my<y1) and (knopf=mousebuttonleft) then punkten;
   if zeit >= ende then punkte := punkte - 10;
  until (mx>x) and (mx<x1) and (my>y) and (my<y1) and (knopf=mousebuttonleft) or (zeit>=ende);
  mousehide;
  cleardevice;
  runden:=runden+1;
  ende:= ende - 1;
 until runden = 20;
 closegraph;
 writeln('Sie haben ',punkte,' Punkte und ',treffer,' Treffer erziehlt!');
 writeln('Sie ben”tigten ',schusse,' Schsse!');
 readln;
end.