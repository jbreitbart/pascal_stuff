{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 09.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Keypressed: Ein nicht so guter Einsatz.                          �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program TasteDruecken;                             {Datei: Keypr1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

begin
  ClrScr;
  writeln('Demoprogramm zu Keypressed');
  writeln;

  write('Beliebige Taste dr�cken, um Programm fortzusetzen...');
  repeat
  until Keypressed;

  ClrScr;
  write('Jetzt sollte es eigentlich solange piepsen, ');
  writeln('bis eine Taste gedr�ckt wird!');
  writeln;
  writeln('Aber es piepst nur einmal!');
  writeln;

  repeat
    write(^G);                                             {Signalton}
  until Keypressed;

  write('Programmende mit [Return]...');
  readln;                                        {Auf [Return] warten}
end.