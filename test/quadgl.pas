{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Das Programm l�st quadratische Gleichungen. Die Koeffizienten    �
 � a2, a1 und a0 werden �ber Tastatur eingegeben. Es werden auch    �
 � konjugiert-komplexe L�sungen ber�cksichtigt.                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Program QuadratischeGleichung;                     {Datei: QuadGl.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  a2,a1,a0,                                            {Koeffizienten}
  x1,x2,                                      {L�sungen der Gleichung}
  Re,Im,                                {Reeller u. imagin�rer Anteil}
  p,q,                                       {p = a1/a2 und q = a0/a2}
  D: real;                                             {Diskriminante}

begin
  ClrScr;
  writeln('L�sung einer quadratischen Gleichung');
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Koeffizienten einlesen陳}
  write('Koeffizient a2 eingeben: '); readln(a2);
  write('Koeffizient a1 eingeben: '); readln(a1);
  write('Koeffizient a0 eingeben: '); readln(a0);
  writeln;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Anfangswerte陳}
  Re:= 0; Im:= 0; x1:= 0; x2:= 0; D:= 0;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Berechnung der L�sung陳}
  if a2 = 0
    then begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Keine L�sung陳}
           write('Keine L�sung der quadratischen ');
           writeln('Gleichung m�glich, weil a2 = 0!');
         end
    else begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Wenn a2 <> 0, dann...陳}
           p:= a1/a2;
           q:= a0/a2;
           D:= Sqr(p/2) - (q);               {Diskriminante berechnen}
           writeln('Diskriminante: D = ',D:10:2);
           writeln;

           if D < 0
             then begin {陳陳陳陳陳陳陳陳Konjugiert-komplexe L�sung陳}
                    D:= Abs(D);                  {Absolutbetrag von D}
                    Re:= -(p/2);                      {Reeller Anteil}
                    Im:= Sqrt(D);                  {Imagin�rer Anteil}

                    writeln('x1 = ',Re:10:2,' + ',Im:10:2,' i');
                    writeln('x2 = ',Re:10:2,' - ',Im:10:2,' i');
                  end
             else begin {陳陳陳陳陳陳陳陳陳陳陳陳陳�Reelle L�sungen陳}
                    x1:= -(p/2) + Sqrt(D);
                    x2:= -(p/2) - Sqrt(D);

                    writeln('x1 = ',x1:10:2);
                    writeln('x2 = ',x2:10:2);
                  end;
         end; {else}
  readln;                                        {Auf [Return] warten}
end.