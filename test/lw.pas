{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 19.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Ermittelt das aktuelle Laufwerk ber den Interrupt 21h, Func 19h.บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program AktLaufwerkErmitteln;                          {Datei: Lw.pas}
uses Crt, Dos;                         {Bibliotheken aus Turbo Pascal}
var
  Regs: Registers;
  Lw: byte;

begin
  ClrScr;
  writeln('Aktuelles Laufwerk ermitteln');
  writeln;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤInterrupt 21h (Func 19h) aufrufenฤฤ}
  Regs.ah:= $19;
  MsDos(Regs);
  Lw:= Regs.al;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤAusgabe des aktuellen Laufwerksฤฤ}
  writeln('Das aktuelle Laufwerk ist: ',chr(Lw+65),':');
  writeln;

  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.