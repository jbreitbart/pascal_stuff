{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 18.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Programm zu Konstanten: Berechnet den Bruttobetrag einer Ware.   �
 ������������������������������������������������������������������ͼ}
Program Mehrwertsteuer;                              {Datei: MWSt.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  MWSt_Voll = 0.14;                            {Voller MWSt-Satz: 14%}
  MWSt_Halb = MWSt_Voll / 2;                    {Wird berechnet zu 7%}

var
  Netto,
  BruttoVoll, BruttoHalb,
  MWSt_DMVoll, MWSt_DMHalb: real;

begin
  ClrScr;
  writeln('Berechnung des Bruttopreises einer Ware');
  writeln;

  {���������������������������������������������������������Eingabe��}
  write('Bitte Nettopreis der Ware eingeben: ');
  readln(Netto);
  writeln;

  {������������������������������������������������������Berechnung��}
  MWSt_DMVoll:= Netto * MWSt_Voll;
  MWSt_DMHalb:= Netto * MWSt_Halb;
  BruttoVoll:= Netto + MWSt_DMVoll;
  BruttoHalb:= Netto + MWSt_DMHalb;

  {���������������������������������������������������������Ausgabe��}
  writeln('Nettobetrag der Ware: ',Netto:10:2);              writeln;
  writeln('Volle MWSt:           ',MWSt_DMVoll:10:2);        writeln;
  writeln('Erm��igte MWSt:       ',MWSt_DMHalb:10:2);        writeln;
  writeln('Bruttobetrag mit voller MWSt: ',BruttoVoll:10:2); writeln;
  writeln('Bruttobetrag mit halber MWSt: ',BruttoHalb:10:2);

  readln;                                        {Auf [Return] warten}
end.