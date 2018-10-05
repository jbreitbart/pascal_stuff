{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 30.09.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Die Unit enth�lt mehrere n�tzliche Routinen, die in eigenen Pro- �
 � grammen verwendet werden k�nnen. Dazu mu� die Unit mit der Uses- �
 � Anweisung in das Programm aufgenommen werden.                    �
 ������������������������������������������������������������������ͼ}
Unit _Tools;                                       {Datei: _Tools.pas}
{������������������������������������������������������������������ͻ
 � Interface (�ffentlicher Teil)                                    �
 ������������������������������������������������������������������ͼ}
Interface
uses {�����������������������������������Einzubindende Bibliotheken��}
  Crt,Dos;                                    {Units aus Turbo Pascal}

const {������������������������������������������Globale Konstanten��}
  _WarnTon: boolean = true;                      {True  = Warnton ein}
                                                 {False = Warnton aus}

  _TonFrequenz: integer = 500;                       {Angabe in Hertz}
  _TonDauer: integer = 200;                  {Angabe in Millisekunden}

  _UOk: boolean = true;                         {Zahlen-Umwandlung Ok}

type {�������������������������������������������Globale Datentypen��}
  _Str = string;                           {Allgemeiner Arbeitsstring}

  {�������������������������������Verzeichnis der globalen Routinen��}

  procedure _SignalTon;
  function _IntRange(Min,Max,Zahl: integer): boolean;
  function _RealRange(Min,Max,Zahl: real): boolean;
  function _Kleinbuchstabe(ch: char): boolean;
  function _Grossbuchstabe(ch: char): boolean;
  function _Buchstabe(ch: char): boolean;
  function _Ziffer(ch: char): boolean;
  function _AlleLeerzEntf(St: _Str): _Str;
  function _StrToInteger(St: _Str): integer;
  function _StrToReal(St: _Str): real;
  function _NumToStr(Zahl:real;Laenge,Nach:byte): _Str;
  function _FileExist(Dateiname: _Str): boolean;
  function _FileMake(Dateiname: _Str): boolean;


{������������������������������������������������������������������ͻ
 � Implementation (Nicht-�ffentlicher Teil)                         �
 ������������������������������������������������������������������ͼ}
Implementation

{������������������������������������������������������������������ͻ
 � _SignalTon                                                       �
 ������������������������������������������������������������������Ķ
 � Gibt einen Signalton aus. Die Frequenz ist durch die Konstante   �
 � _TonFrequenz, die Dauer des Tons durch _TonDauer festgelegt. Ein �
 � Signalton ert�nt jedoch nur, wenn die globale Konstante _WarnTon �
 � gleich True gesetzt ist.                                         �
 ������������������������������������������������������������������ͼ}
procedure _SignalTon;
begin
  if _WarnTon then
  begin
    Sound(_TonFrequenz);
    Delay(_TonDauer);
    NoSound;
  end;
end;
{������������������������������������������������������������������ͻ
 � _IntRange                                                        �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob die Integerzahl innerhalb des angegebenen Bereichs �
 � liegt: Min <= Zahl <= Max. Wenn die Bedingung erf�llt ist, lie-  �
 � fert die Funktion das Ergebnis True, sonst False.                �
 ������������������������������������������������������������������ͼ}
function _IntRange(Min,Max,Zahl: integer): boolean;
begin
  if (Zahl >= Min) and (Zahl <= Max)
    then _IntRange:= true
    else _IntRange:= false;
end;
{������������������������������������������������������������������ͻ
 � _RealRange                                                       �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob die Dezimalzahl innerhalb des angegebenen Bereichs �
 � liegt: Min <= Zahl <= Max. Wenn die Bedingung erf�llt ist, lie-  �
 � fert die Funktion das Ergebnis True, sonst False.                �
 ������������������������������������������������������������������ͼ}
function _RealRange(Min,Max,Zahl: real): boolean;
begin
  if (Zahl >= Min) and (Zahl <= Max)
    then _RealRange:= true
    else _RealRange:= false;
