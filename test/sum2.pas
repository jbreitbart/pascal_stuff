{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Prozeduren: Berechnet die Summe zweier Zahlen.                   �
 ������������������������������������������������������������������ͼ}
Program SummeBerechnen2;                             {Datei: Sum2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b,Summe: Integer;

procedure Ueberschrift;
begin
  ClrScr;
  writeln('Summe zweier Zahlen berechnen');
  writeln;
end;

procedure Eingabe;
begin
  write('Gib die erste Zahl ein:  ');
  readln(a);
  write('Gib die zweite Zahl ein: ');
  readln(b);
  writeln;
end;

procedure Berechnung;
begin
  Summe:= a + b;
end;

procedure Ausgabe;
begin
  writeln('a + b = ',Summe);
end;

begin {Hauptprogramm}
  Ueberschrift;
  Eingabe;
  Berechnung;
  Ausgabe;     

  readln;                                        {Auf [Return] warten}
end.