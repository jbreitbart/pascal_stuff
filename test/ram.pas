{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Ermittelt die Gr��e des Hauptspeichers �ber Interrupt 12h.       �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program HauptspeicherErmitteln;                       {Datei: Ram.pas}
uses Crt, Dos;                         {Bibliotheken aus Turbo Pascal}
var
  Regs: Registers;
  Ram: integer;

begin
  ClrScr;
  writeln('Gr��e des Hauptspeichers ermitteln');
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Interrupt 12h aufrufen陳}
  Intr($12,Regs);
  Ram:= Regs.ax;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Ausgabe der Speichergr��e陳}
  writeln('Hauptspeichergr��e: ',Ram,' Kilobyte');
  writeln;

  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.