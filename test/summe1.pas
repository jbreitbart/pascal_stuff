{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Eindimensionale Felder: Summe von f�nf Werten berechnen.         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Summe1;                                    {Datei: Summe1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sum,                                              {Summe der Zahlen}
  x1,x2,x3,x4,x5: real;                          {Einzulesende Zahlen}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Sortieren                                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Wird sp�ter mit Inhalt gef�llt. Dient hier nur als Dummy-        �
 � Prozedur.                                                        �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Sortieren;
begin

end; {Sortieren}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin {Hauptprogramm}
  ClrScr;
  writeln;
  Sum:= 0;                                      {Summe initialisieren}

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳1. Zahl einlesen陳}
  write('1. Zahl eingeben: ');
  readln(x1);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳2. Zahl einlesen陳}
  write('2. Zahl eingeben: ');
  readln(x2);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳3. Zahl einlesen陳}
  write('3. Zahl eingeben: ');
  readln(x3);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳4. Zahl einlesen陳}
  write('4. Zahl eingeben: ');
  readln(x4);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳5. Zahl einlesen陳}
  write('5. Zahl eingeben: ');
  readln(x5);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Berechnen und ausgeben陳}
  Sum:= x1 + x2 + x3 + x4 + x5;
  writeln('Die Summe betr�gt: ',Sum:10:2);
  Sortieren;

  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.