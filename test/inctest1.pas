{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Include-Dateien: Vollst�ndiges Beispielprogramm.                 �
 ������������������������������������������������������������������ͼ}
Program Beispielprogramm;                        {Datei: IncTest1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sternchen,LenLinie: integer;

{������������������������������������������������������������������Ŀ
 � Sterne                                                           �
 ������������������������������������������������������������������Ĵ
 � Zeichnet eine bestimmte Anzahl von Sternen auf den Bildschirm.   �
 ��������������������������������������������������������������������}
procedure Sterne(Anz: integer);
var i: integer;                                         {Z�hlvariable}

begin
  for i:= 1 to Anz do write('*');
end; {Sterne}
{������������������������������������������������������������������Ŀ
 � Linien                                                           �
 ������������������������������������������������������������������Ĵ
 � Zeichnet eine Linie auf den Bildschirm.                          �
 ��������������������������������������������������������������������}
procedure Linien(Laenge: integer);
const
  Zeichen = #196;                                      {ASCII-Zeichen}

var
  i: integer;                                           {Z�hlvariable}

begin
  for i:= 1 to Laenge do write(Zeichen);
end; {Linien}
{������������������������������������������������������������������Ŀ
 � Warten                                                           �
 ������������������������������������������������������������������Ĵ
 � Wartet in der 25. Zeile auf einen beliebigen Tastendruck.        �
 ��������������������������������������������������������������������}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  ch:= Readkey;
end; {Warten}
{��������������������������������������������������������������������}

begin {Hauptprogramm}
  ClrScr;
  writeln('Beispielprogramm f�r Include-Dateien');
  writeln;

  write('Anzahl der Sternchen: ');
  readln(Sternchen);
  write('L�nge der Linie     : ');
  readln(LenLinie);

  GotoXY(1,10); Sterne(Sternchen);
  GotoXY(1,15); Linien(LenLinie);

  Warten;
end.