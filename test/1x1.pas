{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 30.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Prozeduren: Das 'Kleine 1 x 1'.                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Kleines1x1;                                   {Datei: 1x1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b,c,i: integer;                                {Globale Variablen}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Ueberschrift                                                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Ueberschrift;
begin
  GotoXY(24,1);
  writeln('Das ''Kleine 1 x 1''');
  writeln;
end; {Ueberschrift}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Striche                                                          �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Striche;
var i: integer;                                  {Lokale Z�hlvariable}

begin
  writeln;
  write('    ');                                    {Vier Leerzeichen}
  for i:= 1 to 56 do write('-');
  writeln;
end; {Striche}
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Rechnen                                                          �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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