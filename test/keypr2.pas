{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autor: Reiner Sch”lles, 09.09.92                 º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 º Keypressed: Schon besser als Keypr1.pas.                         º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program NochmalTasteDruecken;                      {Datei: Keypr2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  ch: char;                   {Variable wird fr Tastendruck ben”tigt}

begin
  ClrScr;
  writeln('Demoprogramm zu Keypressed');
  writeln;

  write('Beliebige Taste drcken, um Programm fortzusetzen...');
  repeat
  until Keypressed;
  ch:= Readkey;                                      { --> Neue Zeile}

  ClrScr;
  write('Jetzt sollte es eigentlich solange piepsen, ');
  writeln('bis eine Taste gedrckt wird!');
  writeln;
  writeln('Und es piepst tats„chlich st„ndig!');
  writeln;

  repeat
    write(^G);                                             {Signalton}
  until Keypressed;

  write('Programmende mit [Return]...');
  readln;                                        {Auf [Return] warten}
end.