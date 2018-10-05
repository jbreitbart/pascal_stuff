PROGRAM IconEdit;

USES Crt, Graph, Gemischt;

VAR Quit : Byte;
    VFarbe, HFarbe, Modus : Byte;
    Dateiname : String;
    ZX, ZY, ZX2, ZY2 : Integer;

{ -------------------------------------------------------------------- }

PROCEDURE Initialisieren; FORWARD;
PROCEDURE Menubalken; FORWARD;
PROCEDURE NeuesBlatt; FORWARD;
PROCEDURE CheckPos; FORWARD;
PROCEDURE Load; FORWARD;
PROCEDURE Save; FORWARD;
PROCEDURE Farbvorschau; FORWARD;
PROCEDURE Spiegeln; FORWARD;
PROCEDURE ZeichneNeu; FORWARD;
PROCEDURE Punkt; FORWARD;
PROCEDURE Linie; FORWARD;
PROCEDURE Kreis; FORWARD;
PROCEDURE Rechteck; FORWARD;
PROCEDURE Zeichne; FORWARD;
PROCEDURE FillBox; FORWARD;
PROCEDURE LoadWin; FORWARD;
PROCEDURE Eingabe; FORWARD;

{ -------------------------------------------------------------------- }



{ -------------------------------------------------------------------- }

PROCEDURE Initialisieren;
BEGIN
     GrafikModus;
     Menubalken;
     MouseInit;
     Quit:=0;
     MouseShow(1);
     VFarbe:=Black;
     HFarbe:=White;
     Farbvorschau;
     NeuesBlatt;
     Dateiname := 'Noname01';
     Modus := 1; ZX2 := 0; ZY2 := 0;
END;

PROCEDURE Menubalken;
BEGIN
     Button(000,000,639,020,True); { Oberes MenÅ }
     TextButton(010,002,050,018,True,'Quit');
     TextButton(060,002,100,018,True,'Load');
     TextButton(110,002,150,018,True,'Save');
     TextButton(160,002,200,018,True,'New');
     TextButton(300,002,400,018,True,'Spiegeln');
     Button(000,020,100,479,True); { Linker Balken}
     Button(100,020,639,479,True); { Rechter Balken }
     Display(102,022,637,477,False,Black); { Ausschnitt Rechts }
     Button(002,030,092,120,False); { Palettenbereich }
     Display(004,032,024,052,True,00);
     Display(026,032,046,052,True,01);
     Display(048,032,068,052,True,02);
     Display(070,032,090,052,True,03);
     Display(004,054,024,074,True,04);
     Display(026,054,046,074,True,05);
     Display(048,054,068,074,True,06);
     Display(070,054,090,074,True,07);
     Display(004,076,024,096,True,08);
     Display(026,076,046,096,True,09);
     Display(048,076,068,096,True,10);
     Display(070,076,090,096,True,11);
     Display(004,098,024,118,True,12);
     Display(026,098,046,118,True,13);
     Display(048,098,068,118,True,14);
     Display(070,098,090,118,True,15);
     Display(002,150,098,246,False,Black); { Original Icon Feld }
     TextButton(002,275,098,295,True,'Import'); { Importiert Win Icon }
     Display(002,300,098,320,False,Black); { Dateiname Feld }
     TextButton(002,330,098,350,True,'Punkt'); { Punkt }
     TextButton(002,360,098,380,True,'Linie'); { Linie }
     TextButton(002,390,098,410,True,'Rechteck'); { Rechteck }
     TextButton(002,420,098,440,True,'Kreis');
     TextButton(002,450,098,470,True,'FillBox');
END;

PROCEDURE Farbvorschau;
BEGIN
     Display(002,250,048,260,False,VFarbe);
     Display(052,250,098,260,False,HFarbe);
END;

PROCEDURE NeuesBlatt;
VAR NBX, NBY : Byte;
BEGIN
     MouseShow(2);
     For NBX:=01 To 64 Do
     For NBY:=01 To 64 Do
     Box(135+NBX*7,020+NBY*7,140+NBX*7,025+NBY*7,HFarbe);
     Box(018,166,082,230,HFarbe);
     MouseShow(1);
