{$A+,B-,D+,E+,F-,I+,L+,N+,O-,R-,S+,V+}
{$M 65000,0,655360}

PROGRAM Zeichenprogramm;

USES Crt, Mouse, Graph, Gemischt;

VAR LineStyle, OFarbe, VFarbe, HFarbe, PinselStyle, Funktion : Byte;
    Dateiname : String;
    Datei : File of Byte;
    Temp : String;

FUNCTION LMouse : Boolean;
BEGIN
 LMouse:=False;
 If MouseButton=1 Then LMouse:=True;
END;

FUNCTION RMouse : Boolean;
BEGIN
 RMouse:=False;
 If MouseButton=2 Then RMouse:=True;
END;

PROCEDURE Punkt(X1,Y1:Integer;Radius:Byte);
BEGIN
 SetFillStyle(1,VFarbe);
 SetColor(DarkGray);
 Circle(X1,Y1,Radius);
 FloodFill(X1,Y1,DarkGray);
 SetColor(VFarbe); Circle(X1,Y1,Radius);
END;

FUNCTION MouseIn(X1,Y1,X2,Y2:Integer) : Boolean;
BEGIN
 MouseIn:=False;
 If (MouseXPos>X1) and (MouseXPos<X2) and (MouseYPos>Y1) and (MouseYPos<Y2) Then MouseIn:=True;
END;

PROCEDURE LStyleBox;
BEGIN
 MouseHide;
 SetFillStyle(1,LightGray);
 Bar(008,361,072,389);
 SetColor(Black);
 OutTextXY(040,375,'-     +');
 SetColor(VFarbe);
 Line(022,377,058,377);
 Delay(10);
 MouseShow;
END;

PROCEDURE Invert;
VAR IX, IY : Integer;
    IC : Word;
BEGIN
 MouseHide;
 For IX:=91 To 629 Do
  For IY:=71 To 469 Do
  BEGIN
   IC:=GetPixel(IX,IY);
   PutPixel(IX,IY,15-IC);
  END;
 MouseShow;
END;

PROCEDURE Drehen;
VAR DX, DY : Integer;
    DC1, DC2 : Word;
BEGIN
 MouseHide;
 For DX:=0 To 538 Do
  For DY:=0 To 198 Do
  BEGIN
   DC1:=GetPixel(91+DX,71+DY);
   DC2:=GetPixel(629-DX,469-DY);
   PutPixel(91+DX,71+DY,DC2);
   PutPixel(629-DX,469-DY,DC1);
  END;
 For DX:=0 To 538 Do
 BEGIN
  DC1:=GetPixel(91+DX,270);
  DC2:=GetPixel(629-DX,270);
  PutPixel(91+DX,270,DC2);
  PutPixel(629-DX,270,DC1);
 END;
 MouseShow;
END;

PROCEDURE LStyle(Operator:ShortInt);
BEGIN
 LineStyle:=LineStyle+Operator;
 If LineStyle>3 Then LineStyle:=3;
 If LineStyle<0 Then LineStyle:=0;
 SetLineStyle(LineStyle,0,0);
 LStyleBox;
END;

PROCEDURE PStyleBox;
BEGIN
 MouseHide;
 OFarbe:=GetColor;
 SetFillStyle(1,LightGray);
 Bar(008,401,072,429);
 SetColor(Black);
 OutTextXY(040,415,'-     +');
 SetColor(OFarbe);
 If PinselStyle=1 Then PutPixel(040,415,GetColor) Else Punkt(040,415,PinselStyle);
 Delay(10);
 MouseShow;
END;

PROCEDURE PStyle(Operator:ShortInt);
BEGIN
 PinselStyle:=PinselStyle+Operator;
 If PinselStyle<01 Then PinselStyle:=01;
 If PinselStyle>10 Then PinselStyle:=10;
 PStyleBox;
END;

PROCEDURE Pinsel(X1,Y1:Integer);
BEGIN
 MouseHide;
  If PinselStyle=1 Then PutPixel(X1,Y1,GetColor) Else Punkt(X1,Y1,PinselStyle);
 MouseShow;
