{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Demoprogramm zu aufz�hlbaren Datentypen.                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program AufzaehlbareTypen;                       {Datei: Aufzaehl.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

type
  Geschirr = (Tasse,Teller,Messer,Gabel,Loeffel);

var
  Besteck: Geschirr;

begin
  ClrScr;
  writeln('Demoprogramm zu aufz�hlbaren Datentypen');
  writeln;

  Besteck:= Messer;
  write('Die Elemente des Datentyps lauten: ');
  writeln('(Tasse,Teller,Messer,Gabel,Loeffel)');
  writeln;
  writeln('Das Ausgangselement ist Messer');
  writeln;
  writeln('Ordnungsnummer:             ',Ord(Besteck));

  readln;                                        {Auf [Return] warten}
end.