{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 07.08.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Ermittelt mit Hilfe von GETDATE und unter Verwendung der Case-   �
 � Anweisung das momentan gesetzte Kalenderdatum.                   �
 ������������������������������������������������������������������ͼ}
Program HeutigesDatum;                              {Datei: DayOf.pas}
uses Crt,Dos;                            {Bibliothek aus Turbo Pascal}
var
  Year,Month,Day,DayOfWeek: Word;               {F�r GetDate-Prozedur}
  Wochentag: string;

begin
  ClrScr;

  GetDate(Year,Month,Day,DayOfWeek);             {Aufruf der Prozedur}

  case DayOfWeek of
    0: Wochentag:= 'Sonntag';
    1: Wochentag:= 'Montag';
    2: Wochentag:= 'Dienstag';
    3: Wochentag:= 'Mittwoch';
    4: Wochentag:= 'Donnerstag';
    5: Wochentag:= 'Freitag';
    6: Wochentag:= 'Samstag';
  end; {case}

  writeln('Heute ist ',Wochentag,', der ',Day,'.',Month,'.',Year);

  readln;                                        {Auf [Return] warten}
end.