END;

PROCEDURE FarbBox1;
BEGIN
 SetFillStyle(1,VFarbe);
 Bar(008,441,072,449);
END;

PROCEDURE FarbBox2;
BEGIN
 SetFillStyle(1,HFarbe);
 Bar(008,453,072,461);
END;

PROCEDURE Kreis(X1,Y1:Integer);
VAR MX : Integer;
    VPT : ViewPortType;
BEGIN
 GetViewSettings(VPT);
 SetViewPort(091,071,629,469,True);
 X1:=X1-91; Y1:=Y1-71;
 While MouseButton=1 Do
 BEGIN
  MX:=MouseXPos-91;
  SetColor(VFarbe);
  Circle(X1,Y1,MX-X1);
  SetColor(HFarbe);
  Circle(X1,Y1,MX-X1);
 END;
 SetColor(VFarbe);
 MouseHide;
 Circle(X1,Y1,MX-X1);
 MouseShow;
 SetViewPort(VPT.X1,VPT.Y1,VPT.X2,VPT.Y2,VPT.Clip);
END;

PROCEDURE Linie(X1,Y1:Integer);
VAR MX, MY : Integer;
    VPT : ViewPortType;
BEGIN
 GetViewSettings(VPT);
 SetViewPort(091,071,629,469,True);
 X1:=X1-91; Y1:=Y1-71;
 While MouseButton=1 Do
 BEGIN
  MX:=MouseXPos-91; MY:=MouseYPos-71;
  SetColor(VFarbe);
  Line(X1,Y1,MX,MY);
  SetColor(HFarbe);
  Line(X1,Y1,MX,MY);
 END;
 SetColor(VFarbe);
 MouseHide;
 Line(X1,Y1,Mx,My);
 MouseShow;
 SetViewPort(VPT.X1,VPT.Y1,VPT.X2,VPT.Y2,VPT.Clip);
END;

PROCEDURE Eck(X1,Y1:Integer);
VAR MX, MY : Integer;
    VPT : ViewPortType;
BEGIN
 GetViewSettings(VPT);
 SetViewPort(091,071,629,469,True);
 X1:=X1-91; Y1:=Y1-71;
 While MouseButton=1 Do
 BEGIN
  MX:=MouseXPos-91; MY:=MouseYPos-71;
  SetColor(VFarbe);
  Rectangle(X1,Y1,MX,MY);
  SetColor(HFarbe);
  Rectangle(X1,Y1,MX,MY);
 END;
 SetColor(VFarbe);
 MouseHide;
 Rectangle(X1,Y1,MX,MY);
 MouseShow;
 SetViewPort(VPT.X1,VPT.Y1,VPT.X2,VPT.Y2,VPT.Clip);
END;

PROCEDURE Ell(X1,Y1:Integer);
VAR MX, MY : Integer;
    VPT : ViewPortType;
BEGIN
 GetViewSettings(VPT);
 SetViewPort(091,071,629,469,True);
 X1:=X1-91; Y1:=Y1-71;
 While MouseButton=1 Do
 BEGIN
  Mx:=MouseXPos-91; My:=MouseYPos-71;
  SetColor(VFarbe);
  Ellipse(X1,Y1,0,360,MX-X1,MY-Y1);
  SetColor(HFarbe);
  Ellipse(X1,Y1,0,360,MX-X1,MY-Y1);
 END;
 SetColor(VFarbe);
 MouseHide;
 Ellipse(X1,Y1,0,360,MX-X1,MY-Y1);
 MouseShow;
 SetViewPort(VPT.X1,VPT.Y1,VPT.X2,VPT.Y2,VPT.Clip);
END;

PROCEDURE Spray(X1,Y1:Integer);
VAR VPT : ViewPortType;
BEGIN
 GetViewSettings(VPT);
 SetViewPort(091,071,629,469,True);
 X1:=X1-91; Y1:=Y1-71;
 MouseHide;
 PutPixel(Round(X1-PinselStyle+Random(PinselStyle*2)),Round(Y1-PinselStyle+Random(PinselStyle*2)),VFarbe);
 MouseShow;
 SetViewPort(VPT.X1,VPT.Y1,VPT.X2,VPT.Y2,VPT.Clip);
