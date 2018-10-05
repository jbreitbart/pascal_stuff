{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Ermittelt die Gr��e des Hauptspeichers �ber Interrupt 12h.       �
 ������������������������������������������������������������������ͼ}
Program HauptspeicherErmitteln;                       {Datei: Ram.pas}
uses Crt, Dos;                         {Bibliotheken aus Turbo Pascal}
var
  Regs: Registers;
  Ram: integer;

begin
  ClrScr;
  writeln('Gr��e des Hauptspeichers ermitteln');
  writeln;

  {������������������������������������������Interrupt 12h aufrufen��}
  Intr($12,Regs);
  Ram:= Regs.ax;

  {���������������������������������������Ausgabe der Speichergr��e��}
  writeln('Hauptspeichergr��e: ',Ram,' Kilobyte');
  writeln;

  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.