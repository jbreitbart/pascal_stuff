PROGRAM TurboPaint;

USES Crt, Graph, Gemischt, Mouse;

VAR PinselStyle, Werkzeug, ZeichenFarbe, HintergrundFarbe : Byte;

PROCEDURE ProgrammInit; FORWARD;
PROCEDURE ProgrammClose; FORWARD;
PROCEDURE Hauptbildschirm; FORWARD;
PROCEDURE FillBox(X1,Y1,X2,Y2:Integer;Color,Rahmen:Word); FORWARD;
PROCEDURE Blatt(Color:Word); FORWARD;
PROCEDURE Hauptprogramm; FORWARD;
PROCEDURE Colors; FORWARD;
PROCEDURE FarbBox; FORWARD;
FUNCTION Funktion(Nr:Byte) : Boolean; FORWARD;
FUNCTION MouseInBlatt : Boolean; FORWARD;
PROCEDURE Pinsel(X1,Y1:Integer); FORWARD;

PROCEDURE ProgrammInit;
BEGIN
 ZeichenFarbe:=00; HintergrundFarbe:=15; Werkzeug:=1; PinselStyle:=1;
 SVGA('SVGA256',5);
 Hauptbildschirm;
 MouseInit; MouseShow;
END;

PROCEDURE ProgrammClose;
BEGIN
 CloseGraph;
 Halt(0);
END;

PROCEDURE Hauptbildschirm;
BEGIN

{ Hintergrund }
   FillBox(000,000,639,479,DarkGray,DarkGray);
   FillBox(000,000,639,075,LightGray,LightGray);
   FillBox(000,075,040,459,LightGray,LightGray);
   FillBox(000,460,639,479,LightGray,LightGray);
   FillBox(003,002,636,016,Blue,LightGray);
   SetColor(White);
   OutTextXY(010,006,'Turbo Painter                                                 (C) Kai Burkard');

{ MenÅbalken }
   Button (002,018,637,033,1);
   Button (003,019,636,032,0);
   Button (625,020,635,031,0);
   SetColor(Black);
   OutTextXY(010,023,'Datei');
   OutTextXY(110,023,'Option');
   OutTextXY(210,023,'Hilfe');
   OutTextXY(627,023,'X');

{ Werkzeuge }
   Button(001,076,039,458,1);
   Button(002,077,038,457,0);
    Button(004,080,036,112,0); { Pinsel          } Pinsel(020,096);
    Button(004,114,036,146,0); { SprÅhdose       }
    Button(004,148,036,180,0); { Radiergummie    }
    Button(004,182,036,214,0); { Rechteck        }
    Button(004,216,036,248,0); { Kreis           }
    Button(004,250,036,282,0); { Ellipse         }
    Button(004,284,036,316,0); { Text            }
    Button(004,318,036,350,0); { Farbsonde       }
    FarbBox;

{ Standart }
   Button(002,034,637,073,1);
   Button(003,035,636,072,0);
    Button(055,040,125,067,1); { Akktuelle Pinselgrî·e }
    Button(005,040,036,067,0); { Akktuelles Werkzeug }
     SetColor(Black); Pinsel(020,053);


{ Palette }
   Button(002,461,637,479,1);
   Button(003,462,636,478,0);
   Colors;

{ Blatt }
   Blatt(White);

END;

PROCEDURE Colors;
BEGIN
 FillBox(006,464,018,476,00,00); FillBox(126,464,138,476,08,00);
 FillBox(021,464,033,476,01,00); FillBox(141,464,153,476,09,00);
 FillBox(036,464,048,476,02,00); FillBox(156,464,168,476,10,00);
 FillBox(051,464,063,476,03,00); FillBox(171,464,183,476,11,00);
 FillBox(066,464,078,476,04,00); FillBox(186,464,198,476,12,00);
 FillBox(081,464,093,476,05,00); FillBox(201,464,213,476,13,00);
 FillBox(096,464,108,476,06,00); FillBox(216,464,228,476,14,00);
 FillBox(111,464,123,476,07,00); FillBox(231,464,243,476,15,00);
END;

PROCEDURE Blatt;
BEGIN
 FillBox(100,090,580,450,Color,Color);
END;

PROCEDURE FarbBox;
BEGIN
 FillBox(005,400,025,420,HintergrundFarbe,00);
 FillBox(010,405,030,425,ZeichenFarbe,00);
END;

PROCEDURE Farbe(Color, HColor:Byte);
BEGIN
 ZeichenFarbe:=Color;
 HintergrundFarbe:=HColor;
 SetColor(Color);
 FarbBox;