END;

PROCEDURE Blatt(Farbe:Byte);
BEGIN
 Display(290,030,420,050,1,Black);
 SetFillStyle(1,Farbe);
 BAR(091,071,629,469);
END;

PROCEDURE SaveAs;
VAR LVX, LVY : Integer;
    Daten : Byte;
BEGIN
 MouseHide;
 Display(290,030,420,050,1,Black);
 SetColor(White);
 ReadText(290,040,Dateiname);
 SetColor(VFarbe);
 Assign(Datei,Dateiname);
 Rewrite(Datei);
 For LVX:=091 To 629 Do
  For LVY:=071 To 469 Do
  BEGIN
   Daten:=GetPixel(LVX,LVY);
   Write(Datei,Daten);
  END;
 Close(Datei);
 MouseShow;
END;

PROCEDURE Save;
VAR LVX, LVY : Integer;
    Daten : Byte;
BEGIN
 MouseHide;
 If Dateiname='' Then
 BEGIN
  Display(290,030,420,050,1,Black);
  SetColor(White);
  ReadText(290,040,Dateiname);
  SetColor(VFarbe);
 END;
 Assign(Datei,Dateiname);
 ReWrite(Datei);
 For LVX:=091 To 629 Do
  For LVY:=071 To 469 Do
  BEGIN
   Daten:=GetPixel(LVX,LVY);
   Write(Datei,Daten);
  END;
 Close(Datei);
 MouseShow;
END;

PROCEDURE Load;
VAR LVX, LVY : Integer;
    Daten : Byte;
BEGIN
 Display(290,030,420,050,1,Black);
 SetColor(White);
 ReadText(290,040,Dateiname);
 SetColor(VFarbe);
 Assign(Datei,Dateiname);
 Reset(Datei);
 For LVX:=091 To 629 Do
  For LVY:=071 To 469 Do
  BEGIN
   Read(Datei,Daten);
   PutPixel(LVX,LVY,Daten);
  END;
 Close(Datei);
END;

PROCEDURE Hauptbildschirm;
VAR LV : Byte;
    X1, Y1 : Integer;
BEGIN
 Button(000,000,639,060,0);
 Button(000,061,080,479,0);
 Display(002,002,637,020,1,Blue);
 Display(002,063,078,081,1,Blue);
 FarbBox1; FarbBox2;
 SetColor(VFarbe);
 SetColor(White);
 OutTextXY(006,007,'Zeichenprogramm fÅr Turbo Pascal                          V1.0 (C) Kai Burkard');
 OutTextXY(006,068,'Werkzeug');
 Blatt(HFarbe);

 Display(010,200,020,210,1,0);
 Display(025,200,035,210,1,1);
 Display(040,200,050,210,1,2);
 Display(055,200,065,210,1,3);
 Display(010,215,020,225,1,4);
 Display(025,215,035,225,1,5);
 Display(040,215,050,225,1,6);
 Display(055,215,065,225,1,7);
 Display(010,230,020,240,1,8);
 Display(025,230,035,240,1,9);
 Display(040,230,050,240,1,10);
 Display(055,230,065,240,1,11);
 Display(010,245,020,255,1,12);
 Display(025,245,035,255,1,13);
 Display(040,245,050,255,1,14);
 Display(055,245,065,255,1,15);

 Button(010,100,035,125,0); { Normales Zeichnen }
 Button(040,100,065,125,0); { Linien Zeichnen   }
 Button(010,130,035,155,0); { Rechteck Zeichnen }
 Button(040,130,065,155,0); { Kreis Zeichnen    }
 Button(010,160,035,185,0); { Ellipse Zeichnen  }
 Button(040,160,065,185,0); { SprÅhdose         }
 Display(007,440,073,450,1,VFarbe);
 Display(007,452,073,462,1,HFarbe);

 Button(010,275,065,295,0); { Spiegeln }
 Button(010,300,065,320,0); { ABC }
 Button(010,325,065,345,0); { Invert }

 SetTextJustify(CenterText,CenterText);
 SetColor(Black);

 OutTextXY(037,310,'Text');
 OutTextXY(037,285,'180¯');
 OutTextXY(037,335,'Invert');

 PutPixel(022,112,Black);
 Line(044,104,061,121);
 Rectangle(014,134,031,151);
 Circle(052,142,8);
 Ellipse(022,172,0,360,5,8);
 PinselStyle:=10;
 X1:=055; Y1:=172;
