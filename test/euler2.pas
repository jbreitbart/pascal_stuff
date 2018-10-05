{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Berechnet die Eulersche Zahl e mit Hilfe einer Reihe und legt    �
 � eine Tabelle in der Diskettendatei Euler.txt im aktuellen Ver-   �
 � zeichnis ab.                                                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program EulerscheZahl;                             {Datei: Euler2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Name = 'Euler.txt';                     {Diskettendatei mit Tabelle}

var
  e,AltesE,n,                                {n = Nenner (Fakult�ten)}
  Epsilon: real;                                         {Genauigkeit}
  i,                                                    {Laufvariable}
  Faktor: integer;                        {Zur Berechnung des Nenners}
  f: text;                                             {Dateivariable}

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � TabelleErstellen                                                 �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Schreibt die Tabelle in die Diskettendatei Euler.txt im aktuellen�
 � Verzeichnis.                                                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure TabelleErstellen;
begin
  writeln(f,(Faktor-1):3,AltesE:16:13,e:16:13,
            Faktor:5,n:12:0,(Abs(AltesE-e)):16:13);
end;
{様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様}

begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Hauptprogramm陳}
  ClrScr;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Diskettendatei �ffnen陳}
  assign(f,Name);
  {$I-}  Rewrite(f);  {$I+}                        {Neue Datei �ffnen}
  if IOResult <> 0 then Halt;                        {Programmabbruch}
  writeln(f,'Anzahl',' ':3,                              {�berschrift}
            'Altes e',' ':12,
            'e',' ':8,
            'Faktor',' ':3,
            'Nenner',' ':7,
            'Differenz');
  for i:= 1 to 68 do write(f,'=');        {�berschrift unterstreichen}
  writeln(f);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabeteil陳}
  writeln('Berechnung der Eulerschen Zahl e');
  writeln;
  write('Bitte gib Toleranz Epsilon ein (z.B.: 1E-5): ');
  readln(Epsilon);

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Initialisierungen陳}
  e:= 1;                                  {Anfangswert Eulersche Zahl}
  AltesE:= e;
  n:= 1;                                                      {Nenner}
  Faktor:= 1;
  TabelleErstellen;                 {Erste Zeile mit Voreinstellungen}

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Berechnung von e陳}
  repeat
    AltesE:= e;                           {Vorherigen Wert festhalten}
    e:= e + 1/n;                          {Neuen Wert f�r e berechnen}
    Inc(Faktor);                        {N�chsten Faktor f�r Fakult�t}
    n:= n * Faktor;                        {N�chsten Nenner berechnen}
    TabelleErstellen;
  until (Abs(AltesE - e)) < Epsilon;

  writeln;
  writeln('Berechnung bis zum Glied 1/',Faktor,'! durchgef�hrt.');
  writeln;
  writeln('e = ',e:15:13);
  close(f);                                   {Datei wieder schlie�en}
  readln;                                        {Auf [Return] warten}
end.