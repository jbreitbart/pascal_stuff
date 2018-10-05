{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Berechnet den Mittelwert (das arithmetische Mittel) der einge-   �
 � gebenen Zahlen mit Hilfe einer While-Schleife. Ende der Eingabe  �
 � und Berechnung des Mittelwertes durch die Eingabe Null! Eine     �
 � �u�ere Repeat-Schleife erm�glicht die Berechnung mehrerer Mittel-�
 � werte.                                                           �
 ������������������������������������������������������������������ͼ}
Program VieleMittelwerte;                         {Datei: Mittel2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
var
  Anzahl: integer;                     {Anzahl der eingegebenen Werte}
  Zahl,Summe,Mittel: real;
  ch: char;                                   {Beantwortung der Frage}

begin
  repeat
    ClrScr;
    write('Berechnung des arithmetischen Mittels');
    writeln(' (Ende --> 0 eingeben)');
    writeln;

    Anzahl:= 0; Zahl:= 0;                               {Anfangswerte}
    Summe:= 0; Mittel:= 0;

    write('1. Zahl eingeben: ');           {Eingabe des ersten Wertes}
    readln(Zahl);

    while Zahl <> 0.0 do
    begin
      Summe:= Summe + Zahl;                          {Summe berechnen}
      Inc(Anzahl);                               {Anzahl um 1 erh�hen}

      write((Anzahl+1),'. Zahl eingeben: ');   {N�chste Zahl eingeben}
      readln(Zahl);
    end; {while}

    {������������������������������������������Mittelwert berechnen��}
    if Anzahl > 0
     then Mittel:= Summe / Anzahl
     else Mittel:= Summe;

    {�������������������������������������������Mittelwert ausgeben��}
    ClrScr;
    writeln('Mittelwert der Zahlen: ',Mittel:10:2);
    writeln;
    write('Noch eine Berechnung (J/N)? ');

    repeat                                    {Beantwortung der Frage}
      ch:= Upcase(Readkey);
    until ch in ['J','N'];

  until ch = 'N';
end.