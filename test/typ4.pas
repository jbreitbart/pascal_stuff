{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � L�scht Elemente aus einer typisierten Datei.                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program ElementeLoeschen;                            {Datei: Typ4.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'TestStr.Dat';                               {Diskettendatei}

type
  Str20 = string[20];

var
  Element: Str20;
  f: file of Str20;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Warten                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Wartet in der 25. Zeile auf das Dr�cken einer Taste.             �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
  GotoXY(1,25);
  ClrEol;
end; {Warten}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � ElementeLesen                                                    �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Liest die Elemente aus der Diskettendatei.                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure ElementeLesen;
var i: integer;                                         {Z�hlvariable}
begin
  ClrScr;
  Seek(f,0);                             {Dateizeiger auf Dateianfang}
  writeln('Datei enth�lt folgende Elemente:');
  writeln;
  writeln('Anzahl der Elemente: ',FileSize(f));
  writeln;
  i:= -1;                                                {Anfangswert}

  while not Eof(f) do
  begin
    Inc(i);                                        {i um Eins erh�hen}
    read(f,Element);                                   {Element lesen}
    writeln(i:3,': ',Element);                     {Bildschirmausgabe}
  end; {while}
end; {ElementeLesen}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Loeschen                                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � L�scht ein angegebenes Element.                                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Loeschen(LoeschPos: LongInt);
var i: LongInt;                                         {Z�hlvariable}

begin
  if LoeschPos = FileSize(f) - 1
  then begin
         { Wenn das letzte Element gel�scht werden soll, dann }
         { hier keine Aktion, da sowieso gleich abgeschnitten }
         { wird!                                              }
       end {then}
  else begin
         for i:= LoeschPos + 1 to (FileSize(f) - 1) do
         begin
           Seek(f,i);                        {Auf das n�chste Element}
           read(f,Element);                            {Element lesen}
           Seek(f,(i-1));                         {Ein Element zur�ck}
           write(f,Element);                       {Element schreiben}
         end; {for}
       end; {else}

  Seek(f,(FileSize(f) - 1));                  {Auf das letzte Element}
  Truncate(f);                           {Letztes Element abschneiden}
end; {Loeschen}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Fragen                                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Fragt, welche Position gel�scht werden soll.                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Fragen;
var
  Position, Anz: LongInt;

begin
  Anz:= FileSize(f);
  if Anz = 0
  then begin
         ClrScr;
         writeln('Datei enth�lt keine Elemente zum L�schen!');
         Warten;
       end {then}
  else begin
         repeat
           GotoXY(1,24);
           write('Welche Position soll gel�scht werden? ');
           readln(Position);
         until (Position >= 0) and (Position <= Anz-1);
         Loeschen(Position);
       end; {else}
end; {Fragen}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin {Hauptprogramm}
  ClrScr;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Reset(f);                                       {Neue Datei anlegen}
  {$I+}
  if IOResult = 0
  then begin {陳陳陳陳陳陳陳陳陳陳陳陳�Wenn kein Fehler beim �ffnen陳}
         ElementeLesen;
         Fragen;
         ElementeLesen;
         Warten;
         close(f);                            {Datei wieder schlie�en}
       end {then}
  else begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Wenn Fehler beim �ffnen陳}
         writeln('Fehler beim �ffnen der Datei!!');
         writeln;
         writeln('Programm wird beendet.');
         Warten;         
       end; {else}

  ClrScr;
end.