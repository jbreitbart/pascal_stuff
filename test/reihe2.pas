{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Das Programm berechnet mit Hilfe der Summenformel die Summe einerบ
 บ arithmetischen Reihe. Das Anfangsglied, die Differenz und die    บ
 บ Anzahl der Glieder mssen eingegeben werden. Die Summe wird be-  บ
 บ rechnet und ausgegeben.                                          บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program ArithReihe2;                               {Datei: Reihe2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

var
  n: integer;                                       {Anz. der Glieder}
  a1,d,                                       {Anfangsglied,Differenz}
  Summe: real;

begin
  ClrScr;
  Summe:= 0;                                             {Anfangswert}
  writeln('Summe einer arithmetischen Reihe');
  writeln('================================');
  writeln;
  write('Anfangsglied:       '); readln(a1);
  write('Differenz:          '); readln(d);
  write('Anzahl der Glieder: '); readln(n);
  writeln;

  Summe:= n * (a1 + ((n-1)/2) * d);                       {Berechnung}

  writeln('Summe = ',Summe:8:2);
  readln;                                        {Auf [Return] warten}
end.