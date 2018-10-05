uses crt,graph,alles;

var x,y,xalt,yalt,geschw,mx,my : Word;

procedure put(x,y : Word);
begin
 setfillstyle(1,9);
 bar(x-2,y-2,x+2,y+2);
end;

procedure putweg(x,y : Word);
begin
 setfillstyle(0,black);
 bar(x-2,y-2,x+2,y+2);
end;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 mouseinit;
 mouseshow;
 geschw:=1;
 repeat
  x:=320;
  y:=479;
  repeat
   mousegotoxy(320,0);
  until mousebutton=mousebuttonleft;
  repeat
   mx:=mousexpos;
   my:=mouseypos;
   if mouseinwindow(x-geschw,y-geschw,x+geschw,y+geschw) then halt;
   put(x,y);
   xalt:=x;
   yalt:=y;
   if (x<mx) then x:=x+geschw;
   if (x>mx) then x:=x-geschw;
   if (y<my) then y:=y+geschw;
   if (y>my) then y:=y-geschw;
   if mouseinwindow(x-geschw,y-geschw,x+geschw,y+geschw) then halt;
   if (y<=460) then buttonschrift(1,460,639,478,'Ziel');
   delay(250);
   putweg(xalt,yalt);
   if mouseinwindow(x-geschw,y-geschw,x+geschw,y+geschw) then halt;
  until mouseinwindow(1,460,640,480);
  geschw:=geschw+1;
 until 2=3;
 closegraph;
end.