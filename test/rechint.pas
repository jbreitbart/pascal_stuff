{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Grundrechenarten mit dem Datentyp Integer.                       �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program RechnenMitInteger;                        {Datei: RechInt.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zahl1,Zahl2,
  Summe,Differenz,
  Produkt,
  DivErg,ModErg: integer;

begin
  ClrScr;
  writeln('Grundrechenarten mit dem Datentyp Integer');
  writeln;
  writeln('Eingabe zweier ganzer Zahlen');
  writeln;
  write('Gib die erste Zahl ein : '); Readln(Zahl1);
  write('Gib die zweite Zahl ein: '); Readln(Zahl2);
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Berechnung陳}
  Summe:= Zahl1 + Zahl2;                                    {Addition}
  Differenz:= Zahl1 - Zahl2;                             {Subtraktion}
  Produkt:= Zahl1 * Zahl2;                            {Multiplikation}
  DivErg:= Zahl1 Div Zahl2;        {Division, Rest wird abgeschnitten}
  ModErg:= Zahl1 Mod Zahl2;              {Division, ganzzahliger Rest}

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Ausgabe陳}
  writeln('Summe          = ',Summe:6);
  writeln('Differenz      = ',Differenz:6);
  writeln('Produkt        = ',Produkt:6);
  writeln('Division (Div) = ',DivErg:6);
  writeln('Division (Mod) = ',ModErg:6);

  readln;                                        {Auf [Return] warten}
end.