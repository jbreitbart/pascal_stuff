{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Wandelt alle Zeichen eines Satzes in Groแbuchstaben um. Berck-  บ
 บ sichtigt auch die deutschen Umlaute.                             บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program  Grossbuchstaben;                          {Datei: Gross2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Satz: string[60];                               {Einzugebender Satz}
  i: integer;                                           {Laufvariable}

begin
  ClrScr;
  writeln('Gib einen Satz (max. 60 Zeichen) ein:');
  writeln;
  readln(Satz);                                        {Satz einlesen}
  writeln;

  for i:= 1 to Length(Satz) do     {Kleinbuchstaben in Groแbuchstaben}
  begin
    case Satz[i] of                 {deutsche Umlaute bercksichtigen}
      '': Satz[i]:= '';
      '”': Satz[i]:= '';
      '': Satz[i]:= '';
      else Satz[i]:= Upcase(Satz[i]);
    end; {case}
  end; {for}

  writeln(Satz);                         {Konvertierten Satz ausgeben}
  writeln;
  writeln('Das (',#24,') ist der Satz in Groแbuchstaben!');
  readln;                                        {Auf [Return] warten}
end.