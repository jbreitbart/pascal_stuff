uses crt,alles,graph;

var x1,y1,x2,y2 : Word;

procedure mousefeld(x1,y1,x2,y2: Word);

var lv1,lv2 : Laufvar;
    xm,ym,xmalt,ymalt,xm1,ym1 : Word;
    arx : array [0..640] of byte;
    ary : array [0..480] of byte;

begin
 if mousebutton=mousebuttonleft then begin
  xm1:=mousexpos;
  ym1:=mouseypos;
  xmalt:=xm1;
  ymalt:=ym1;
  xm:=xm1;
  ym:=ym1;
  mousewindow(xm1,ym1,getmaxx+1,getmaxy+1);
  for lv1:=0 to 639 DO arx[lv1]:=0;
  for lv1:=0 to 479 DO ary[lv1]:=0;
 end;
 while mousebutton=mousebuttonleft DO begin
  xm:=mousexpos;
  ym:=mouseypos;

   for lv1 := 0 to (xm-xm1) DO arx[lv1]:=getpixel(lv1,ym1);
   for lv1 := 0 to (ym-ym1) DO ary[lv1]:=getpixel(xm1,lv1);
   mousehide;
   for lv1 := 0 to (xm-xm1) DO putpixel(xm1+lv1,ym1,white);
   for lv1 := 0 to (ym-ym1) DO putpixel(xm1,ym1+lv1,white);
   delay(50);
   for lv1 := 0 to (xm-xm1) DO putpixel(xm1+lv1,y1,arx[lv1]);
   for lv1 := 0 to (ym-ym1) DO putpixel(xm1,ym1+lv1,ary[lv1]);
   mouseshow;

  xmalt:=xm;
  ymalt:=ym;
 end;
 mousewindow(0,0,getmaxx+1,getmaxy+1);
 x1:=xm1;
 y1:=ym1;
 x2:=xm;
 y2:=ym;
end;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 mouseinit;
 mouseshow;
 repeat
  if mousebutton=mousebuttonleft then mousefeld(x1,y1,x2,y2);
 until keypressed;
 closegraph;
end.