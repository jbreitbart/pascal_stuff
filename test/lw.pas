{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Ermittelt das aktuelle Laufwerk �ber den Interrupt 21h, Func 19h.�
 ������������������������������������������������������������������ͼ}
Program AktLaufwerkErmitteln;                          {Datei: Lw.pas}
uses Crt, Dos;                         {Bibliotheken aus Turbo Pascal}
var
  Regs: Registers;
  Lw: byte;

begin
  ClrScr;
  writeln('Aktuelles Laufwerk ermitteln');
  writeln;

  {�������������������������������Interrupt 21h (Func 19h) aufrufen��}
  Regs.ah:= $19;
  MsDos(Regs);
  Lw:= Regs.al;

  {���������������������������������Ausgabe des aktuellen Laufwerks��}
  writeln('Das aktuelle Laufwerk ist: ',chr(Lw+65),':');
  writeln;

  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.