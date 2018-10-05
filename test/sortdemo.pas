{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Eindimensionale Felder: Demoprogramm zum Bubble-Sort.            �
 ������������������������������������������������������������������ͼ}
Program SortDemo;                                {Datei: SortDemo.pas}
uses Crt;                                {Bibliothek aus Turbo Pascal}
const
  n = 5;                                         {Anzahl der Elemente}
  OutZeile = 20;                              {Postition Ausgabezeile}
  Zeit = 3000;                                {Verz�gerungszeit in ms}

type
  ZahlRec = record
    Wert, Sp: byte;
  end;

  ZahlAry = array[1..n] of ZahlRec;

var
  Zahl: ZahlAry;

{������������������������������������������������������������������Ŀ
 � Ueberschrift                                                     �
 ������������������������������������������������������������������Ĵ
 � Schreibt die �berschrift.                                        �
 ��������������������������������������������������������������������}
procedure Ueberschrift;
begin
  GotoXY(28,1);
  write('BUBBLE-Sort (aufsteigend)');
end; {Ueberschrift}
{������������������������������������������������������������������Ŀ
 � Blinken                                                          �
 ������������������������������������������������������������������Ĵ
 � Schaltet  das Blinken ein oder aus.                              �
 ��������������������������������������������������������������������}
procedure Blinken(Ein: boolean);
begin
  if Ein
    then TextColor(White+Blink)
    else TextColor(White); 
end; {Blinken}
{������������������������������������������������������������������Ŀ
 � Warten                                                           �
 ������������������������������������������������������������������Ĵ
 � Wartet in der 25. Zeile auf einen Tastendruck zum Beenden des    �
 � Programms.                                                       �
 ��������������������������������������������������������������������}
procedure Warten;
var ch: char;
begin
  GotoXY(1,25);
  write('Bitte eine Taste dr�cken...');
  write(^G);                                                 {Piepton}
  ch:= Readkey;
end; {Warten}
{������������������������������������������������������������������Ŀ
 � Meldung                                                          �
 ������������������������������������������������������������������Ĵ
 � Schreibt eine von sechs Meldungen, die den Sortiervorgang        �
 � dokumentieren, auf den Bildschirm.                               �
 ��������������������������������������������������������������������}
procedure Meldung(Nr: byte);
const
  Mld: array[1..6] of String[45]
    = ('Dieses Feld wird gleich sortiert!',
       'Folgende Elemente werden verglichen...',
       'Die Elemente m�ssen vertauscht werden!',
       'Die Elemente m�ssen nicht vertauscht werden!',
       'Elemente wurden vertauscht!',
       'Sortiervorgang beendet!!');

begin
  GotoXY(1,OutZeile-2);
  ClrEol;
  write(Mld[Nr]);
  Delay(Zeit);
end; {Meldung}
{������������������������������������������������������������������Ŀ
 � ElementeSchreiben                                                �
 ������������������������������������������������������������������Ĵ
 � Schreibt die beiden gerade 'in Arbeit' befindlichen Elemente     �
 � auf den Bildschirm.                                              �
 ��������������������������������������������������������������������}
procedure ElementeSchreiben(e1,e2: ZahlRec);
begin
  Blinken(True);
  GotoXY(e1.Sp,OutZeile);  write(e1.Wert:3);
  GotoXY(e2.Sp,OutZeile);  write(e2.Wert:3);
  Blinken(False);
end; {ElementeSchreiben}
{������������������������������������������������������������������Ŀ
 � FeldSchreiben                                                    �
 ������������������������������������������������������������������Ĵ
 � Schreibt den Inhalt des zu sortierenden Feldes auf den           �
 � Bildschirm.                                                      �
 ��������������������������������������������������������������������}
procedure FeldSchreiben;
var i: byte;
begin
  GotoXY(1,OutZeile);
  ClrEol;
  for i:= 1 to n do
  begin
    GotoXY(Zahl[i].Sp,OutZeile);
    write(Zahl[i].Wert:3);
  end;
end; {FeldSchreiben}

{������������������������������������������������������������������Ŀ
 � FeldInit                                                         �
 ������������������������������������������������������������������Ĵ
 � Initialisiert das zu sortierende Feld mit Werten von n..1.       �
 ��������������������������������������������������������������������}
procedure FeldInit;
var
  Sp: integer;                                                {Spalte}
  i: byte;                                              {Z�hlvariable}

begin
  Sp:= -4;                                               {Anfangswert}
  for i:= 0 to (n-1) do
  begin
    Inc(Sp,5);
    Zahl[i+1].Wert:= n-i;
    Zahl[i+1].Sp:= Sp;
  end; {for}
end; {FeldInit}
{������������������������������������������������������������������Ŀ
 � BubbleSort                                                       �
 ������������������������������������������������������������������Ĵ
 � Bubble-Sort. Sortiert das Feld aufsteigend.                      �
 ��������������������������������������������������������������������}
procedure BubbleSort;
var
  Help: integer;                                       {Hilfsvariable}
  i,j: integer;                                        {Z�hlvariablen}

begin
  Meldung(1);

  for i:= 1 to n-1 do
  begin

    for j:= i+1 to n do
    begin
      ElementeSchreiben(Zahl[i],Zahl[j]);
      Meldung(2);
      if Zahl[i].Wert > Zahl[j].Wert
      then begin
             Meldung(3);
             Help:= Zahl[i].Wert;
             Zahl[i].Wert:= Zahl[j].Wert;
             Zahl[j].Wert:= Help;
             FeldSchreiben;
             Meldung(5);
           end {if}
      else Meldung(4);
    end; {for j}

  end; {for i}
  FeldSchreiben;
  Meldung(6);
end; {BubbleSort}

{��������������������������������������������������������������������}

begin {Hauptprogramm}
  TextColor(White);
  TextBackground(Black);
  ClrScr;
  Ueberschrift;

  FeldInit;
  FeldSchreiben;
  BubbleSort;

  Warten;
  ClrScr;
end.