end;
{������������������������������������������������������������������ͻ
 � _Kleinbuchstabe                                                  �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob das �bergebene Zeichen ein Kleinbuchstabe ist      �
 � (a..z,�,�,�). Wenn die Bedingung zutrifft, liefert die Funktion  �
 � das Ergebnis True, sonst False.                                  �
 ������������������������������������������������������������������ͼ}
function _Kleinbuchstabe(ch: char): boolean;
begin
  if ch in ['a'..'z','�','�','�']
   then _Kleinbuchstabe:= true
   else _Kleinbuchstabe:= false;
end;
{������������������������������������������������������������������ͻ
 � _Grossbuchstabe                                                  �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob das �bergebene Zeichen ein Grossbuchstabe ist      �
 � (A..Z,�,�,�). Wenn die Bedingung zutrifft, liefert die Funktion  �
 � das Ergebnis True, sonst False.                                  �
 ������������������������������������������������������������������ͼ}
function _Grossbuchstabe(ch: char): boolean;
begin
  if ch in ['A'..'Z','�','�','�']
   then _Grossbuchstabe:= true
   else _Grossbuchstabe:= false;
end;
{������������������������������������������������������������������ͻ
 � _Buchstabe                                                       �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob das �bergebene Zeichen ein Buchstabe ist. Wenn die �
 � Bedingung zutrifft, liefert die Funktion das Ergebnis True,      �
 � sonst False.                                                     �
 ������������������������������������������������������������������ͼ}
function _Buchstabe(ch: char): boolean;
begin
  if _Kleinbuchstabe(ch) or _Grossbuchstabe(ch)
    then _Buchstabe:= true
    else _Buchstabe:= false;
end;
{������������������������������������������������������������������ͻ
 � _Ziffer                                                          �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob das �bergebene Zeichen eine Ziffer ist. Wenn die   �
 � Bedingung zutrifft, liefert die Funktion das Ergebnis True,      �
 � sonst False.                                                     �
 ������������������������������������������������������������������ͼ}
function _Ziffer(ch: char): boolean;
begin
  if ch in ['0'..'9'] then _Ziffer:= true
                      else _Ziffer:= false;
end;
{������������������������������������������������������������������ͻ
 � _AlleLeerzEntf                                                   �
 ������������������������������������������������������������������Ķ
 � Entfernt aus einem String s�mtliche Leerzeichen und liefert den  �
 � ver�nderten String als Ergebnis der Funktion zur�ck.             �
 ������������������������������������������������������������������ͼ}
function _AlleLeerzEntf(St: _Str): _Str;
var
  HelpStr: _Str;
  i      : byte;                                        {Z�hlvariable}

begin
  if Length(St) = 0
  then HelpStr:= ''                                       {Leerstring}
  else begin
         HelpStr:= '';                           {Leerstring vorgeben}
         for i:= 1 to Length(St) do
         begin
           if (Copy(St,i,1)) <> ' '
             then HelpStr:= HelpStr + Copy(St,i,1);
         end; {for}
       end; {if-else}
  _AlleLeerzEntf:= HelpStr;
end;
{������������������������������������������������������������������ͻ
 � _StrToInteger                                                    �
 ������������������������������������������������������������������Ķ
 � Konvertiert einen String in einen Integerwert und liefert diesen �
 � als Ergebnis der Funktion zur�ck.                                �
 ������������������������������������������������������������������ͼ}
function _StrToInteger(St: _Str): integer;
var
  Erg   : real;                         {Umwandlung erst in Real-Zahl}
  i     : byte;                                         {Z�hlvariable}
  Ok    : boolean;                               {Ob Konvertierung Ok}

{��������������������������������������������������KeineIntegerZahl��}
procedure KeineIntegerZahl;
begin
  _StrToInteger:= 0;
  _UOk:= false;
end;
{��������������������������������������������������������������������}

