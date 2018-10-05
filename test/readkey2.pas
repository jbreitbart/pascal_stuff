{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 12.10.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Erweiterter Tastatur-Code: Demonstriert die Abfrage der Tastatur º
 º mit Hilfe von Readkey unter Bercksichtigung der Spezialtasten   º
 º (Funktionstasten und Tastenkombinationen). Programmende mit Esc. º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program ScanCode;                                {Datei: Readkey2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  Esc = #27;                             {ASCII-Code fr Escape-Taste}

var
  ch: char;                                              {Tastendruck}
  Taste: string;                                      {Taste als Text}

begin
  repeat
    ClrScr;
    writeln('Erweiterte Tastaturabfrage');
    writeln;
    write('Drcken Sie eine beliebige Taste ');
    write('(Ende mit [Esc]): ');

    {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTastaturabfrageÄÄ}
    ch:= Readkey;                                      {Erste Abfrage}
    writeln; writeln;
    if ch <> #0
     then writeln('Sie haben die Taste [',ch,'] gedrckt!')
     else begin
            ch:= Readkey;                             {Zweite Abfrage}
            case ch of
               #59: Taste:= '[F1]';
               #60: Taste:= '[F2]';
               #61: Taste:= '[F3]';
               #62: Taste:= '[F4]';
               #63: Taste:= '[F5]';
              #104: Taste:= '[Alt]+[F1]';
              #105: Taste:= '[Alt]+[F2]';
              #106: Taste:= '[Alt]+[F3]';
              #107: Taste:= '[Alt]+[F4]';
              #108: Taste:= '[Alt]+[F5]';
              else Taste:= 'eine Spezialtaste';
            end; {case}
            writeln('Sie haben ',Taste,' gedrckt!');
          end; {else}

    if ch <> Esc
      then begin
             GotoXY(1,25);
             write('Fortsetzen mit [Return]...');
             readln;
           end;
  until ch = Esc;                      {Escape-Taste fr Programmende}
end.