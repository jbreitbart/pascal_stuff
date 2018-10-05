{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 19.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Demonstriert die Overlay-Technik.                                บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program OverlayTechnik;                            {Datei: OvrPrg.pas}
uses
  Overlay,Crt,                         {Bibliotheken aus Turbo Pascal}
  OvrUnit1,OvrUnit2;                                   {Overlay-Units}

  {$O OvrUnit1}                               {Unit als Overlay laden}
  {$O OvrUnit2}                               {Unit als Overlay laden}

var
  i: integer;                                           {Zhlvariable}

begin {Hauptprogramm}
  OvrInit('OvrPrg.Ovr');                             {Initialisierung}

  ClrScr;
  writeln('Overlay-Technik');
  writeln;

  for i:= 1 to 10 do
  begin
    ClrScr;
    Meldung1;                                    {Aufruf aus OvrUnit1}
    Meldung2;                                    {Aufruf aus OvrUnit2}
  end; {for}

  GotoXY(1,25);
  write('Bitte [Return] drcken...');
  readln;                                        {Auf [Return] warten}
end.