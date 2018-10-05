{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Berechnet und gibt eine Tabelle der Sinuswerte von 0 bis 360 Grad�
 � in die Datei Sinus.dat aus.                                      �
 ������������������������������������������������������������������ͼ}
Program SinusTabelleDatei;                         {Datei: Sinus2.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
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
 � Gibt die Tabelle in die Datei Sinus.dat aus.                     �
 ��������������������������������������������������������������������}
procedure Ausgabe;
const
  Ueberschrift = 'Tabelle der Sinuswerte';
  Unterstrich  = '======================';
  DatName = 'Sinus.dat';

var
  i,j: integer;
  f: Text;                                             {Dateivariable}

begin
  Assign(f,DatName);
  {$I-}
  Rewrite(f);                          {Neue Datei anlegen und �ffnen}
  {$I+}

  if IOResult = 0 then
  begin
    writeln(f);                               {Leerzeile in der Datei}
    writeln;                                {Leerzeile f�r Bildschirm}

    {������������������������������������������Tabellen-�berschrift��}
    writeln(f,' ':40,Ueberschrift);
    writeln(f,' ':40,Unterstrich);
    writeln(f);
    write(f,'SIN':4,' !');

    for i:= 0 to 10 do write(f,i:9,' ');
    writeln(f);

    for i:= 1 to 115 do write(f,'-');
    writeln(f); writeln(f);

    {���������������������������������������������Tabelle erstellen��}
    for i:= 0 to 35 do
    begin
      write(f,(i*10):4,' ','!');

      for j:= 0 to 10 do
      begin
        write(f,Tabelle[i,j]:9:4,' ');
      end; {for j}

      writeln(f);
    end; {for i}
    {����������������������������������������������������������������}

    writeln(f);
    close(f);
  end {if}
  else write('Fehler beim �ffnen der Datei!');
end; {Ausgabe}
{��������������������������������������������������������������������}

begin {Hauptprogramm}
  ClrScr;
  writeln('Sinuswerte berechnen und in SINUS.DAT speichern');
  writeln;

  SinusBerechnen;
  Ausgabe;

  GotoXY(1,25);
  write('Bitte [Return] dr�cken...');
  readln;                                        {Auf [Return] warten}
end.