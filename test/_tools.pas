{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 30.09.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Die Unit enth�lt mehrere n�tzliche Routinen, die in eigenen Pro- �
 � grammen verwendet werden k�nnen. Dazu mu� die Unit mit der Uses- �
 � Anweisung in das Programm aufgenommen werden.                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Unit _Tools;                                       {Datei: _Tools.pas}
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Interface (�ffentlicher Teil)                                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Interface
uses {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Einzubindende Bibliotheken陳}
  Crt,Dos;                                    {Units aus Turbo Pascal}

const {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Globale Konstanten陳}
  _WarnTon: boolean = true;                      {True  = Warnton ein}
                                                 {False = Warnton aus}

  _TonFrequenz: integer = 500;                       {Angabe in Hertz}
  _TonDauer: integer = 200;                  {Angabe in Millisekunden}

  _UOk: boolean = true;                         {Zahlen-Umwandlung Ok}

type {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Globale Datentypen陳}
  _Str = string;                           {Allgemeiner Arbeitsstring}

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Verzeichnis der globalen Routinen陳}

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


{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Implementation (Nicht-�ffentlicher Teil)                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Implementation

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _SignalTon                                                       �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt einen Signalton aus. Die Frequenz ist durch die Konstante   �
 � _TonFrequenz, die Dauer des Tons durch _TonDauer festgelegt. Ein �
 � Signalton ert�nt jedoch nur, wenn die globale Konstante _WarnTon �
 � gleich True gesetzt ist.                                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure _SignalTon;
begin
  if _WarnTon then
  begin
    Sound(_TonFrequenz);
    Delay(_TonDauer);
    NoSound;
  end;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _IntRange                                                        �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob die Integerzahl innerhalb des angegebenen Bereichs �
 � liegt: Min <= Zahl <= Max. Wenn die Bedingung erf�llt ist, lie-  �
 � fert die Funktion das Ergebnis True, sonst False.                �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _IntRange(Min,Max,Zahl: integer): boolean;
begin
  if (Zahl >= Min) and (Zahl <= Max)
    then _IntRange:= true
    else _IntRange:= false;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _RealRange                                                       �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob die Dezimalzahl innerhalb des angegebenen Bereichs �
 � liegt: Min <= Zahl <= Max. Wenn die Bedingung erf�llt ist, lie-  �
 � fert die Funktion das Ergebnis True, sonst False.                �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _RealRange(Min,Max,Zahl: real): boolean;
begin
  if (Zahl >= Min) and (Zahl <= Max)
    then _RealRange:= true
    else _RealRange:= false;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _Kleinbuchstabe                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob das �bergebene Zeichen ein Kleinbuchstabe ist      �
 � (a..z,�,�,�). Wenn die Bedingung zutrifft, liefert die Funktion  �
 � das Ergebnis True, sonst False.                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _Kleinbuchstabe(ch: char): boolean;
begin
  if ch in ['a'..'z','�','�','�']
   then _Kleinbuchstabe:= true
   else _Kleinbuchstabe:= false;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _Grossbuchstabe                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob das �bergebene Zeichen ein Grossbuchstabe ist      �
 � (A..Z,�,�,�). Wenn die Bedingung zutrifft, liefert die Funktion  �
 � das Ergebnis True, sonst False.                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _Grossbuchstabe(ch: char): boolean;
begin
  if ch in ['A'..'Z','�','�','�']
   then _Grossbuchstabe:= true
   else _Grossbuchstabe:= false;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _Buchstabe                                                       �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob das �bergebene Zeichen ein Buchstabe ist. Wenn die �
 � Bedingung zutrifft, liefert die Funktion das Ergebnis True,      �
 � sonst False.                                                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _Buchstabe(ch: char): boolean;
begin
  if _Kleinbuchstabe(ch) or _Grossbuchstabe(ch)
    then _Buchstabe:= true
    else _Buchstabe:= false;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _Ziffer                                                          �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob das �bergebene Zeichen eine Ziffer ist. Wenn die   �
 � Bedingung zutrifft, liefert die Funktion das Ergebnis True,      �
 � sonst False.                                                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _Ziffer(ch: char): boolean;
begin
  if ch in ['0'..'9'] then _Ziffer:= true
                      else _Ziffer:= false;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _AlleLeerzEntf                                                   �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Entfernt aus einem String s�mtliche Leerzeichen und liefert den  �
 � ver�nderten String als Ergebnis der Funktion zur�ck.             �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _StrToInteger                                                    �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Konvertiert einen String in einen Integerwert und liefert diesen �
 � als Ergebnis der Funktion zur�ck.                                �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _StrToInteger(St: _Str): integer;
var
  Erg   : real;                         {Umwandlung erst in Real-Zahl}
  i     : byte;                                         {Z�hlvariable}
  Ok    : boolean;                               {Ob Konvertierung Ok}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳KeineIntegerZahl陳}
