{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Entscheidung mit Alternative. Division zweier Zahlen.            �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Division2;                                {Datei: Teilen2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b: real;                                       {Die beiden Zahlen}

begin
  ClrScr;
  writeln(' ':25,'Division zweier Zahlen');
  writeln;

  write('Gib die Zahl a ein: '); readln(a);
  write('Gib die Zahl b ein: '); readln(b);
  writeln;

  if b <> 0
    then writeln('Das Ergebnis a/b lautet: ',(a/b):10:2)
    else writeln('Division durch Null ist nicht erlaubt!');

  readln;                                        {Auf [Return] warten}
end.