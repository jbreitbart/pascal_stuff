{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 30.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Prozeduren: Das 'Kleine 1 x 1'.                                  �
 ������������������������������������������������������������������ͼ}
Program Kleines1x1;                                   {Datei: 1x1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b,c,i: integer;                                {Globale Variablen}

{������������������������������������������������������������������Ŀ
 � Ueberschrift                                                     �
 ��������������������������������������������������������������������}
procedure Ueberschrift;
begin
  GotoXY(24,1);
  writeln('Das ''Kleine 1 x 1''');
  writeln;
end; {Ueberschrift}
{������������������������������������������������������������������Ŀ
 � Striche                                                          �
 ��������������������������������������������������������������������}
procedure Striche;
var i: integer;                                  {Lokale Z�hlvariable}

begin
  writeln;
  write('    ');                                    {Vier Leerzeichen}
  for i:= 1 to 56 do write('-');
  writeln;
end; {Striche}
{������������������������������������������������������������������Ŀ
 � Rechnen                                                          �
 ��������������������������������������������������������������������}
procedure Rechnen;
begin
  c:= c + b;
end; {Rechnen}

begin {Hauptprogramm}
  ClrScr;
  Ueberschrift;

  for a:= 0 to 9 do
  begin
    b:= a + 1;                     {Anfangswert je Schleifendurchlauf}
    c:= a + 1;                     {Anfangswert je Schleifendurchlauf}
    write(c:6);

    for i:= 1 to 9 do
    begin
      Rechnen;
      write(c:6);
    end; {for i}

    Striche;
  end; {for a}

  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.