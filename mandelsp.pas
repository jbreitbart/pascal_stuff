{bestes}
USES Crt, Graph, alles;

CONST Muster : Array[0..1] Of Word = ($5555, $AAAA);
{wert = x=0.23 y=0.11 z=0.23 winkel=0}
VAR BlickpunktX, BlickpunktY, BlickpunktZ,
    Sinus, Cosinus, OriginalX, OriginalY,
    SchnittpunktX, SchnittpunktY, SchnittpunktZ,
    AlteTiefe, NeueTiefe,
    XComplex, YComplex, XAbsolut, YAbsolut,
    Produkt, KonstanteX, KonstanteY : Real;
    Treiber, Modus, X, Y, Z, XHalbe, YHalbe, Tiefe,
    YMin, Bilder, Nummer : Integer;
    BildName : Array[0..99] Of String[40];
    BildX, BildY, BildZ, BildWinkel : Array[0..99] Of Real;
    Datei : File;
    Puffer : Pointer;
    Groesse, Schatten, Licht, See, Gras, Linie,a,b : Word;
    c : byte;
    f :file of byte;

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
   write(f,anzahl);
   write(f,farbealt);
   anzahl:=1;
   farbealt:=farbe;
  end;
  putpixel(a,b,red);
 end;
 write(f,anzahl);
 write(f,farbealt);
 anzahl:=1;
 farbealt:=farbe;
end;

PROCEDURE Iteration;
BEGIN
 XComplex:=0;
 YComplex:=0;
 Tiefe:=40;
 Repeat
  XAbsolut:=Abs(XComplex);
  YAbsolut:=Abs(YComplex);
  Produkt:=XComplex*YComplex;
  XComplex:=XAbsolut-YAbsolut-SchnittpunktX;
  YComplex:=Produkt*2-SchnittpunktY;
  Dec(Tiefe)
 Until (XAbsolut+YAbsolut>400) Or (Tiefe<0)
END;

BEGIN
 GetMem(Puffer,65520);
 Bilder:=-1;
 Repeat
  Inc(Bilder);
  WriteLn(^J'--- Bild ', Bilder, ' ---');
  Write(' Name: ');
  ReadLn(BildName[Bilder]);
  If Length(BildName[Bilder])>0 Then
   Begin
    Write(' X: ');
    ReadLn(BildX[Bilder]);
    Write(' Y: ');
    ReadLn(BildY[Bilder]);
    Write(' Z: ');
    ReadLn(BildZ[Bilder]);
    Write(' Winkel: ');
    ReadLn(BildWinkel[Bilder])
   End
  Until Length(BildName[Bilder])=0;
  DetectGraph(Treiber,Modus);
  Linie:=SolidLn;
  Case Treiber Of
   CGA, MCGA, ATT400:
    Begin
     Modus:=0;
     Licht:=2;
     Schatten:=2;
     See:=1;
     Gras:=3;
    End;
   HercMono, PC3270:
    Begin
     Linie:=UserBitLn;
     Licht:=1;
     Schatten:=1;
     Gras:=1;
     See:=0;
    End;
   EgaMono:
    Begin
     Licht:=1;
     Schatten:=1;
     Gras:=3;
     See:=0;
    End;
   Ega, Ega64, VGA:
    Begin
     Licht:=darkgray;
     Schatten:=green;
     Gras:=lightgreen;
     See:=blue;
    End;
  End;
  modus:=2;
  InitGraph(Treiber,Modus,'');
{  laden;}
  SetBkColor(Black);
  Nummer:=GraphResult;
  If Nummer<>0 Then Halt(0);
  XHalbe:=GetMaxX Shr 1 + 1;
  YHalbe:=GetMaxY Shr 1 + 1;
  KonstanteX:=GetMaxX/3;
  KonstanteY:=GetMaxY/20;
  For Nummer :=0 To Bilder-1 Do
   Begin
    BlickpunktX:=BildX[Nummer];
    BlickpunktY:=BildY[Nummer];
    Iteration;
    BlickpunktZ:=(Tiefe+2)/20+BildZ[Nummer];
    Sinus:=Sin(BildWinkel[Nummer]+Pi/100);
    Cosinus:=Cos(BildWinkel[Nummer]+Pi/100);
    ClearDevice;
    Z:=1;
    Repeat
     OriginalY:=KonstanteY*BlickpunktZ/Z;
     YMin:=GetMaxY;
     For X:=0 To GetMaxX Do
     Begin
      OriginalX:=OriginalY*(X-XHalbe)/KonstanteX;
      SchnittpunktX:=BlickpunktX+OriginalX*Sinus+OriginalY*Cosinus;
      SchnittpunktY:=BlickpunktY+OriginalY*Sinus+OriginalX*Cosinus;
      Iteration;
      If X=0 Then AlteTiefe:=Tiefe;
       NeueTiefe:=0.75*AlteTiefe+0.25*Tiefe;
       If NeueTiefe<0 Then NeueTiefe:=0;
       AlteTiefe:=NeueTiefe;
       Y:=YHalbe+Z-Round(KonstanteY*NeueTiefe/(OriginalY*40));
       If Y<YMin Then YMin:=Y;
       SetColor(0);
       Line(X,Y,X,Y+50);
       SetLineStyle(Linie,Muster[X And 1], NormWidth);
       SetColor(Schatten);
       Line(X,Y,X,Y+50);
       SetLineStyle(SolidLn,0,NormWidth);
       SetColor(Licht);
       Line(X+1,Y,X+1,Y+50);
       If NeueTiefe=0 Then SetColor(See) Else SetColor(Gras);
       Line(X,Y,X+1,Y);
       If KeyPressed Then
        If ReadKey=#27 Then
         Begin
          CloseGraph;
          Halt
         End
       End;
       Inc(z);
    Until YMin >= GetMaxY;
   End;
   readln;
   speichern;
   readln;
   CloseGraph;
   Write(' X: ');
   writeLn(BildX[0]:20:10);
   Write(' Y: ');
   writeLn(BildY[0]:20:10);
   Write(' Z: ');
   writeLn(BildZ[0]:20:10);
   Write(' Winkel: ');
   writeLn(BildWinkel[0]:20:10);
   readln;
End.