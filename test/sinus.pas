{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Berechnet und druckt eine Tabelle der Sinuswerte im Bereich von  �
 � 0 bis 360 Grad. Der Drucker mu� eingeschaltet sein!              �
 ������������������������������������������������������������������ͼ}
Program SinusTabelle;                               {Datei: Sinus.pas}
uses Crt,Printer;                      {Bibliotheken aus Turbo Pascal}
var
  Tabelle: array[0..35,0..10] of real;

{������������������������������������������������������������������Ŀ
 � SinusBerechnen                                                   �
 ������������������������������������������������������������������Ĵ
 � Berechnet den Sinuswert von 0 bis 360 Grad und legt ihn in einem �
 � 2-dimensionalen Feld ab. Die BEGIN der FOR-Schleife wurden nur   �
 � wegen der besseren Lesbarkeit verwendet, sie sind nicht notwendig�
 ��������������������������������������������������������������������}
procedure SinusBerechnen;
const
  UmFak = 0.017453;             {Umrechnungsfaktor Altgrad  Bogenma�}

var
  i,j: integer;                                        {Z�hlvariablen}

begin
  for i:= 0 to 35 do
  begin

    for j:= 0 to 10 do
    begin
      Tabelle[i,j]:= Sin(((i*10)+j) * UmFak);
    end; {for j}

  end; {for i}
end; {SinusBerechnen}
{������������������������������������������������������������������Ŀ
 � Ausgabe                                                          �
 ������������������������������������������������������������������Ĵ
 � Gibt die Tabelle auf dem Drucker aus.                            �
 ��������������������������������������������������������������������}
procedure Ausgabe;
const
  Ueberschrift = 'Tabelle der Sinuswerte';
  Unterstrich  = '======================';

var
  i,j: integer;

begin
  write(Lst,#15);                     {Kleinschrift f�r EPSON-Drucker}
  writeln(Lst);                            {Leerzeile f�r den Drucker}
  writeln;                                  {Leerzeile f�r Bildschirm}
  writeln('Es wird gedruckt...');

  {��������������������������������������������Tabellen-�berschrift��}
  writeln(Lst,' ':40,Ueberschrift);
  writeln(Lst,' ':40,Unterstrich);
  writeln(Lst);
  write(Lst,'SIN':4,' !');

  for i:= 0 to 10 do write(Lst,i:9,' ');
  writeln(Lst);

  for i:= 1 to 115 do write(Lst,'-');
  writeln(Lst); writeln(Lst);

  {�����������������������������������������������Tabelle erstellen��}
  for i:= 0 to 35 do
  begin
    write(Lst,(i*10):4,' ','!');

    for j:= 0 to 10 do
    begin
      write(Lst,Tabelle[i,j]:9:4,' ');
    end; {for j}

    writeln(lst);
  end; {for i}
  {������������������������������������������������������������������}

  write(Lst,#18);                               {Kleinschrift beenden}
  writeln(Lst);
end; {Ausgabe}
{������������������������������������������������������������������Ŀ
 � DruckerOk                                                        �
 ������������������������������������������������������������������Ĵ
 � Pr�ft, ob der Drucker betriebsbereit ist.                        �
 ��������������������������������������������������������������������}
function DruckerOk: boolean;
const
  Frage = 'Drucker betriebsbereit (J/N)? ';

var
  ch: char;

begin
  GotoXY(10,5);
  write(Frage);

  repeat
    GotoXY(10+Length(Frage),5);
    ch:= Upcase(Readkey);
  until (ch = 'J') or (ch = 'N');

  if ch = 'J'
    then DruckerOk:= true
    else DruckerOk:= false;

end; {DruckerOk}
{��������������������������������������������������������������������}

begin {Hauptprogramm}
  ClrScr;
  writeln('Sinuswerte berechnen und auf dem Drucker ausgeben');
  writeln;
  SinusBerechnen;

  if DruckerOk
    then Ausgabe
    else begin
           writeln(' N E I N!');
           writeln;
           writeln('Daher keine Ausgabe m�glich.');
         end; {else}

  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.