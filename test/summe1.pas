{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Eindimensionale Felder: Summe von f�nf Werten berechnen.         �
 ������������������������������������������������������������������ͼ}
Program Summe1;                                    {Datei: Summe1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sum,                                              {Summe der Zahlen}
  x1,x2,x3,x4,x5: real;                          {Einzulesende Zahlen}

{������������������������������������������������������������������Ŀ
 � Sortieren                                                        �
 ������������������������������������������������������������������Ĵ
 � Wird sp�ter mit Inhalt gef�llt. Dient hier nur als Dummy-        �
 � Prozedur.                                                        �
 ��������������������������������������������������������������������}
procedure Sortieren;
begin

end; {Sortieren}
{��������������������������������������������������������������������}

begin {Hauptprogramm}
  ClrScr;
  writeln;
  Sum:= 0;                                      {Summe initialisieren}

  {������������������������������������������������1. Zahl einlesen��}
  write('1. Zahl eingeben: ');
  readln(x1);

  {������������������������������������������������2. Zahl einlesen��}
  write('2. Zahl eingeben: ');
  readln(x2);

  {������������������������������������������������3. Zahl einlesen��}
  write('3. Zahl eingeben: ');
  readln(x3);

  {������������������������������������������������4. Zahl einlesen��}
  write('4. Zahl eingeben: ');
  readln(x4);

  {������������������������������������������������5. Zahl einlesen��}
  write('5. Zahl eingeben: ');
  readln(x5);

  {������������������������������������������Berechnen und ausgeben��}
  Sum:= x1 + x2 + x3 + x4 + x5;
  writeln('Die Summe betr�gt: ',Sum:10:2);
  Sortieren;

  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.