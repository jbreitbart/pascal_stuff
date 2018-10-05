uses crt, graph,alles;
{ca. 177 KB}
var treiber, modus,a,b : Integer;
    f : text;
    c : Byte;

procedure laden;
var a,b,lv1 : Laufvar;
    anzahl : word;
    farbe : byte;

begin
 anzahl:= 0;
 farbe:=255;
 lv1:=0;
 assign(f,'C:\pascal\test.mip');
 reset(f);
 FOR a:= 1 to getmaxx DO
 for b:= 240 to getmaxy DO begin
  if anzahl=lv1 then begin
   if eof(f) then exit;
   readln(f,anzahl);
   readln(f,farbe);
   lv1:=0;
  end;
  if farbe <> getbkcolor then putpixel(a,b,farbe);
  lv1:=lv1+1;
 end;
end;

procedure ladenalt;
var a,b : Integer;
    f : text;
    c : Byte;
    xy :laufvar;
begin
  assign(f,'c:\rise\bilder\menu.mip');
  reset(f);
  setbkcolor(black);
  cleardevice;
  for a:= 0 to getmaxx DO
  for b:= 220 to getmaxy DO begin
   readln(f,c);
   putpixel(a,b,c);
  end;
end;

procedure speichern;
var a,b : Word;
    farbe,farbealt : byte;
    anzahl : byte;
begin
 assign(f,'C:\pascal\test.mip');
 rewrite(f);
 for a:= 1 to getmaxx DO
 for b:= 240 to getmaxy DO begin
  farbe:=getpixel(a,b);
  if (a=1) and (b=240) then begin
   farbealt:=farbe;
   anzahl:=0;
  end;
  if farbealt=farbe then anzahl:=anzahl+1;
  if (farbealt <> farbe) or (anzahl=255) then begin
   writeln(f,anzahl);
   writeln(f,farbealt);
   anzahl:=1;
   farbealt:=farbe;
  end;
  putpixel(a,b,red);
 end;
 writeln(f,anzahl);
 writeln(f,farbealt);
 anzahl:=1;
 farbealt:=farbe;
end;

begin
  treiber:=detect;
  initgraph(treiber,modus,'');
  readln;
{  ladenalt;
  readln;
  speichern;}
  laden;
  readln;
  CloseGraph;
end.