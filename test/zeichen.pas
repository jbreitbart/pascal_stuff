{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demonstriert den Datentyp Char und verwendet dabei die Routinen  �
 � Chr, Ord, Pred, Succ und Upcase.                                 �
 ������������������������������������������������������������������ͼ}
Program DatentypChar;                             {Datei: Zeichen.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  ch = 'b';                                          {Ausgangszeichen}

begin
  ClrScr;
  writeln('Demoprogramm zum Datentyp CHAR');
  writeln;

  writeln('Das Ausgangszeichen lautet: ',ch);
  writeln;
  writeln('Ordnungsnummer:             ',Ord(ch));
  writeln('Vorg�nger:                  ',Pred(ch));
  writeln('Nachfolger:                 ',Succ(ch));
  writeln('Gro�buchstabe:              ',Upcase(ch));

  readln;                                        {Auf [Return] warten}
end.