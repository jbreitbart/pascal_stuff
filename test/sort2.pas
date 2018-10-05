{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Eindimensionale Felder: Bubble-Sort.                             �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program BubbleSort;                                 {Datei: Sort2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  n = 50;                                        {Anzahl der Elemente}

var
  x: array[1..n] of integer;           {Feld mit einzulesenden Zahlen}
  AnzV,                                        {Anzahl der Vergleiche}
  AnzT: integer;                        {Anzahl der Tauschoperationen}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Warten                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Wartet in der 25. Zeile auf einen Tastendruck zum Beenden des    �
 � Programms.                                                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � ZahlenErzeugen                                                   �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Erzeugt 50 Zufallszahlen aus dem Bereich 0..499.                 �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure ZahlenErzeugen;
var i: integer;                                         {Z�hlvariable}
begin
  Randomize;                   {Zufallszahlengenerator initialisieren}
  for i:= 1 to n do
    x[i]:= Random(500);
end; {ZahlenErzeugen}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � FeldAusgeben                                                     �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Gibt das Feld mit den Werten auf dem Bildschirm aus.             �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure FeldAusgeben;
var i: integer;                                         {Z�hlvariable}
begin
  for i:= 1 to n do
  begin
    write(x[i]:5);
    if i mod 10 = 0
      then writeln;                                   {Zeilenvorschub}
  end; {for}
  writeln;
  writeln;
end; {FeldAusgeben}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Sortieren                                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Bubble-Sort. Sortiert das Feld aufsteigend.                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Sortieren(var AnzV,AnzT: integer);
var
  Help: integer;                                       {Hilfsvariable}
  i,j: integer;                                        {Z�hlvariablen}

begin
  AnzV:= 0;                                              {Anfangswert}
  AnzT:= 0;

  for i:= 1 to n-1 do
  begin

    for j:= i+1 to n do
    begin
      Inc(AnzV);
      if x[i] > x[j] then
      begin
        Inc(AnzT);
        Help:= x[i];
        x[i]:= x[j];
        x[j]:= Help;
      end; {if}
    end; {for j}

  end; {for i}
end; {Sortieren}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � AnzahlAusgeben                                                   �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Gibt die Anzahl der Vergleichs- und Tauschoperationen auf dem    �
 � Bildschirm aus.                                                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure AnzahlAusgeben(AnzV,AnzT: integer); 
begin
  writeln;
  writeln('Anzahl der Vergleichsoperationen: ',AnzV:4);
  writeln('Anzahl der Tauschoperationen    : ',AnzT:4);
end; {AnzahlAusgeben}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin {Hauptprogramm}
  ClrScr;
  ZahlenErzeugen;
  writeln('Unsortiert...');
  writeln;
  FeldAusgeben;

  Sortieren(AnzV,AnzT);
  writeln('Sortiert...');
  writeln;
  FeldAusgeben;
  AnzahlAusgeben(AnzV,AnzT);

  Warten;
end.