PROGRAM Fractal;

USES Crt, Graph, Gemischt;

VAR P, Q, X, Y, XALT, DISTANZP, DISTANZQ, XMIN, XMAX, YMIN, YMAX : Real;
    LAENGEY, LAENGEX, ENTFERNUNG, SCHRITTE, MAXSCHRITTE, AKTUELLX, AKTUELLY : Integer;
    FARBEN : Integer;
    U : Byte;

PROCEDURE PaletteDefinieren(Z : Byte);
VAR X : Byte;
BEGIN
 For X:=0 To 50 Do
 Begin
  SetRGBPalette(X  +2+Z,X,0,0);
  SetRGBPalette(X +52+Z,0,X,0);
  SetRGBPalette(X+102+Z,0,0,X);
  SetRGBPalette(X+152+Z,X,X,0);
  SetRGBPalette(X+202+Z,X,X,X);
 End;
 For X:=0 To  3 Do SetRGBPalette(X+252+Z,X,X,0);
END;

PROCEDURE Datenberechnung;
BEGIN
P := XMIN + AKTUELLX * DISTANZP;
Q := YMIN + AKTUELLY * DISTANZQ;
Schritte := 0;
X := 0;
Y := 0;
WHILE (X * X + Y * Y <= ENTFERNUNG) AND (Schritte <> MAXSCHRITTE) DO
BEGIN
XALT := X;
X := X * X - Y * Y + P;
Y := 2 * XALT * Y + Q  ;
Schritte := Schritte + 1 ;
END;

IF Schritte = MAXSCHRITTE THEN Schritte := 0;
If (Schritte Mod Farben)=0 Then Else PutPixel(AKTUELLX, LAENGEY - AKTUELLY, Schritte MOD Farben);
END;

BEGIN
{ Variablen mit Werten belegen }
XMIN := -2.25;
XMAX :=  0.75;
YMIN := -1.50;
YMAX :=  1.50;
ENTFERNUNG := 50;
MAXSCHRITTE := 50;
Farben := 256;
LAENGEX := 640;
LAENGEY := 480;

SVgaModus('SVga256',2);
PaletteDefinieren(0);
DISTANZP := (XMAX - XMIN) / LAENGEX;
DISTANZQ := (YMAX - YMIN) / LAENGEY;
FOR AKTUELLX := LAENGEX - 1 DownTo 0 Do
FOR AKTUELLY := LAENGEY - 1 DownTo 0 Do
BEGIN
Datenberechnung;
If KeyPressed Then Halt;
END;
 U:=2;
 Repeat
  PaletteDefinieren(U);
  U:=U+1; If U>250 Then U:=2;
 Until KeyPressed;

END.

