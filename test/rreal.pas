{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 19.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Demonstriert den Datentyp Real und verwendet dabei die Routinen  บ
 บ Abs, Cos, Exp, Frac, Int, Ln, Sin, Sqr und Sqrt.                 บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program DatentypReal;                               {Datei: RReal.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}

begin
  ClrScr;
  writeln('Demoprogramm zum Datentyp REAL');
  writeln;

  writeln('x = -3.1,  Abs(-3.1)   = ',Abs(-3.1):8:5); writeln;
  writeln('x = Pi,    Cos(Pi)     = ',Cos(Pi):8:5); writeln;
  writeln('x = 1,     Exp(1)      = ',Exp(1):8:5); writeln;
  writeln('x = 1.414, Frac(1.414) = ',Frac(1.414):8:5); writeln;
  writeln('x = 2.718, Int(2.718)  = ',Int(2.718):8:5); writeln;
  writeln('x = 2.718, Ln(2.718)   = ',Ln(2.718):8:5); writeln;
  writeln('x = Pi,    Sin(Pi)     = ',Sin(Pi):8:5); writeln;
  writeln('x = 4,     Sqr(4)      = ',Sqr(4):8); writeln;
  writeln('x = 16,    Sqrt(16)    = ',Sqrt(16):8:5); writeln;

  readln;                                        {Auf [Return] warten}
end.