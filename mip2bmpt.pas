uses crt,graph,alles;

PROCEDURE LoadBMP(Dat : String);
{ Dieser LoadBMP - Befehl schafft es leider nur, Windows - BMPs mit einer
  Gr”áe von 640 x 480 bei 256 Farben zu laden                             }
VAR X, Y : Integer;
    Datei : File;
    f : File;
    Colour : Array[0..639] Of Byte;
BEGIN
 Assign(Datei,Dat+'.BMP');
 Reset(Datei,1);
 assign(f,'C:\pascal\data\menu1.mip');
 rewrite(f,1);
 { Bitmap - Informationen berspringen }
 seek(datei,53);
 { Paletten - Informationen einlesen und Palette bearbeiten }
 For x:=0 To 255 Do
 Begin
   BlockRead(Datei,colour,4);
   blockwrite(f,colour,4);
   if (x>0) and (x<>white) then SetRGBPalette(x,Round(colour[3]/255*62),Round(colour[2]/255*62),Round(colour[1]/255*62));
 End;
 {0 als Palettenendezeichen}
 seek(datei,filepos(datei)+1);
 { Bitmap einlesen und auf Bildschirm darstellen }
 For Y:=479 DownTo 0 Do Begin
  BlockRead(Datei,Colour,640);
  For X:=0 To 639 Do PutPixel(X,Y,Colour[X]);
 End;
 { Datei schlieáen }
 Close(Datei);
 close(f);
END;

procedure speichern;

var f : File;
    farbe : Byte;
    a     : Array [1..1278] of byte;
    x,y,lauf : Word;

begin
 assign(f,'C:\pascal\data\menu1.mip');
 reset(f,1);
 lauf:=1;
 for y:=0 to getmaxy DO
 for x:=0 to getmaxx DO begin
  farbe:=getpixel(x,y);
  a[lauf]:=farbe;
  lauf:=lauf+1;
  if (lauf=1279) or (y=479) then begin
   lauf:=1;
   blockwrite(f,a,1278);
  end;
 end;
 close(f);
end;

procedure neuladen;
var farbe : Byte;
    x,y,x1,y1 : Word;
    f : File;
    ar : Array [0..639] of Byte;
    lv1 : Laufvar;
begin
 assign(f,'c:\pascal\data\menu1.mip');
 reset(f,1);
 For x:=0 To 255 Do Begin
  BlockRead(f,ar,4);
  if (x>0) and (x<>white) then SetRGBPalette(x,Round(ar[3]/255*62),Round(ar[2]/255*62),Round(ar[1]/255*62));
 End;
 x:=0;
 y:=0;
 x1:=x;
 y1:=y;
 lv1:=0;
 farbe:=30;
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
end;

begin
 grd:=installuserdriver('vesa',nil);
 grm:=2;
 initgraph(grd,grm,'');
 loadbmp('menu');
 speichern;
 cleardevice;
 readln;
 neuladen;
 mouseinit;
 mouseshow;
 readln;
 closegraph;
end.