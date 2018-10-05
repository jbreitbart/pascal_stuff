{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Bringt mit Hilfe einer For-Schleife die Ascii-Zeichen auf den    บ
 บ Bildschirm.                                                      บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program AsciiZeichen;                               {Datei: Ascii.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Nr: integer;                           {Ordnungsnummer des Zeichens}
  ch: char;                                              {Ein Zeichen}

begin
  ClrScr;
  writeln('ASCII-Zeichensatz aufsteigend');
  writeln;
  for Nr:= 0 to 255 do write(chr(Nr),' ');
  writeln;

  writeln('ASCII-Zeichensatz absteigend');
  for Nr:= 255 downto 0 do write(chr(Nr),' ');
  writeln;

  writeln('Jetzt nur noch Groแbuchstaben');
  for ch:= 'A' to 'Z' do
  begin
    write(ch,' ');
    delay(300);
  end; {for}
  writeln; writeln;

  writeln('Und jetzt Kleinbuchstaben');
  for ch:= #97 to #122 do
  begin
    write(ch,' ');
    delay(300);
  end; {for}
  readln;                                        {Auf [Return] warten}
end.