{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Include-Dateien: Vollst�ndiges Beispielprogramm.                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Beispielprogramm;                        {Datei: IncTest1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Sternchen,LenLinie: integer;

{$I Diverse.Inc}           { <-- Neu eingef�gte Zeile (Include-Datei)}

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