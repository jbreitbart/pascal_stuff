{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Das Programm l�st quadratische Gleichungen. Die Koeffizienten    �
 � a2, a1 und a0 werden �ber Tastatur eingegeben. Es werden auch    �
 � konjugiert-komplexe L�sungen ber�cksichtigt.                     �
 ������������������������������������������������������������������ͼ}
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

  {������������������������������������������Koeffizienten einlesen��}
  write('Koeffizient a2 eingeben: '); readln(a2);
  write('Koeffizient a1 eingeben: '); readln(a1);
  write('Koeffizient a0 eingeben: '); readln(a0);
  writeln;

  {����������������������������������������������������Anfangswerte��}
  Re:= 0; Im:= 0; x1:= 0; x2:= 0; D:= 0;

  {�������������������������������������������Berechnung der L�sung��}
  if a2 = 0
    then begin {���������������������������������������Keine L�sung��}
           write('Keine L�sung der quadratischen ');
           writeln('Gleichung m�glich, weil a2 = 0!');
         end
    else begin {������������������������������Wenn a2 <> 0, dann...��}
           p:= a1/a2;
           q:= a0/a2;
           D:= Sqr(p/2) - (q);               {Diskriminante berechnen}
           writeln('Diskriminante: D = ',D:10:2);
           writeln;

           if D < 0
             then begin {����������������Konjugiert-komplexe L�sung��}
                    D:= Abs(D);                  {Absolutbetrag von D}
                    Re:= -(p/2);                      {Reeller Anteil}
                    Im:= Sqrt(D);                  {Imagin�rer Anteil}

                    writeln('x1 = ',Re:10:2,' + ',Im:10:2,' i');
                    writeln('x2 = ',Re:10:2,' - ',Im:10:2,' i');
                  end
             else begin {���������������������������Reelle L�sungen��}
                    x1:= -(p/2) + Sqrt(D);
                    x2:= -(p/2) - Sqrt(D);

                    writeln('x1 = ',x1:10:2);
                    writeln('x2 = ',x2:10:2);
                  end;
         end; {else}
  readln;                                        {Auf [Return] warten}
end.