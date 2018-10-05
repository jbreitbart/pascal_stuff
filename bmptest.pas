PROGRAM BitmapLaden;

USES Crt, Graph, Gemischt,alles;

PROCEDURE LoadBMP(Dat : String);
{ Dieser LoadBMP - Befehl schafft es leider nur, Windows - BMPs mit einer
  Grî·e von 640 x 480 bei 256 Farben zu laden                             }
VAR X, Y : Integer;
    Datei : File;
    Colour : Array[0..639] Of Byte;
BEGIN
 {$I-}
 { Datei îffnen }
 Assign(Datei,Dat+'.BMP');
 Reset(Datei,1);
 { Bitmap - Informationen Åberspringen }
 seek(datei,53);
 { Paletten - Informationen einlesen und Palette bearbeiten }
 For x:=0 To 255 Do
 Begin
   BlockRead(Datei,colour,4);
   SetRGBPalette(x,Round(colour[3]/255*62),Round(colour[2]/255*62),Round(colour[1]/255*62));
 End;
 {0 als Palettenendezeichen}
 seek(datei,filepos(datei)+1);
 { Bitmap einlesen und auf Bildschirm darstellen }
 For Y:=479 DownTo 0 Do Begin
  BlockRead(Datei,Colour,640);
  For X:=0 To 639 Do PutPixel(X,Y,Colour[X]);
 End;
 { Datei schlie·en }
 Close(Datei);
 {$I+}
END;

BEGIN
 grd:=installuserdriver('vesa',nil);
 grm:=2;
 initgraph(grd,grm,'');
 video_disable(true);
 LoadBmp('test');
 video_disable(false);
 WaitKey;
 CloseGraph;
END.