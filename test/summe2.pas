{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Eindimensionale Felder: Summe von f�nf Werten berechnen.         �
 ������������������������������������������������������������������ͼ}
Program Summe2;                                    {Datei: Summe2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sum: real;                                        {Summe der Zahlen}
  x: array[1..5] of real;              {Feld mit einzulesenden Zahlen}
  i: integer;                                           {Z�hlvariable}

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

  {�������������������������������������������������Zahlen einlesen��}
  for i:= 1 to 5 do
  begin
    write(i,'. Zahl eingeben: ');
    readln(x[i]);
  end;
  {������������������������������������������Berechnen und ausgeben��}
  for i:= 1 to 5
    do Sum:= Sum + x[i];

  writeln('Die Summe betr�gt: ',Sum:10:2);
  Sortieren;

  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.