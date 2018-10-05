{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 05.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Addiert (verknpft) zwei Zeichenketten mit dem [+]-Zeichen.      บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program AddString;                                 {Datei: AddStr.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Name,Vorname,Nachname: string;

begin
  ClrScr;
  writeln('Addition (Verkettung zweier Zeichenketten.');
  writeln;

  write('Geben Sie Ihren Vornamen ein : ');
  readln(Vorname);
  write('Geben Sie Ihren Nachnamen ein: ');
  readln(Nachname);
  writeln;

  Name:= Vorname + ' ' + Nachname;

  write('Sie heiแen ',Name);

  readln;                                        {Auf [Return] warten}
end.