For LV:=1 To 50 Do
 PutPixel(Round(X1-PinselStyle+Random(PinselStyle*2)),Round(Y1-PinselStyle+Random(PinselStyle*2)),VFarbe);
 PinselStyle:=1;

 Button(010,030,070,050,0); { Neu     - Button }
 Button(080,030,140,050,0); { Load    - Button }
 Button(150,030,210,050,0); { Save    - Button }
 Button(220,030,280,050,0); { Save As - Button }
 Button(430,030,490,050,0); { Info    - Button }
 Button(500,030,560,050,0); { Help    - Button }
 Button(570,030,630,050,0); { Quit    - Button }
 Display(290,030,420,050,1,Black); { Dateiname - Datenfeld }
 Button(007,360,073,390,1);
 Button(007,400,073,430,1);

 SetTextJustify(CenterText,CenterText);
 SetColor(Black);
 OutTextXY(040,040,'New');
 OutTextXY(110,040,'Load');
 OutTextXY(180,040,'Save');
 OutTextXY(250,040,'Save As');
 OutTextXY(460,040,'Info');
 OutTextXY(530,040,'Help');
 SetColor(Red);
 OutTextXY(600,040,'Quit');
 SetColor(VFarbe);
 PStyleBox;
 LStyleBox;
END;

PROCEDURE Initialisieren;
BEGIN
 Grafik;
 VFarbe:=Black; HFarbe:=White; Funktion:=1; PinselStyle:=1; LineStyle:=0;
 Hauptbildschirm; SetColor(VFarbe); SetFillStyle(1,VFarbe);
 Dateiname:='';
 MouseInit;
 MouseShow;
END;

