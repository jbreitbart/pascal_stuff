{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 05.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demoprogramm zu aufz�hlbaren Datentypen.                         �
 ������������������������������������������������������������������ͼ}
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