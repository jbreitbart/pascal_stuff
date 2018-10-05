uses alles,graph,crt;

procedure ladenalt;
var c : Byte;
    f : text;
    a,b : word;
begin
 assign(f,'C:\pascal\bilder\menu1.mip');
 reset(f);
 for a:= 0 to getmaxx DO
 for b:= 220 to getmaxy DO begin
  readln(f,c);
  if c<>getbkcolor then putpixel(a,b,c);
 end;
end;

procedure speichern;
var c : Byte;
    a,b,lv1 : Word;
    f : File;
    ar : Array [0..639] of Byte;

begin
 assign(f,'C:\pascal\bilder\menu.mip');
 rewrite(f,1);
 lv1:=0;
 for b:= 220 to getmaxy DO
 for a:= 0 to getmaxx DO begin
  c:=getpixel(a,b);
  ar[lv1]:=c;
  lv1:=lv1+1;
  if lv1=640 then begin
   lv1:=0;
   blockwrite(f,ar,sizeof(ar));
  end;
 end;
 close(f);
end;

procedure ladenplanet;
var c : Byte;
    a,b : Word;
    f : File;
    ar : Array [0..639] of Byte;
begin
 assign(f,'C:\pascal\bilder\planet.mip');
 reset(f,1);
 for b:= 220 to getmaxy DO
 for a:= 0 to getmaxx DO begin
  if a=0 then blockread(f,ar,sizeof(ar));
  putpixel(a,b,ar[a]);
 end;
end;

begin
 grd:=detect;
 initgraph(grd,grm,'');
 readln;
 ladenalt;
 readln;
 speichern;
 cleardevice;
 readln;
 ladenplanet;
 readln;
 closegraph;
end.