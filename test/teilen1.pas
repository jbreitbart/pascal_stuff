{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Entscheidung ohne Alternative. Division zweier Zahlen.           �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Division1;                                {Datei: Teilen1.pas}
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
    then writeln('Das Ergebnis a/b lautet: ',(a/b):10:2);

  readln;                                        {Auf [Return] warten}
end.