{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Berechnet die Eulersche Zahl e mit Hilfe einer Reihe.            �
 ������������������������������������������������������������������ͼ}
Program EulerscheZahl;                              {Datei: Euler.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  e,AltesE,n,                                {n = Nenner (Fakult�ten)}
  Epsilon: real;                                         {Genauigkeit}
  Faktor: integer;                        {Zur Berechnung des Nenners}

begin
  ClrScr;
  writeln('Berechnung der Eulerschen Zahl e');
  writeln;
  write('Bitte gib Toleranz Epsilon ein (z.B.: 1E-5): ');
  readln(Epsilon);

  {�����������������������������������������������Initialisierungen��}
  e:= 1;                                  {Anfangswert Eulersche Zahl}
  n:= 1;                                                      {Nenner}
  Faktor:= 1;

  {������������������������������������������������Berechnung von e��}
  repeat
    AltesE:= e;                           {Vorherigen Wert festhalten}
    e:= e + 1/n;                          {Neuen Wert f�r e berechnen}
    Inc(Faktor);                        {N�chsten Faktor f�r Fakult�t}
    n:= n * Faktor;                        {N�chsten Nenner berechnen}
  until (Abs(AltesE - e)) < Epsilon;

  writeln;
  writeln('Berechnung bis zum Glied 1/',Faktor,'! durchgef�hrt.');
  writeln;
  writeln('e = ',e:15:13);
  readln;                                        {Auf [Return] warten}
end.