{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Demonstriert den Datentyp Integer und verwendet dabei die        �
 � Routinen Abs, Round, Sqr und Trunc.                              �
 ������������������������������������������������������������������ͼ}
Program DatentypInteger;                             {Datei: RInt.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

begin
  ClrScr;
  writeln('Demoprogramm zum Datentyp INTEGER');
  writeln;

  writeln('x = -3,    Abs(-3)     = ',Abs(-3)); writeln;
  writeln('x = 25.7,  Round(25.7) = ',Round(25.7)); writeln;
  writeln('x = 4,     Sqr(4)      = ',Sqr(4)); writeln;
  writeln('x = 25.7,  Trunc(25.7) = ',Trunc(25.7)); writeln;

  readln;                                        {Auf [Return] warten}
end.
