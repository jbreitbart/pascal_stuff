{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 17.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Pr�ft, ob ein Co-Prozessor vorhanden ist.                        �
 ������������������������������������������������������������������ͼ}
Program CoProzessor;                                 {Datei: 8087.pas}
{$N+}
uses Crt;                                {Bibliothek aus Turbo Pascal}

begin
  ClrScr;
  writeln('Test auf Co-Prozessor');
  writeln;

  write('Es ist ');
  case Test8087 of
    0: write('kein ');
    1: write('ein 8087 ');
    2: write('ein 80287 ');
    3: write('ein 80387 ');
  end; {case}
  writeln('Co-Prozessor vorhanden!');

  readln;                                        {Auf [Return] warten}
end.