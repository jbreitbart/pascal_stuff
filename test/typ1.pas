{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Schreibt Daten in eine typisierte Datei.                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program InTypisierteDateiSchreiben;                  {Datei: Typ1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'TestStr.Dat';                               {Diskettendatei}
  n = 10;                                        {Anzahl der Elemente}

type
  Str20 = string[20];

var
  Element: array[1..n] of Str20;
  f: file of Str20;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � ElementeSchreiben                                                �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Schreibt die Elemente in die Diskettendatei.                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure ElementeSchreiben;
var i: integer;                                         {Z�hlvariable}
begin
  writeln('Folgende Elemente werden geschrieben:');
  writeln;
  for i:= 1 to n do
  begin
    write(f,Element[i]);
    writeln(i:3,': ',Element[i]);
  end; {for}
  writeln;
  writeln('Anzahl der Elemente: ',FileSize(f));
end; {ElementeSchreiben}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � FeldInit                                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert das Feld mit den Namen.                            �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure FeldInit;
begin
  Element[1]:= 'Schmidtke';     Element[2]:= 'Flathmann';
  Element[3]:= 'Hansen';        Element[4]:= 'Rowohlt';
  Element[5]:= 'Emmerich';      Element[6]:= 'Becker';
  Element[7]:= 'Schulz';        Element[8]:= 'Tietze';
  Element[9]:= 'Behrens';       Element[10]:= 'Wunder';
end; {FeldInit}

begin {Hauptprogramm}
  ClrScr;
  writeln('In eine typisierte Datei schreiben');
  writeln;

  FeldInit;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Rewrite(f);                                     {Neue Datei anlegen}
  {$I+}
  if IOResult = 0
  then begin {陳陳陳陳陳陳陳陳陳陳陳陳�Wenn kein Fehler beim �ffnen陳}
         ElementeSchreiben;
         close(f);                            {Datei wieder schlie�en}
       end {then}
  else begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Wenn Fehler beim �ffnen陳}
         writeln('Fehler beim Erzeugen der Datei!!');
         writeln;
         writeln('Programm wird beendet.');         
       end; {else}

  GotoXY(1,25);
  write('Bitte [Return]-Taste dr�cken...');
  readln;                                        {Auf [Return] warten}
end.