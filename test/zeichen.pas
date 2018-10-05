{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Demonstriert den Datentyp Char und verwendet dabei die Routinen  บ
 บ Chr, Ord, Pred, Succ und Upcase.                                 บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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
  writeln('Vorgnger:                  ',Pred(ch));
  writeln('Nachfolger:                 ',Succ(ch));
  writeln('Groแbuchstabe:              ',Upcase(ch));

  readln;                                        {Auf [Return] warten}
end.