{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Eindimensionale Felder: Bubble-Sort.                             �
 ������������������������������������������������������������������ͼ}
Program BubbleSort;                                 {Datei: Sort2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  n = 50;                                        {Anzahl der Elemente}

var
  x: array[1..n] of integer;           {Feld mit einzulesenden Zahlen}
  AnzV,                                        {Anzahl der Vergleiche}
  AnzT: integer;                        {Anzahl der Tauschoperationen}

{������������������������������������������������������������������Ŀ
 � Warten                                                           �
 ������������������������������������������������������������������Ĵ
 � Wartet in der 25. Zeile auf einen Tastendruck zum Beenden des    �
 � Programms.                                                       �
 ��������������������������������������������������������������������}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{������������������������������������������������������������������Ŀ
 � ZahlenErzeugen                                                   �
 ������������������������������������������������������������������Ĵ
 � Erzeugt 50 Zufallszahlen aus dem Bereich 0..499.                 �
 ��������������������������������������������������������������������}
procedure ZahlenErzeugen;
var i: integer;                                         {Z�hlvariable}
begin
  Randomize;                   {Zufallszahlengenerator initialisieren}
  for i:= 1 to n do
    x[i]:= Random(500);
end; {ZahlenErzeugen}
{������������������������������������������������������������������Ŀ
 � FeldAusgeben                                                     �
 ������������������������������������������������������������������Ĵ
 � Gibt das Feld mit den Werten auf dem Bildschirm aus.             �
 ��������������������������������������������������������������������}
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
{������������������������������������������������������������������Ŀ
 � Sortieren                                                        �
 ������������������������������������������������������������������Ĵ
 � Bubble-Sort. Sortiert das Feld aufsteigend.                      �
 ��������������������������������������������������������������������}
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
{������������������������������������������������������������������Ŀ
 � AnzahlAusgeben                                                   �
 ������������������������������������������������������������������Ĵ
 � Gibt die Anzahl der Vergleichs- und Tauschoperationen auf dem    �
 � Bildschirm aus.                                                  �
 ��������������������������������������������������������������������}
procedure AnzahlAusgeben(AnzV,AnzT: integer); 
begin
  writeln;
  writeln('Anzahl der Vergleichsoperationen: ',AnzV:4);
  writeln('Anzahl der Tauschoperationen    : ',AnzT:4);
end; {AnzahlAusgeben}

{��������������������������������������������������������������������}

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