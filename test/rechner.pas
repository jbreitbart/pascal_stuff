{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Beispielprogramm zum Einsatz einer Unit.                         �
 ������������������������������������������������������������������ͼ}
Program Rechner;                                  {Datei: Rechner.pas}
uses
  Crt,                                   {Bibliothek aus Turbo Pascal}
  Rechnen;                                 {Die gerade erstellte Unit}

var
  x1,x2: real;                                {Zwei globale Variablen}

begin {Hauptprogramm}
  repeat

    {��������������������������������������������x1 und x2 einlesen��}
    write('Gib x1 ein: ');
    readln(x1);
    write('Gib x2 ein: ');
    readln(x2);

    {������������������������������������������Ergebnisse berechnen��}
    writeln;
    writeln('Ergebnis der Addition:    ',Plus(x1,x2):10:2);
    writeln;
    writeln('Ergebnis der Subtraktion: ',Minus(x1,x2):10:2);
    writeln;

    {������������������������������������������������������Abschlu���}
    write('Zum Abschlu� [Return] dr�cken...');
    readln;
    ClrScr;

  until (x1 = 0) and (x2 = 0);
end.
{������������������������������������������������������Programmende��}

