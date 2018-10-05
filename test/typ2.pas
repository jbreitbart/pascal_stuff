{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Liest Daten aus einer typisierten Datei.                         �
 ������������������������������������������������������������������ͼ}
Program AusTypisierterDateiLesen;                    {Datei: Typ2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'TestStr.Dat';                               {Diskettendatei}

type
  Str20 = string[20];

var
  Element: Str20;
  f: file of Str20;

{������������������������������������������������������������������Ŀ
 � ElementeLesen                                                    �
 ������������������������������������������������������������������Ĵ
 � Liest die Elemente aus der Diskettendatei.                       �
 ��������������������������������������������������������������������}
procedure ElementeLesen;
var i: integer;                                         {Z�hlvariable}
begin
  writeln('Folgende Elemente wurden gelesen:');
  writeln;
  writeln('Anzahl der Elemente: ',FileSize(f));
  writeln;
  i:= 0;                                                 {Anfangswert}

  while not Eof(f) do
  begin
    Inc(i);                                        {i um Eins erh�hen}
    read(f,Element);                                   {Element lesen}
    writeln(i:3,': ',Element);                     {Bildschirmausgabe}
  end; {while}
  writeln;
end; {ElementeLesen}
{��������������������������������������������������������������������}

begin {Hauptprogramm}
  ClrScr;
  writeln('Aus einer typisierten Datei lesen');
  writeln;

  Assign(f,Name);                                  {Dateien verbinden}
  {$I-}                                  {Fehlererkennung ausschalten}
  Reset(f);                                       {Neue Datei anlegen}
  {$I+}
  if IOResult = 0
  then begin {�������������������������Wenn kein Fehler beim �ffnen��}
         ElementeLesen;
         close(f);                            {Datei wieder schlie�en}
       end {then}
  else begin {������������������������������Wenn Fehler beim �ffnen��}
         writeln('Fehler beim �ffnen der Datei!!');
         writeln;
         writeln('Programm wird beendet.');         
       end; {else}

  GotoXY(1,25);
  write('Bitte [Return]-Taste dr�cken...');
  readln;                                        {Auf [Return] warten}
end.