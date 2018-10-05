uses crt,graph,alles,dos;

var f : File;
    ar : Array [0..639] of Byte;
    x,y,x1,y1,lv1,farbe : Word;
    h,s,m,s100,h2,s2,m2,s200 : Word;
begin
 grd:=detect;
 initgraph(grd,grm,'');
 gettime(h,m,s,s100);
 assign(f,'C:\pascal\data\planet.mip');
 reset(f,1);
 x:=0;
 y:=220;
 x1:=x;
 y1:=y;
 lv1:=0;
 farbe:=30;
 reset(f,1);
 blockread(f,ar,sizeof(ar));
 repeat
  repeat
   if lv1=0 then farbe:=ar[0];
   if (ar[lv1]=farbe) then x1:=x1+1;
   if lv1 <> 639 then lv1:=lv1+1;
  until (lv1=639) or (ar[lv1]<>farbe);
  if lv1=639 then begin
   setcolor(farbe);
   line(x,y,x1,y1);
   x:=0;
   lv1:=0;
   x1:=x;
   y:=y+1;
   y1:=y;
   blockread(f,ar,sizeof(ar));
  end
  else begin
   setcolor(farbe);
   line(x,y,x1,y1);
   x:=x1;
   x1:=x1;
   farbe:=ar[lv1];
  end;
 until y=getmaxy;

 gettime(h2,m2,s2,s200);
 closegraph;
 writeln(h,' ',m,' ',s,' ',s100);
 writeln(h2,' ',m2,' ',s2,' ',s200);
 halt;
 close(f);
 closegraph;
end.