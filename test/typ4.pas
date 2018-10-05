{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � L�scht Elemente aus einer typisierten Datei.                     �
 ������������������������������������������������������������������ͼ}
Program ElementeLoeschen;                            {Datei: Typ4.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'TestStr.Dat';                               {Diskettendatei}

type
  Str20 = string[20];

var
  Element: Str20;
  f: file of Str20;

{������������������������������������������������������������������Ŀ
 � Warten                                                           �
 ������������������������������������������������������������������Ĵ
 � Wartet in der 25. Zeile auf das Dr�cken einer Taste.             �
 ��������������������������������������������������������������������}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
  GotoXY(1,25);
  ClrEol;
end; {Warten}
{������������������������������������������������������������������Ŀ
 � ElementeLesen                                                    �
 ������������������������������������������������������������������Ĵ
 � Liest die Elemente aus der Diskettendatei.                       �
 ��������������������������������������������������������������������}
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
{������������������������������������������������������������������Ŀ
 � Loeschen                                                         �
 ������������������������������������������������������������������Ĵ
 � L�scht ein angegebenes Element.                                  �
 ��������������������������������������������������������������������}
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
{������������������������������������������������������������������Ŀ
 � Fragen                                                           �
 ������������������������������������������������������������������Ĵ
 � Fragt, welche Position gel�scht werden soll.                     �
 ��������������������������������������������������������������������}
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
{��������������������������������������������������������������������}

begin {Hauptprogramm}
  ClrScr;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Reset(f);                                       {Neue Datei anlegen}
  {$I+}
  if IOResult = 0
  then begin {�������������������������Wenn kein Fehler beim �ffnen��}
         ElementeLesen;
         Fragen;
         ElementeLesen;
         Warten;
         close(f);                            {Datei wieder schlie�en}
       end {then}
  else begin {������������������������������Wenn Fehler beim �ffnen��}
         writeln('Fehler beim �ffnen der Datei!!');
         writeln;
         writeln('Programm wird beendet.');
         Warten;         
       end; {else}

  ClrScr;
end.