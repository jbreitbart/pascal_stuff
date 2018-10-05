Program Leiste;

uses crt, graph, dos, alles;

var x, y, x1, y1,a,b :integer;
    grdriver, grmode:integer;
    buh : Boolean;

procedure l;

begin
 buh:=true;
 x:=1;
 y:=1;
 x1:=getmaxx;
 y1:=70;
 rectangle (x, y, x1, y1);
 FOR a:= x to x1 DO
 for b:= y to y1 DO putpixel(a,b,28);
 settextstyle(2,0,9);
 setcolor(0);
 outtextxy (22,17,'LOAD');
 rectangle (10,14,100,56);
 outtextxy (122,17,'SAVE');
 rectangle (110, 14, 200, 56);
 outtextxy (230,17,'NEW');
 rectangle (210,14,300,56);
 outtextxy (322,17,'SOUND');
 rectangle (310,14,423,56);
 outtextxy (922,17,'QUIT');
 rectangle (910,14,1000,56);
 if mouseinwindow(10,14,100,56) and (MOUSEBUTTON=MOUSEBUTTONLEFT) then halt;
 if Mouseinwindow(110,14,200,56) and (Mousebutton=mousebuttonleft) then halt;
 if mouseinwindow(210,14,300,56) and (mousebutton=mousebuttonleft) then halt;
 if mouseinwindow(310,14,423,56) and (mousebutton=mousebuttonleft) then halt;
 if mouseinwindow(910,14,1000,56) and (mousebutton=mousebuttonleft) then halt;
end;

begin
 grdriver :=INSTALLUSERDRIVER('svga256',nil);
 grmode:=4;
 initgraph (grdriver, grmode, '');
 mouseinit;
 mouseshow;
 repeat
  putpixel(mousexpos,mouseypos,red);
  if mouseinwindow(1,1,getmaxx,70) then l;
  if NOT (mouseinwindow(1,1,getmaxx,70)) and (buh=true) then begin
                                              FOR a:= x to x1 DO
                                              for b:= y to y1 DO putpixel(a,b,0);
                                             end;

 until keypressed;
 readln;
 closegraph;
end.