END;


PROCEDURE Load;
VAR F : Text;
    SX, SY : Integer;
    OC : Byte;
BEGIN
 MouseShow(2);
 Eingabe;
 Assign(F,'C:\Pascal\Icons\'+Dateiname+'.Tpi');
 Reset(F);
 For SX:=018 To 081 Do
 For SY:=166 To 229 Do
 BEGIN
  ReadLn(F,OC);
  PutPixel(SX,SY,OC);
  Box(135+(SX-17)*7,020+(SY-165)*7,140+(SX-17)*7,025+(SY-165)*7,OC);
 END;
 MouseShow(1);
END;

PROCEDURE LoadWin;
VAR Dat : File Of Byte;
    Lx, Ly : Integer;
    C : Byte;
BEGIN
 MouseShow(2);
 Eingabe;
 LoadWindowsIcon(018,166,Dateiname,1);
 ZeichneNeu;
 MouseShow(1);
END;

PROCEDURE Save;
VAR F : Text;
    SX, SY : Integer;
BEGIN
 MouseShow(2);
 Eingabe;
 Assign(F,'C:\Pascal\Icons\'+Dateiname+'.Tpi');
 ReWrite(F);
 For SX:=018 To 081 Do
  For SY:=166 To 229 Do
  WriteLn(F,GetPixel(SX,SY));
 Close(F);
 MouseShow(1);
END;

PROCEDURE Spiegeln;
VAR C1, C2 : Byte;
    L1, L2 : Integer;
BEGIN
 For L1:=1 To 32 Do
 For L2:=1 To 64 Do
 BEGIN
  C1:=GetPixel(17+L1,165+L2);
  C2:=GetPixel(82-L1,165+L2);
  PutPixel(17+L1,165+L2,C2);
  PutPixel(82-L1,165+L2,C1);
 END;
 ZeichneNeu;
 Delay(200);
END;

PROCEDURE ZeichneNeu;
VAR X, Y : Integer;
    C : Byte;
BEGIN
 For X:=1 To 64 Do
 For Y:=1 To 64 Do
 BEGIN
  C:=GetPixel(X+17,Y+165);
  Box(135+X*7,020+Y*7,140+X*7,025+Y*7,C);
 END;
END;

PROCEDURE Eingabe;
BEGIN
 Display(002,300,098,320,False,Black);
 Dateiname:='';
 ReadText(20,315,Dateiname);
END;

PROCEDURE ReVar;
BEGIN
 ZX:=0; ZY:=0;
END;

PROCEDURE CheckPos;
BEGIN
     { Knîpfe und SchaltflÑchen }
     If MouseIn(010,002,050,018) Then Quit:=1;
     If MouseIn(160,002,200,018) Then NeuesBlatt;
     If MouseIn(060,002,100,018) Then Load;
     If MouseIn(110,002,150,018) Then Save;
     If MouseIn(300,002,400,018) Then Spiegeln;
     If MouseIn(002,300,098,320) Then Eingabe;
     If MouseIn(002,330,098,350) Then Begin Modus:=1; ReVar; End;
     If MouseIn(002,360,098,380) Then Begin Modus:=2; ReVar; End;
     If MouseIn(002,390,098,410) Then Begin Modus:=3; ReVar; End;
     If MouseIn(002,420,098,440) Then Begin Modus:=4; ReVar; End;
     If MouseIn(002,450,098,470) Then Begin Modus:=5; ReVar; End;
     If MouseIn(002,275,098,295) Then LoadWin;
     { Farbwahl auf Palette }
     If MouseIn(004,032,024,052) Then VFarbe:=00;
     If MouseIn(026,032,046,052) Then VFarbe:=01;
     If MouseIn(048,032,068,052) Then VFarbe:=02;
     If MouseIn(070,032,090,052) Then VFarbe:=03;
     If MouseIn(004,054,024,074) Then VFarbe:=04;
     If MouseIn(026,054,046,074) Then VFarbe:=05;
     If MouseIn(048,054,068,074) Then VFarbe:=06;
     If MouseIn(070,054,090,074) Then VFarbe:=07;
     If MouseIn(004,076,024,096) Then VFarbe:=08;
     If MouseIn(026,076,046,096) Then VFarbe:=09;
     If MouseIn(048,076,068,096) Then VFarbe:=10;
     If MouseIn(070,076,090,096) Then VFarbe:=11;
     If MouseIn(004,098,024,118) Then VFarbe:=12;
     If MouseIn(026,098,046,118) Then VFarbe:=13;
     If MouseIn(048,098,068,118) Then VFarbe:=14;
     If MouseIn(070,098,090,118) Then VFarbe:=15;
     If MouseIn(004,032,090,118) Then Farbvorschau;
     { Zeichnen auf Editorfenster }
     If MouseIn(142,027,588,480) Then Begin ZX:=1000; ZY:=1000; End;

     If MouseIn(142+00*7,027,142+01*7,448) Then ZX:=01;
     If MouseIn(142+01*7,027,142+02*7,448) Then ZX:=02;
     If MouseIn(142+02*7,027,142+03*7,448) Then ZX:=03;
     If MouseIn(142+03*7,027,142+04*7,448) Then ZX:=04;
     If MouseIn(142+04*7,027,142+05*7,448) Then ZX:=05;
     If MouseIn(142+05*7,027,142+06*7,448) Then ZX:=06;
     If MouseIn(142+06*7,027,142+07*7,448) Then ZX:=07;
     If MouseIn(142+07*7,027,142+08*7,448) Then ZX:=08;
     If MouseIn(142+08*7,027,142+09*7,448) Then ZX:=09;
     If MouseIn(142+09*7,027,142+10*7,448) Then ZX:=10;
     If MouseIn(142+10*7,027,142+11*7,448) Then ZX:=11;
     If MouseIn(142+11*7,027,142+12*7,448) Then ZX:=12;
     If MouseIn(142+12*7,027,142+13*7,448) Then ZX:=13;
     If MouseIn(142+13*7,027,142+14*7,448) Then ZX:=14;
     If MouseIn(142+14*7,027,142+15*7,448) Then ZX:=15;
     If MouseIn(142+15*7,027,142+16*7,448) Then ZX:=16;
     If MouseIn(142+16*7,027,142+17*7,448) Then ZX:=17;
     If MouseIn(142+17*7,027,142+18*7,448) Then ZX:=18;
     If MouseIn(142+18*7,027,142+19*7,448) Then ZX:=19;
     If MouseIn(142+19*7,027,142+20*7,448) Then ZX:=20;
     If MouseIn(142+20*7,027,142+21*7,448) Then ZX:=21;
     If MouseIn(142+21*7,027,142+22*7,448) Then ZX:=22;
     If MouseIn(142+22*7,027,142+23*7,448) Then ZX:=23;
     If MouseIn(142+23*7,027,142+24*7,448) Then ZX:=24;
     If MouseIn(142+24*7,027,142+25*7,448) Then ZX:=25;
     If MouseIn(142+25*7,027,142+26*7,448) Then ZX:=26;
     If MouseIn(142+26*7,027,142+27*7,448) Then ZX:=27;
     If MouseIn(142+27*7,027,142+28*7,448) Then ZX:=28;
     If MouseIn(142+28*7,027,142+29*7,448) Then ZX:=29;
     If MouseIn(142+29*7,027,142+30*7,448) Then ZX:=30;
     If MouseIn(142+30*7,027,142+31*7,448) Then ZX:=31;
     If MouseIn(142+31*7,027,142+32*7,448) Then ZX:=32;
     If MouseIn(142+32*7,027,142+33*7,448) Then ZX:=33;
     If MouseIn(142+33*7,027,142+34*7,448) Then ZX:=34;
     If MouseIn(142+34*7,027,142+35*7,448) Then ZX:=35;
     If MouseIn(142+35*7,027,142+36*7,448) Then ZX:=36;
     If MouseIn(142+36*7,027,142+37*7,448) Then ZX:=37;
     If MouseIn(142+37*7,027,142+38*7,448) Then ZX:=38;
     If MouseIn(142+38*7,027,142+39*7,448) Then ZX:=39;
     If MouseIn(142+39*7,027,142+40*7,448) Then ZX:=40;
     If MouseIn(142+40*7,027,142+41*7,448) Then ZX:=41;
     If MouseIn(142+41*7,027,142+42*7,448) Then ZX:=42;
     If MouseIn(142+42*7,027,142+43*7,448) Then ZX:=43;
     If MouseIn(142+43*7,027,142+44*7,448) Then ZX:=44;
     If MouseIn(142+44*7,027,142+45*7,448) Then ZX:=45;
     If MouseIn(142+45*7,027,142+46*7,448) Then ZX:=46;
     If MouseIn(142+46*7,027,142+47*7,448) Then ZX:=47;
     If MouseIn(142+47*7,027,142+48*7,448) Then ZX:=48;
     If MouseIn(142+48*7,027,142+49*7,448) Then ZX:=49;
     If MouseIn(142+49*7,027,142+50*7,448) Then ZX:=50;
     If MouseIn(142+50*7,027,142+51*7,448) Then ZX:=51;
     If MouseIn(142+51*7,027,142+52*7,448) Then ZX:=52;
     If MouseIn(142+52*7,027,142+53*7,448) Then ZX:=53;
     If MouseIn(142+53*7,027,142+54*7,448) Then ZX:=54;
     If MouseIn(142+54*7,027,142+55*7,448) Then ZX:=55;
     If MouseIn(142+55*7,027,142+56*7,448) Then ZX:=56;
     If MouseIn(142+56*7,027,142+57*7,448) Then ZX:=57;
     If MouseIn(142+57*7,027,142+58*7,448) Then ZX:=58;
     If MouseIn(142+58*7,027,142+59*7,448) Then ZX:=59;
     If MouseIn(142+59*7,027,142+60*7,448) Then ZX:=60;
     If MouseIn(142+60*7,027,142+61*7,448) Then ZX:=61;
     If MouseIn(142+61*7,027,142+62*7,448) Then ZX:=62;
     If MouseIn(142+62*7,027,142+63*7,448) Then ZX:=63;
     If MouseIn(142+63*7,027,142+64*7,448) Then ZX:=64;


     If MouseIn(142,027+00*7,588,032+01*7) Then ZY:=01;
     If MouseIn(142,027+01*7,588,032+02*7) Then ZY:=02;
     If MouseIn(142,027+02*7,588,032+03*7) Then ZY:=03;
     If MouseIn(142,027+03*7,588,032+04*7) Then ZY:=04;
     If MouseIn(142,027+04*7,588,032+05*7) Then ZY:=05;
     If MouseIn(142,027+05*7,588,032+06*7) Then ZY:=06;
     If MouseIn(142,027+06*7,588,032+07*7) Then ZY:=07;
     If MouseIn(142,027+07*7,588,032+08*7) Then ZY:=08;
     If MouseIn(142,027+08*7,588,032+09*7) Then ZY:=09;
     If MouseIn(142,027+09*7,588,032+10*7) Then ZY:=10;
     If MouseIn(142,027+10*7,588,032+11*7) Then ZY:=11;
     If MouseIn(142,027+11*7,588,032+12*7) Then ZY:=12;
     If MouseIn(142,027+12*7,588,032+13*7) Then ZY:=13;
     If MouseIn(142,027+13*7,588,032+14*7) Then ZY:=14;
     If MouseIn(142,027+14*7,588,032+15*7) Then ZY:=15;
     If MouseIn(142,027+15*7,588,032+16*7) Then ZY:=16;
     If MouseIn(142,027+16*7,588,032+17*7) Then ZY:=17;
     If MouseIn(142,027+17*7,588,032+18*7) Then ZY:=18;
     If MouseIn(142,027+18*7,588,032+19*7) Then ZY:=19;
     If MouseIn(142,027+19*7,588,032+20*7) Then ZY:=20;
     If MouseIn(142,027+20*7,588,032+21*7) Then ZY:=21;
     If MouseIn(142,027+21*7,588,032+22*7) Then ZY:=22;
     If MouseIn(142,027+22*7,588,032+23*7) Then ZY:=23;
     If MouseIn(142,027+23*7,588,032+24*7) Then ZY:=24;
     If MouseIn(142,027+24*7,588,032+25*7) Then ZY:=25;
     If MouseIn(142,027+25*7,588,032+26*7) Then ZY:=26;
     If MouseIn(142,027+26*7,588,032+27*7) Then ZY:=27;
     If MouseIn(142,027+27*7,588,032+28*7) Then ZY:=28;
     If MouseIn(142,027+28*7,588,032+29*7) Then ZY:=29;
     If MouseIn(142,027+29*7,588,032+30*7) Then ZY:=30;
     If MouseIn(142,027+30*7,588,032+31*7) Then ZY:=31;
     If MouseIn(142,027+31*7,588,032+32*7) Then ZY:=32;
     If MouseIn(142,027+32*7,588,032+33*7) Then ZY:=33;
     If MouseIn(142,027+33*7,588,032+34*7) Then ZY:=34;
     If MouseIn(142,027+34*7,588,032+35*7) Then ZY:=35;
     If MouseIn(142,027+35*7,588,032+36*7) Then ZY:=36;
     If MouseIn(142,027+36*7,588,032+37*7) Then ZY:=37;
     If MouseIn(142,027+37*7,588,032+38*7) Then ZY:=38;
     If MouseIn(142,027+38*7,588,032+39*7) Then ZY:=39;
     If MouseIn(142,027+39*7,588,032+40*7) Then ZY:=40;
     If MouseIn(142,027+40*7,588,032+41*7) Then ZY:=41;
     If MouseIn(142,027+41*7,588,032+42*7) Then ZY:=42;
     If MouseIn(142,027+42*7,588,032+43*7) Then ZY:=43;
     If MouseIn(142,027+43*7,588,032+44*7) Then ZY:=44;
     If MouseIn(142,027+44*7,588,032+45*7) Then ZY:=45;
     If MouseIn(142,027+45*7,588,032+46*7) Then ZY:=46;
     If MouseIn(142,027+46*7,588,032+47*7) Then ZY:=47;
     If MouseIn(142,027+47*7,588,032+48*7) Then ZY:=48;
     If MouseIn(142,027+48*7,588,032+49*7) Then ZY:=49;
     If MouseIn(142,027+49*7,588,032+50*7) Then ZY:=50;
     If MouseIn(142,027+50*7,588,032+51*7) Then ZY:=51;
     If MouseIn(142,027+51*7,588,032+52*7) Then ZY:=52;
     If MouseIn(142,027+52*7,588,032+53*7) Then ZY:=53;
     If MouseIn(142,027+53*7,588,032+54*7) Then ZY:=54;
     If MouseIn(142,027+54*7,588,032+55*7) Then ZY:=55;
     If MouseIn(142,027+55*7,588,032+56*7) Then ZY:=56;
     If MouseIn(142,027+56*7,588,032+57*7) Then ZY:=57;
     If MouseIn(142,027+57*7,588,032+58*7) Then ZY:=58;
     If MouseIn(142,027+58*7,588,032+59*7) Then ZY:=59;
     If MouseIn(142,027+59*7,588,032+60*7) Then ZY:=60;
     If MouseIn(142,027+60*7,588,032+61*7) Then ZY:=61;
     If MouseIn(142,027+61*7,588,032+62*7) Then ZY:=62;
     If MouseIn(142,027+62*7,588,032+63*7) Then ZY:=63;
     If MouseIn(142,027+63*7,588,032+64*7) Then ZY:=64;

     If MouseIn(142,027,588,480) and (ZX<65) and (ZY<65) and
        (ZX>0) and (ZY>0) Then Zeichne;
END;

PROCEDURE Zeichne;
BEGIN
 If Modus=1 Then Punkt;
 If Modus=2 Then Linie;
 If Modus=3 Then Rechteck;
 If Modus=4 Then Kreis;
 If Modus=5 Then FillBox;
END;

PROCEDURE FillBox;
BEGIN
 If (ZX2=0) and (ZY2=0) Then
 Begin
  ZX2:=ZX;
  ZY2:=ZY;
  MouseShow(2);
  PutPixel(17+ZX,165+ZY,Red);
  Box(135+ZX*7,020+ZY*7,140+ZX*7,025+ZY*7,Red);
  MouseShow(1);
  Delay(200)
 End Else
 Begin
  MouseShow(2);
  Box(17+ZX2,165+ZY2,17+ZX,165+ZY,VFarbe);
  ZeichneNeu;
  MouseShow(1);
  ZX2:=0; ZY2:=0;
 End;
END;

PROCEDURE Punkt;
BEGIN
   MouseShow(2);
   Box(135+ZX*7,020+ZY*7,140+ZX*7,025+ZY*7,VFarbe);
   PutPixel(17+ZX,165+ZY,VFarbe);
   MouseShow(1);
END;

PROCEDURE Linie;
BEGIN
 If (ZX2=0) and (ZY2=0) Then
 Begin
  ZX2:=ZX;
  ZY2:=ZY;
  MouseShow(2);
  PutPixel(17+ZX,165+ZY,Red);
  Box(135+ZX*7,020+ZY*7,140+ZX*7,025+ZY*7,Red);
  MouseShow(1);
  Delay(200)
 End Else
 Begin
  MouseShow(2);
  SetColor(VFarbe);
  Line(17+ZX2,165+ZY2,17+ZX,165+ZY);
  ZeichneNeu;
  MouseShow(1);
  ZX2:=0; ZY2:=0;
 End;
END;

PROCEDURE Kreis;
BEGIN
END;

PROCEDURE Rechteck;
BEGIN
 If (ZX2=0) and (ZY2=0) Then
 Begin
  ZX2:=ZX;
  ZY2:=ZY;
  MouseShow(2);
  PutPixel(17+ZX,165+ZY,Red);
  Box(135+ZX*7,020+ZY*7,140+ZX*7,025+ZY*7,Red);
  MouseShow(1);
  Delay(200)
 End Else
 Begin
  MouseShow(2);
  SetColor(VFarbe);
  Rectangle(17+ZX2,165+ZY2,17+ZX,165+ZY);
  ZeichneNeu;
  MouseShow(1);
  ZX2:=0; ZY2:=0;
 End;
END;

PROCEDURE CheckRPos;
BEGIN
     If MouseIn(004,032,024,052) Then HFarbe:=00;
     If MouseIn(026,032,046,052) Then HFarbe:=01;
     If MouseIn(048,032,068,052) Then HFarbe:=02;
     If MouseIn(070,032,090,052) Then HFarbe:=03;
     If MouseIn(004,054,024,074) Then HFarbe:=04;
     If MouseIn(026,054,046,074) Then HFarbe:=05;
     If MouseIn(048,054,068,074) Then HFarbe:=06;
     If MouseIn(070,054,090,074) Then HFarbe:=07;
     If MouseIn(004,076,024,096) Then HFarbe:=08;
     If MouseIn(026,076,046,096) Then HFarbe:=09;
     If MouseIn(048,076,068,096) Then HFarbe:=10;
     If MouseIn(070,076,090,096) Then HFarbe:=11;
     If MouseIn(004,098,024,118) Then HFarbe:=12;
     If MouseIn(026,098,046,118) Then HFarbe:=13;
     If MouseIn(048,098,068,118) Then HFarbe:=14;
     If MouseIn(070,098,090,118) Then HFarbe:=15;
     If MouseIn(004,032,090,118) Then Farbvorschau;
     END;

{ -------------------------------------------------------------------- }

BEGIN
 Initialisieren;
 While Quit=0 Do
 BEGIN
  If LMouse Then CheckPos;
  If RMouse Then CheckRPos;
 END;
 CloseGraph;
END.
