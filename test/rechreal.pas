{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Grundrechenarten mit dem Datentyp Real.                          �
 ������������������������������������������������������������������ͼ}
Program RechnenMitReal;                          {Datei: RechReal.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Zahl1,Zahl2,
  Summe,Differenz,
  Produkt,Quotient: real;

begin
  ClrScr;
  writeln('Grundrechenarten mit dem Datentyp Real');
  writeln;
  writeln('Eingabe zweier Dezimal-Zahlen');
  writeln;
  write('Gib die erste Zahl ein : '); Readln(Zahl1);
  write('Gib die zweite Zahl ein: '); Readln(Zahl2);
  writeln;

  {������������������������������������������������������Berechnung��}
  Summe:= Zahl1 + Zahl2;                                    {Addition}
  Differenz:= Zahl1 - Zahl2;                             {Subtraktion}
  Produkt:= Zahl1 * Zahl2;                            {Multiplikation}
  Quotient:= Zahl1 / Zahl2;                                 {Division}

  {���������������������������������������������������������Ausgabe��}
  writeln('Summe     = ',Summe:10:2);
  writeln('Differenz = ',Differenz:10:2);
  writeln('Produkt   = ',Produkt:10:2);
  writeln('Quotient  = ',Quotient:10:2);

  readln;                                        {Auf [Return] warten}
end.