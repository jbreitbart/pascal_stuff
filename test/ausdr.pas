{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 06.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Verkn�pfung von Ausdr�cken.                                      �
 ������������������������������������������������������������������ͼ}
Program Verknuepfungen;                             {Datei: Ausdr.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  A,B: boolean;                                  {Boolesche Variablen}
  i: integer;

begin
  ClrScr;
  writeln(' ':15,'Verkn�pfung zweier Ausdr�cke mit AND');
  writeln;

  writeln('Die Bedingung lautet: (i > -5) AND (i < 0)');
  writeln;

  write('Gib eine Integer-Zahl i ein: ');
  readln(i);
  writeln;

  A:= (i > -5);
  B:= (i < 0);

  if A AND B
    then writeln('Der Gesamtausdruck ist TRUE')
    else writeln('Der Gesamtausdruck ist FALSE');

  readln;                                        {Auf [Return] warten}
end.