END;

PROCEDURE FillBox;
BEGIN
 SetFillStyle(1,Color);
 Bar(X1,Y1,X2,Y2);
 SetColor(Rahmen);
 Rectangle(X1,Y1,X2,Y2);
END;

FUNCTION Funktion;
BEGIN
 Funktion:=False;
 If Werkzeug=Nr Then Funktion:=True;
END;

FUNCTION MouseInBlatt : Boolean;
BEGIN
 MouseInBlatt:=False;
 If MouseIn(100,090,580,450) Then MouseInBlatt:=True;
END;

PROCEDURE Pinsel;
BEGIN
 MouseHide;
 If PinselStyle=1 Then PutPixel(X1,Y1,ZeichenFarbe) Else Circle(X1,Y1,PinselStyle);
 MouseShow;
END;

PROCEDURE Hauptprogramm;
BEGIN
 Repeat
  If MouseInBlatt and LMouse and Funktion(1) Then Pinsel(MouseXPos,MouseYPos);
  If MouseIn(006,464,018,476) and LMouse Then Farbe(00,HintergrundFarbe);
  If MouseIn(021,464,033,476) and LMouse Then Farbe(01,HintergrundFarbe);
  If MouseIn(036,464,048,476) and LMouse Then Farbe(02,HintergrundFarbe);
  If MouseIn(051,464,063,476) and LMouse Then Farbe(03,HintergrundFarbe);
  If MouseIn(066,464,078,476) and LMouse Then Farbe(04,HintergrundFarbe);
  If MouseIn(081,464,093,476) and LMouse Then Farbe(05,HintergrundFarbe);
  If MouseIn(096,464,108,476) and LMouse Then Farbe(06,HintergrundFarbe);
  If MouseIn(111,464,123,476) and LMouse Then Farbe(07,HintergrundFarbe);
  If MouseIn(126,464,138,476) and LMouse Then Farbe(08,HintergrundFarbe);
  If MouseIn(141,464,153,476) and LMouse Then Farbe(09,HintergrundFarbe);
  If MouseIn(156,464,168,476) and LMouse Then Farbe(10,HintergrundFarbe);
  If MouseIn(171,464,183,476) and LMouse Then Farbe(11,HintergrundFarbe);
  If MouseIn(186,464,198,476) and LMouse Then Farbe(12,HintergrundFarbe);
  If MouseIn(201,464,213,476) and LMouse Then Farbe(13,HintergrundFarbe);
  If MouseIn(216,464,228,476) and LMouse Then Farbe(14,HintergrundFarbe);
  If MouseIn(231,464,243,476) and LMouse Then Farbe(15,HintergrundFarbe);
  If MouseIn(006,464,018,476) and RMouse Then Farbe(Zeichenfarbe,00);
  If MouseIn(021,464,033,476) and RMouse Then Farbe(Zeichenfarbe,01);
  If MouseIn(036,464,048,476) and RMouse Then Farbe(Zeichenfarbe,02);
  If MouseIn(051,464,063,476) and RMouse Then Farbe(Zeichenfarbe,03);
  If MouseIn(066,464,078,476) and RMouse Then Farbe(Zeichenfarbe,04);
  If MouseIn(081,464,093,476) and RMouse Then Farbe(Zeichenfarbe,05);
  If MouseIn(096,464,108,476) and RMouse Then Farbe(Zeichenfarbe,06);
  If MouseIn(111,464,123,476) and RMouse Then Farbe(Zeichenfarbe,07);
  If MouseIn(126,464,138,476) and RMouse Then Farbe(Zeichenfarbe,08);
  If MouseIn(141,464,153,476) and RMouse Then Farbe(Zeichenfarbe,09);
  If MouseIn(156,464,168,476) and RMouse Then Farbe(Zeichenfarbe,10);
  If MouseIn(171,464,183,476) and RMouse Then Farbe(Zeichenfarbe,11);
  If MouseIn(186,464,198,476) and RMouse Then Farbe(Zeichenfarbe,12);
  If MouseIn(201,464,213,476) and RMouse Then Farbe(Zeichenfarbe,13);
  If MouseIn(216,464,228,476) and RMouse Then Farbe(Zeichenfarbe,14);
  If MouseIn(231,464,243,476) and RMouse Then Farbe(Zeichenfarbe,15);
  If MouseIn(625,020,635,031) and LMouse Then ProgrammClose;
 Until 1=2;
END;

BEGIN
 ProgrammInit;
 Hauptprogramm;
END.