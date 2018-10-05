{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Eindimensionale Felder: Ripple-Sort.                             �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Summe3;                                    {Datei: Summe3.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Max = 5;                                       {Anzahl der Elemente}

var
  Sum: real;                                        {Summe der Zahlen}
  x: array[1..5] of real;              {Feld mit einzulesenden Zahlen}
  i: integer;                                           {Z�hlvariable}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Sortieren                                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Ripple-Sort. Sortiert das Feld aufsteigend.                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Sortieren;
var
  SortiertOk: boolean;
  Help: real;                                          {Hilfsvariable}
  i: integer;                                           {Z�hlvariable}

begin
  repeat
    SortiertOk:= true;

    for i:= 1 to Max-1 do
    begin
      if x[i+1] < x[i] then
      begin
        SortiertOk:= false;
        Help:= x[i];                                 {Element sichern}
        x[i]:= x[i+1];                          {Elemente vertauschen}
        x[i+1]:= Help;                                {Element zur�ck}
      end; {if}
    end; {for}

  until SortiertOk;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Sortierte Zahlen ausgeben陳}
  writeln;
  writeln('Zahlen aufsteigend:');
  writeln;
  for i:= 1 to Max do write(x[i]:10:1);
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