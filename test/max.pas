{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 16.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Datentyp INTEGER: Gibt kleinste und gr”แte Integer- und LongInt- บ
 บ Zahl auf dem Bildschirm aus.                                     บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program MinMaxInteger;                                {Datei: Max.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  MinInt = -MaxInt - 1;
  MinLongInt = -MaxLongInt - 1;

begin
  ClrScr;
  writeln('Kleinste und gr”แte Integer- und LongInt-Zahl');
  writeln;

  writeln('Gr”แte Integer-Zahl  : ',MaxInt);
  writeln('Kleinste Integer-Zahl: ',MinInt);
  writeln;
  writeln('Gr”แte LongInt-Zahl  : ',MaxLongInt);
  writeln('Kleinste LongInt-Zahl: ',MinLongInt);

  readln;                                        {Auf [Return] warten}
end.