{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 16.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Datentyp INTEGER: Gibt kleinste und gr��te Integer- und LongInt- �
 � Zahl auf dem Bildschirm aus.                                     �
 ������������������������������������������������������������������ͼ}
Program MinMaxInteger;                                {Datei: Max.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  MinInt = -MaxInt - 1;
  MinLongInt = -MaxLongInt - 1;

begin
  ClrScr;
  writeln('Kleinste und gr��te Integer- und LongInt-Zahl');
  writeln;

  writeln('Gr��te Integer-Zahl  : ',MaxInt);
  writeln('Kleinste Integer-Zahl: ',MinInt);
  writeln;
  writeln('Gr��te LongInt-Zahl  : ',MaxLongInt);
  writeln('Kleinste LongInt-Zahl: ',MinLongInt);

  readln;                                        {Auf [Return] warten}
end.