procedure KeineIntegerZahl;
begin
  _StrToInteger:= 0;
  _UOk:= false;
end;
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

begin
  St:= _AlleLeerzEntf(St);                     {Leerzeichen entfernen}
  Ok:= true;                                 {Angenommen Integer-Zahl}
  _UOk:= true;                              {Angenommen Umwandlung Ok}

  {陳陳陳陳陳陳陳陳�Integerzahl hat keinen Dez.Punkt und kein Komma陳}
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
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _StrToReal                                                       �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Konvertiert einen String in einen numerischen Wert. Das Ergebnis �
 � ist vom Typ Real. Leerzeichen werden entfernt, ein evtl. ","     �
 � wird durch den "." ersetzt.                                      �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _StrToReal(St: _Str): real;
var
  RealZahl: real;                      {Umgewandelter String als Real}
  Fehler  : integer;                      {Innerhalb der Val-Prozedur}
  i       : byte;                                       {Z�hlvariable}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�KeineRealZahl陳}
procedure KeineRealZahl;
begin
  _StrToReal:= 0.0;
  _UOk:= false;
end;
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

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
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _NumToStr                                                        �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Konvertiert einen numerischen Ausdruck in einen String und lie-  �
 � fert diesen als Ergebnis der Funktion zur�ck.                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _NumToStr(Zahl:real;Laenge,Nach:byte): _Str;
var St: _Str;

begin
  St:= '';
  Str(Zahl:Laenge:Nach,St);
  _NumToStr:= St;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _FileExist                                                       �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob die angegebene Datei auf der Diskette/Festplatte   �
 � vorhanden ist.                                                   �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _FileExist(Dateiname: _Str): boolean;
var Dummy: SearchRec;                                  {F�r FindFirst}
begin
  FindFirst(Dateiname,0,Dummy);
  _FileExist:= DosError = 0;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _FileMake                                                        �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � �berpr�ft, ob eine Datei erzeugt (neu angelegt) werden kann, d.h.�
 � ob Rewrite fehlerfrei ausgef�hrt werden konnte. Die Datei darf   �
 � noch nicht existieren, da sie sonst gel�scht wird.               �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _FileMake(Dateiname: _Str): boolean;
var
  f: file;                                  {Beliebige Diskettendatei}
  Err: byte;                                              {Fehlercode}

begin
  Assign(f,Dateiname);
  {$I-}  rewrite(f);  {$I+}
  if IOResult = 0 then
  begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Datei�ffnung r�ckg�ngig陳}
    _FileMake:= true;
    {$I-}
    Close(f);                                 {Datei wieder schlie�en}
    Erase(f);                                   {Datei wieder l�schen}
    {$I+}
    Err:= IOResult;                                {Ergebnis abfangen}
  end
  else _FileMake:= false;
end;
{様様様様様様様様様様様様様様様様様様様様様様様様様様様�End of unit様}
end.