{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 19.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Ermittelt die Gr”แe des Hauptspeichers ber Interrupt 12h.       บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program HauptspeicherErmitteln;                       {Datei: Ram.pas}
uses Crt, Dos;                         {Bibliotheken aus Turbo Pascal}
var
  Regs: Registers;
  Ram: integer;

begin
  ClrScr;
  writeln('Gr”แe des Hauptspeichers ermitteln');
  writeln;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤInterrupt 12h aufrufenฤฤ}
  Intr($12,Regs);
  Ram:= Regs.ax;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤAusgabe der Speichergr”แeฤฤ}
  writeln('Hauptspeichergr”แe: ',Ram,' Kilobyte');
  writeln;

  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.