{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Ermittelt das aktuelle Laufwerk �ber den Interrupt 21h, Func 19h.�
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program AktLaufwerkErmitteln;                          {Datei: Lw.pas}
uses Crt, Dos;                         {Bibliotheken aus Turbo Pascal}
var
  Regs: Registers;
  Lw: byte;

begin
  ClrScr;
  writeln('Aktuelles Laufwerk ermitteln');
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Interrupt 21h (Func 19h) aufrufen陳}
  Regs.ah:= $19;
  MsDos(Regs);
  Lw:= Regs.al;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Ausgabe des aktuellen Laufwerks陳}
  writeln('Das aktuelle Laufwerk ist: ',chr(Lw+65),':');
  writeln;

  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.