{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Unterprogramme: Unterschiede zwischen Wert- und Var-Parametern.  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Parameter;                                {Datei: WertVar.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b: integer;                                    {Globale Variablen}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � Uebergabe                                                        �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Dient der �bergabe von Wert- und Variablenparametern.            �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
procedure Uebergabe(a: integer; var b: integer);
begin
  a:= a + 100;
  b:= b + 100;
  write('Innerhalb der Prozedur UEBERGABE            : ');
  writeln('a = ',a:3,'       ','b = ',b:3);
end; {Uebergabe}
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin {Hauptprogramm}
  ClrScr;
  a:= 1;
  b:= 2;
  writeln('a ---> Wertparameter');
  writeln('b ---> Variablenparameter');
  writeln('=========================');
  writeln;
  write('Vor dem Aufruf der Prozedur UEBERGABE       : ');
  writeln('a = ',a:3,'       ','b = ',b:3);
  Uebergabe(a,b);
  write('Nach dem Verlassen der Prozedur UEBERGABE   : ');
  writeln('a = ',a:3,'       ','b = ',b:3);
  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.