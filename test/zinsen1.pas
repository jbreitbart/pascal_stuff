{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Berechnet mit Hilfe einer Repeat-Schleife Jahreszinsen.          �
 ������������������������������������������������������������������ͼ}
Program Jahreszinsen;                             {Datei: Zinsen1.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Kapital,Prozentsatz,
  Zinsen,Help: real;

begin
  ClrScr;
  writeln('Jahreszinsen f�r  p = 8.5% bis 9.5%');
  writeln;

  write('Geben Sie das Kapital ein: ');
  readln(Kapital);
  writeln;
  Help:= Kapital/100;                            {Konstante berechnen}
  Prozentsatz:= 8.4;                                     {Anfangswert}

  repeat
    Prozentsatz:= Prozentsatz + 0.1;            {N�chsten Prozentsatz}
    Zinsen:= Help * Prozentsatz;                    {Zinsen berechnen}
    writeln('Jahreszinsen bei ',Prozentsatz:3:1,
            '% = DM ',Zinsen:10:2,',  monatlich: ',
            'DM ',(Zinsen/12):10:2);
  until Prozentsatz >= 9.5;
  readln;                                        {Auf [Return] warten}
end.