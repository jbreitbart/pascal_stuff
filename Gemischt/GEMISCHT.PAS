{$A+,B-,D+,E+,F-,I+,L+,N+,O-,R-,S+,V+}
{$M 16384,0,655360}

UNIT Gemischt;

INTERFACE
USES Dos, Mouse, Crt, Graph;
PROCEDURE WaitKey;
PROCEDURE Button(x1,y1,x2,y2:Integer;pn:Word);
PROCEDURE Display(x1,y1,x2,y2:Integer;pn,color:Word);
PROCEDURE MessageBox(X,Y:Integer;Message,Name:String);
PROCEDURE Balken(X1,Y1,X2,Y2,Color:Integer);
PROCEDURE LoadGif(Path:String);
PROCEDURE LoadIcon(X1,Y1:Integer;Datei:String);
PROCEDURE Grafik;
PROCEDURE SavePic(Path:String);
PROCEDURE LoadPic(Path:String);
FUNCTION ReadText(X,Y:Integer) : String;

IMPLEMENTATION
Function ReadText(X,Y:Integer) : String;
VAR Ch : Char;
    Txt : String;
BEGIN
 Txt:='';
 Repeat
 SetTextJustify(LeftText,BottomText);
 Ch:=ReadKey;
 If Ch=#0 Then Ch:=ReadKey;
 If Ord(Ch)<>13 Then OutTextXY(X,Y,Ch);
 If Ord(Ch)<>13 Then Txt:=Txt+Ch;
 X:=X+8;
 Until Ord(Ch)=13;
 ReadText:=Txt;
END;

PROCEDURE SavePic(Path:String);
Var X, Y, C : Integer;
    F : Text;
BEGIN
 Assign(F,Path);
 ReWrite(F);
 For X:=0 To 639 Do
 For Y:=0 To 479 Do
 BEGIN
  C:=GetPixel(X,Y);
  WriteLn(F,C);
 END;
 Close(F);
END;

PROCEDURE LoadPic(Path:String);
Var X, Y, C : Integer;
    F : Text;
BEGIN
 Assign(F,Path);
 Reset(F);
 C:=0;
 For X:=0 To 639 Do
 For Y:=0 To 479 Do
 BEGIN
  ReadLn(F,C);
  PutPixel(X,Y,C);
 END;
 Close(F);
END;

PROCEDURE Grafik;
Var Treiber, Modus : Integer;
BEGIN
 Treiber:=Detect;
 InitGraph(Treiber,Modus,'');
END;

PROCEDURE LoadIcon(X1,Y1:Integer;Datei:String);
VAR F : Text;
    X, Y, C : Integer;
BEGIN
 Assign(F,Datei);
 Reset(F);
 C:=0; X:=0; Y:=0;
 For X:=0 To 64 Do
  For Y:=0 To 63 Do
  BEGIN
   ReadLn(F,C);
   PutPixel(X1+X,Y1+Y,C);
  END;
END;

PROCEDURE LoadGif(Path:String);
BEGIN
  SwapVectors;
  Exec('C:\PASCAL\PICEM.EXE', Path);
  SwapVectors;
END;

PROCEDURE Balken(X1,Y1,X2,Y2,Color:Integer);
VAR Laenge : Integer;
BEGIN
 Laenge:=0;
 Repeat
  Laenge:=Laenge+2;
  SetColor(Color);
  Line(X1+Laenge,Y1,X1+Laenge,Y2);
 Until Laenge>X2-X1;
END;

PROCEDURE MessageBox(X,Y:Integer;Message,Name:String);
VAR A,B:Integer;
BEGIN
Button(X,Y,X+200,Y+90,0);
Button(X+70,Y+60,X+130,Y+80,0);
SetColor(Blue);
For A:=Y+2 to Y+16 Do
Line(X+4,A,X+196,A);
SetTextJustify(CenterText,CenterText);
SetColor(White);
OutTextXY(X+100,Y+9,Name);
SetColor(Black);
OutTextXY(X+100,Y+70,'OK');
OutTextXY(X+100,Y+40,Message);
B:=0;
Repeat
If (MouseXPos>X+70) and (MouseXPos<X+130) and (MouseYPos>Y+60) and (MouseYPos<Y+80) and (MouseButton=1) Then
 B:=1;
Until B=1;
Button(X+70,Y+60,X+130,Y+80,1);
END;

PROCEDURE WaitKey;
BEGIN
 Repeat
 Until KeyPressed;
END;

PROCEDURE Button(x1,y1,x2,y2:Integer;pn:Word);
VAR A : Integer;
BEGIN
 SetColor(LightGray);
 For A:=Y1 to Y2 Do
  Line(x1,A,x2,A);
 If pn=0 Then
 Begin
  SetColor(White);
  Line(x1,y1,x1,y2);
  Line(x1,y1,x2,y1);
  SetColor(DarkGray);
  Line(x2,y2,x1,y2);
  Line(x2,y2,x2,y1);
 End
          Else
 Begin
  SetColor(DarkGray);
  Line(x1,y1,x1,y2);
  Line(x1,y1,x2,y1);
  SetColor(White);
  Line(x2,y2,x1,y2);
  Line(x2,y2,x2,y1);
 End;
END;

PROCEDURE Display(x1,y1,x2,y2:Integer;pn,color:Word);
VAR A : Integer;
BEGIN
 SetColor(color);
 For A:=y1 to y2 Do
  Line(x1,a,x2,a);
 If pn=0 Then
  Begin
   SetColor(White);
   Line(x1,y1,x2,y1);
   Line(x1,y1,x1,y2);
   SetColor(DarkGray);
   Line(x2,y2,x1,y2);
   Line(x2,y2,x2,y1);
  End
         Else
  Begin
   SetColor(White);
   Line(x2,y2,x1,y2);
   Line(x2,y2,x2,y1);
   SetColor(DarkGray);
   Line(x1,y1,x2,y1);
   Line(x1,y1,x1,y2);
  End;
End;

END.