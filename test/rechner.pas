{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Beispielprogramm zum Einsatz einer Unit.                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program Rechner;                                  {Datei: Rechner.pas}
uses
  Crt,                                   {Bibliothek aus Turbo Pascal}
  Rechnen;                                 {Die gerade erstellte Unit}

var
  x1,x2: real;                                {Zwei globale Variablen}

begin {Hauptprogramm}
  repeat

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳x1 und x2 einlesen陳}
    write('Gib x1 ein: ');
    readln(x1);
    write('Gib x2 ein: ');
    readln(x2);

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Ergebnisse berechnen陳}
    writeln;
    writeln('Ergebnis der Addition:    ',Plus(x1,x2):10:2);
    writeln;
    writeln('Ergebnis der Subtraktion: ',Minus(x1,x2):10:2);
    writeln;

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Abschlu當�}
    write('Zum Abschlu� [Return] dr�cken...');
    readln;
    ClrScr;

  until (x1 = 0) and (x2 = 0);
end.
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Programmende陳}