PROCEDURE Hauptprogramm;
BEGIN
 Repeat
  If MouseIn(010,030,070,050) and (MouseButton=1) Then Blatt(HFarbe);
  If MouseIn(091,071,629,469) and (MouseButton=1) and (Funktion=1) Then Pinsel(MouseXPos,MouseYPos);
  If MouseIn(091,071,629,469) and (MouseButton=1) and (Funktion=2) Then Linie(MouseXPos,MouseYPos);
  If MouseIn(091,071,629,469) and (MouseButton=1) and (Funktion=3) Then Eck(MouseXPos,MouseYPos);
  If MouseIn(091,071,629,469) and (MouseButton=1) and (Funktion=4) Then Kreis(MouseXPos,MouseYPos);
  If MouseIn(091,071,629,469) and (MouseButton=1) and (Funktion=5) Then Ell(MouseXPos,MouseYPos);
  If MouseIn(091,071,629,469) and (MouseButton=1) and (Funktion=6) Then Spray(MouseXPos,MouseYPos);
  If MouseIn(091,071,629,469) and LMouse and (Funktion=7) Then
  Begin
   MouseHide;
   SetTextStyle(2,0,5);
   SetColor(VFarbe);
   ReadText(MouseXPos,MouseYPos,Temp);
   SetTextStyle(0,0,0);
   MouseShow;
  End;
  If MouseIn(010,200,020,210) and LMouse Then VFarbe:=0;
  If MouseIn(025,200,035,210) and LMouse Then VFarbe:=1;
  If MouseIn(040,200,050,210) and LMouse Then VFarbe:=2;
  If MouseIn(055,200,065,210) and LMouse Then VFarbe:=3;
  If MouseIn(010,215,020,225) and LMouse Then VFarbe:=4;
  If MouseIn(025,215,035,225) and LMouse Then VFarbe:=5;
  If MouseIn(040,215,050,225) and LMouse Then VFarbe:=6;
  If MouseIn(055,215,065,225) and LMouse Then VFarbe:=7;
  If MouseIn(010,230,020,240) and LMouse Then VFarbe:=8;
  If MouseIn(025,230,035,240) and LMouse Then VFarbe:=9;
  If MouseIn(040,230,050,240) and LMouse Then VFarbe:=10;
  If MouseIn(055,230,065,240) and LMouse Then VFarbe:=11;
  If MouseIn(010,245,020,255) and LMouse Then VFarbe:=12;
  If MouseIn(025,245,035,255) and LMouse Then VFarbe:=13;
  If MouseIn(040,245,050,255) and LMouse Then VFarbe:=14;
  If MouseIn(055,245,065,255) and LMouse Then VFarbe:=15;
  If MouseIn(010,200,065,255) and LMouse Then Begin FarbBox1; PStyleBox; LStyleBox; End;
  If MouseIn(010,200,020,210) and RMouse Then HFarbe:=0;
  If MouseIn(025,200,035,210) and RMouse Then HFarbe:=1;
  If MouseIn(040,200,050,210) and RMouse Then HFarbe:=2;
  If MouseIn(055,200,065,210) and RMouse Then HFarbe:=3;
  If MouseIn(010,215,020,225) and RMouse Then HFarbe:=4;
  If MouseIn(025,215,035,225) and RMouse Then HFarbe:=5;
  If MouseIn(040,215,050,225) and RMouse Then HFarbe:=6;
  If MouseIn(055,215,065,225) and RMouse Then HFarbe:=7;
  If MouseIn(010,230,020,240) and RMouse Then HFarbe:=8;
  If MouseIn(025,230,035,240) and RMouse Then HFarbe:=9;
  If MouseIn(040,230,050,240) and RMouse Then HFarbe:=10;
  If MouseIn(055,230,065,240) and RMouse Then HFarbe:=11;
  If MouseIn(010,245,020,255) and RMouse Then HFarbe:=12;
  If MouseIn(025,245,035,255) and RMouse Then HFarbe:=13;
  If MouseIn(040,245,050,255) and RMouse Then HFarbe:=14;
  If MouseIn(055,245,065,255) and RMouse Then HFarbe:=15;
  If MouseIn(010,200,065,255) and RMouse Then FarbBox2;
  If MouseIn(040,400,073,430) and (MouseButton=1) Then PStyle(1);
  If MouseIn(007,400,040,430) and (MouseButton=1) Then PStyle(-1);
  If MouseIn(007,360,040,390) and LMouse Then LStyle(-1);
  If MouseIn(040,360,073,390) and LMouse Then LStyle(1);
  If MouseIn(220,030,280,050) and (MouseButton=1) Then SaveAs;
  If MouseIn(080,030,140,050) and (MouseButton=1) Then Load;
  If MouseIn(150,030,210,050) and (MouseButton=1) Then Save;
  If MouseIn(010,100,035,125) and (MouseButton=1) Then Funktion:=1; {normal}
  If MouseIn(040,100,065,125) and (MouseButton=1) Then Funktion:=2; {linie}
  If MouseIn(010,130,035,155) and (MouseButton=1) Then Funktion:=3; {rechteck}
  If MouseIn(040,130,065,155) and (MouseButton=1) Then Funktion:=4; {kreis}
  If MouseIn(010,160,035,185) and (MouseButton=1) Then Funktion:=5; {ellipse}
  If MouseIn(040,160,065,185) and (MouseButton=1) Then Funktion:=6; {sprÅhen}
  If MouseIn(010,300,065,320) and LMouse Then Funktion:=7; {text}
  If MouseIn(010,325,065,345) and LMouse Then Invert;
  If MouseIn(010,275,065,295) and LMouse Then Drehen;
 Until MouseIn(570,030,630,050) and (MouseButton=1);
END;

BEGIN
 Initialisieren;
 Hauptprogramm;
 CloseGraph;
END.