begin
  St:= _AlleLeerzEntf(St);                     {Leerzeichen entfernen}
  Ok:= true;                                 {Angenommen Integer-Zahl}
  _UOk:= true;                              {Angenommen Umwandlung Ok}

  {�����������������Integerzahl hat keinen Dez.Punkt und kein Komma��}
  for i:= 1 to Length(St) do
  begin
    if (St[i] = '.') or (St[i] = ',')
      then Ok:= false;                            {Keine Integerzahl!}
  end;
  if Ok
  then begin
         Erg:= _StrToReal(St);
         if _RealRange(-32768.0,32767.0,Erg)
          then _StrToInteger:= Trunc(Erg)
          else KeineIntegerZahl;
       end {if-then}
  else KeineIntegerZahl;
end;
{������������������������������������������������������������������ͻ
 � _StrToReal                                                       �
 ������������������������������������������������������������������Ķ
 � Konvertiert einen String in einen numerischen Wert. Das Ergebnis �
 � ist vom Typ Real. Leerzeichen werden entfernt, ein evtl. ","     �
 � wird durch den "." ersetzt.                                      �
 ������������������������������������������������������������������ͼ}
function _StrToReal(St: _Str): real;
var
  RealZahl: real;                      {Umgewandelter String als Real}
  Fehler  : integer;                      {Innerhalb der Val-Prozedur}
  i       : byte;                                       {Z�hlvariable}

{�����������������������������������������������������KeineRealZahl��}
procedure KeineRealZahl;
begin
  _StrToReal:= 0.0;
  _UOk:= false;
end;
{��������������������������������������������������������������������}

begin
  _UOk:= true;                              {Angenommen Umwandlung Ok}
  St:= _AlleLeerzEntf(St);               {Evtl. Leerzeichen entfernen}
  if Length(St) > 0
  then begin {(1)}
         for i:= 1 to Length(St) do
         begin
           if St[i] = ',' then St[i]:= '.';
         end;
         Val(St,RealZahl,Fehler);
         if Fehler = 0
          then _StrToReal:= RealZahl               {Konvertierung Ok!}
          else KeineRealZahl;                {Konvertierung nicht Ok!}
       end {if-then (1)}
  else KeineRealZahl;                                {Wenn Nullstring}
end;
{������������������������������������������������������������������ͻ
 � _NumToStr                                                        �
 ������������������������������������������������������������������Ķ
 � Konvertiert einen numerischen Ausdruck in einen String und lie-  �
 � fert diesen als Ergebnis der Funktion zur�ck.                    �
 ������������������������������������������������������������������ͼ}
function _NumToStr(Zahl:real;Laenge,Nach:byte): _Str;
var St: _Str;

begin
  St:= '';
  Str(Zahl:Laenge:Nach,St);
  _NumToStr:= St;
end;
{������������������������������������������������������������������ͻ
 � _FileExist                                                       �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob die angegebene Datei auf der Diskette/Festplatte   �
 � vorhanden ist.                                                   �
 ������������������������������������������������������������������ͼ}
function _FileExist(Dateiname: _Str): boolean;
var Dummy: SearchRec;                                  {F�r FindFirst}
begin
  FindFirst(Dateiname,0,Dummy);
  _FileExist:= DosError = 0;
end;
{������������������������������������������������������������������ͻ
 � _FileMake                                                        �
 ������������������������������������������������������������������Ķ
 � �berpr�ft, ob eine Datei erzeugt (neu angelegt) werden kann, d.h.�
 � ob Rewrite fehlerfrei ausgef�hrt werden konnte. Die Datei darf   �
 � noch nicht existieren, da sie sonst gel�scht wird.               �
 ������������������������������������������������������������������ͼ}
function _FileMake(Dateiname: _Str): boolean;
var
  f: file;                                  {Beliebige Diskettendatei}
  Err: byte;                                              {Fehlercode}

begin
  Assign(f,Dateiname);
  {$I-}  rewrite(f);  {$I+}
  if IOResult = 0 then
  begin {�����������������������������������Datei�ffnung r�ckg�ngig��}
    _FileMake:= true;
    {$I-}
    Close(f);                                 {Datei wieder schlie�en}
    Erase(f);                                   {Datei wieder l�schen}
    {$I+}
    Err:= IOResult;                                {Ergebnis abfangen}
  end
  else _FileMake:= false;
end;
{�������������������������������������������������������End of unit��}
end.