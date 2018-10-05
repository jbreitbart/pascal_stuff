{…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª
 ∫                Das gro·e Buch zu Turbo Pascal 7.0                ∫
 ∫                                                                  ∫
 ∫                 Autor: Reiner Schîlles, 19.10.92                 ∫
 ∫                                                                  ∫
 «ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂
 ∫ Unterprogramme: Unterschiede zwischen Wert- und Var-Parametern.  ∫
 »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº}
Program Parameter;                                {Datei: WertVar.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a,b: integer;                                    {Globale Variablen}

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥ Uebergabe                                                        ≥
 √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
 ≥ Dient der öbergabe von Wert- und Variablenparametern.            ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}
procedure Uebergabe(a: integer; var b: integer);
begin
  a:= a + 100;
  b:= b + 100;
  write('Innerhalb der Prozedur UEBERGABE            : ');
  writeln('a = ',a:3,'       ','b = ',b:3);
end; {Uebergabe}
{ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ}

begin {Hauptprogramm}
  ClrScr;
  a:= 1;
  b:= 2;
  writeln('a ---> Wertparameter');
  writeln('b ---> Variablenparameter');
  writeln('=========================');
  writeln;
  write('Vor dem Aufruf der Prozedur UEBERGABE       : ');
  writeln('a = ',a:3,'       ','b = ',b:3);
  Uebergabe(a,b);
  write('Nach dem Verlassen der Prozedur UEBERGABE   : ');
  writeln('a = ',a:3,'       ','b = ',b:3);
  GotoXY(1,25);
  write('Bitte [Return] drÅcken...');
  readln;                                        {Auf [Return] warten}
end.