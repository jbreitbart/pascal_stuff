PROGRAM BitmapLaden;

USES Crt, Graph, Gemischt;

VAR DateiName : String;

PROCEDURE LoadBMP(Dat : String);
{ Dieser LoadBMP - Befehl schafft es leider nur, Windows - BMPs mit einer
  Grî·e von 640 x 480 bei 256 Farben zu laden                             }
VAR L, X, Y : Integer;
    Datei : File;
    P : Array[0..3] Of Byte;
    Colour : Array[0..639] Of Byte;
    T : Word;
BEGIN
 { Datei îffnen }
 Assign(Datei,Dat+'.BMP');
 Reset(Datei,1);
 { Bitmap - Informationen Åberspringen }
   BlockRead(Datei,Colour,53,T);
 { Paletten - Informationen einlesen und Palette bearbeiten }
 For L:=0 To 254 Do
 Begin
   BlockRead(Datei,P,4,T);
   SetRGBPalette(L,Round(P[3]/255*62),Round(P[2]/255*62),Round(P[1]/255*62));
 End;
 { Bitmap einlesen und auf Bildschirm darstellen }
 For Y:=479 DownTo 0 Do
 Begin
   BlockRead(Datei,Colour,640,T);
   For X:=0 To 639 Do PutPixel(X,Y,Colour[X]);
   If KeyPressed Then Halt;
 End;
 { Datei schlie·en }
 Close(Datei);
END;

BEGIN
 SVgaModus('SVga256',2);
 LoadBmp('Setup');
 WaitKey;
 CloseGraph;
END.



