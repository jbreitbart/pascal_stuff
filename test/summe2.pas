{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Eindimensionale Felder: Summe von f�nf Werten berechnen.         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Summe2;                                    {Datei: Summe2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sum: real;                                        {Summe der Zahlen}
  x: array[1..5] of real;              {Feld mit einzulesenden Zahlen}
  i: integer;                                           {Z�hlvariable}

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

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Zahlen einlesen陳}
  for i:= 1 to 5 do
  begin
    write(i,'. Zahl eingeben: ');
    readln(x[i]);
  end;
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Berechnen und ausgeben陳}
  for i:= 1 to 5
    do Sum:= Sum + x[i];

  writeln('Die Summe betr�gt: ',Sum:10:2);
  Sortieren;

  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.