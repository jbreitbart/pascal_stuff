{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autor: Reiner Sch”lles, 30.09.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Die Unit enthlt mehrere ntzliche Routinen, die in eigenen Pro- บ
 บ grammen verwendet werden k”nnen. Dazu muแ die Unit mit der Uses- บ
 บ Anweisung in das Programm aufgenommen werden.                    บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Unit _Tools;                                       {Datei: _Tools.pas}
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Interface (ffentlicher Teil)                                    บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Interface
uses {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤEinzubindende Bibliothekenฤฤ}
  Crt,Dos;                                    {Units aus Turbo Pascal}

const {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤGlobale Konstantenฤฤ}
  _WarnTon: boolean = true;                      {True  = Warnton ein}
                                                 {False = Warnton aus}

  _TonFrequenz: integer = 500;                       {Angabe in Hertz}
  _TonDauer: integer = 200;                  {Angabe in Millisekunden}

  _UOk: boolean = true;                         {Zahlen-Umwandlung Ok}

type {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤGlobale Datentypenฤฤ}
  _Str = string;                           {Allgemeiner Arbeitsstring}

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤVerzeichnis der globalen Routinenฤฤ}

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


{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Implementation (Nicht-”ffentlicher Teil)                         บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Implementation

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _SignalTon                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt einen Signalton aus. Die Frequenz ist durch die Konstante   บ
 บ _TonFrequenz, die Dauer des Tons durch _TonDauer festgelegt. Ein บ
 บ Signalton ert”nt jedoch nur, wenn die globale Konstante _WarnTon บ
 บ gleich True gesetzt ist.                                         บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure _SignalTon;
begin
  if _WarnTon then
  begin
    Sound(_TonFrequenz);
    Delay(_TonDauer);
    NoSound;
  end;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _IntRange                                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob die Integerzahl innerhalb des angegebenen Bereichs บ
 บ liegt: Min <= Zahl <= Max. Wenn die Bedingung erfllt ist, lie-  บ
 บ fert die Funktion das Ergebnis True, sonst False.                บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _IntRange(Min,Max,Zahl: integer): boolean;
begin
  if (Zahl >= Min) and (Zahl <= Max)
    then _IntRange:= true
    else _IntRange:= false;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _RealRange                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob die Dezimalzahl innerhalb des angegebenen Bereichs บ
 บ liegt: Min <= Zahl <= Max. Wenn die Bedingung erfllt ist, lie-  บ
 บ fert die Funktion das Ergebnis True, sonst False.                บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _RealRange(Min,Max,Zahl: real): boolean;
begin
  if (Zahl >= Min) and (Zahl <= Max)
    then _RealRange:= true
    else _RealRange:= false;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _Kleinbuchstabe                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob das bergebene Zeichen ein Kleinbuchstabe ist      บ
 บ (a..z,,”,). Wenn die Bedingung zutrifft, liefert die Funktion  บ
 บ das Ergebnis True, sonst False.                                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _Kleinbuchstabe(ch: char): boolean;
begin
  if ch in ['a'..'z','','”','']
   then _Kleinbuchstabe:= true
   else _Kleinbuchstabe:= false;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _Grossbuchstabe                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob das bergebene Zeichen ein Grossbuchstabe ist      บ
 บ (A..Z,,,). Wenn die Bedingung zutrifft, liefert die Funktion  บ
 บ das Ergebnis True, sonst False.                                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _Grossbuchstabe(ch: char): boolean;
begin
  if ch in ['A'..'Z','','','']
   then _Grossbuchstabe:= true
   else _Grossbuchstabe:= false;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _Buchstabe                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob das bergebene Zeichen ein Buchstabe ist. Wenn die บ
 บ Bedingung zutrifft, liefert die Funktion das Ergebnis True,      บ
 บ sonst False.                                                     บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _Buchstabe(ch: char): boolean;
begin
  if _Kleinbuchstabe(ch) or _Grossbuchstabe(ch)
    then _Buchstabe:= true
    else _Buchstabe:= false;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _Ziffer                                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob das bergebene Zeichen eine Ziffer ist. Wenn die   บ
 บ Bedingung zutrifft, liefert die Funktion das Ergebnis True,      บ
 บ sonst False.                                                     บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _Ziffer(ch: char): boolean;
begin
  if ch in ['0'..'9'] then _Ziffer:= true
                      else _Ziffer:= false;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _AlleLeerzEntf                                                   บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Entfernt aus einem String smtliche Leerzeichen und liefert den  บ
 บ vernderten String als Ergebnis der Funktion zurck.             บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _AlleLeerzEntf(St: _Str): _Str;
var
  HelpStr: _Str;
  i      : byte;                                        {Zhlvariable}

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
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _StrToInteger                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Konvertiert einen String in einen Integerwert und liefert diesen บ
 บ als Ergebnis der Funktion zurck.                                บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _StrToInteger(St: _Str): integer;
var
  Erg   : real;                         {Umwandlung erst in Real-Zahl}
  i     : byte;                                         {Zhlvariable}
  Ok    : boolean;                               {Ob Konvertierung Ok}

{ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤKeineIntegerZahlฤฤ}
procedure KeineIntegerZahl;
begin
  _StrToInteger:= 0;
  _UOk:= false;
end;
{ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ}

begin
  St:= _AlleLeerzEntf(St);                     {Leerzeichen entfernen}
  Ok:= true;                                 {Angenommen Integer-Zahl}
  _UOk:= true;                              {Angenommen Umwandlung Ok}

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤIntegerzahl hat keinen Dez.Punkt und kein Kommaฤฤ}
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
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _StrToReal                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Konvertiert einen String in einen numerischen Wert. Das Ergebnis บ
 บ ist vom Typ Real. Leerzeichen werden entfernt, ein evtl. ","     บ
 บ wird durch den "." ersetzt.                                      บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _StrToReal(St: _Str): real;
var
  RealZahl: real;                      {Umgewandelter String als Real}
  Fehler  : integer;                      {Innerhalb der Val-Prozedur}
  i       : byte;                                       {Zhlvariable}

{ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤKeineRealZahlฤฤ}
procedure KeineRealZahl;
begin
  _StrToReal:= 0.0;
  _UOk:= false;
end;
{ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ}

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
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _NumToStr                                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Konvertiert einen numerischen Ausdruck in einen String und lie-  บ
 บ fert diesen als Ergebnis der Funktion zurck.                    บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _NumToStr(Zahl:real;Laenge,Nach:byte): _Str;
var St: _Str;

begin
  St:= '';
  Str(Zahl:Laenge:Nach,St);
  _NumToStr:= St;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _FileExist                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob die angegebene Datei auf der Diskette/Festplatte   บ
 บ vorhanden ist.                                                   บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _FileExist(Dateiname: _Str): boolean;
var Dummy: SearchRec;                                  {Fr FindFirst}
begin
  FindFirst(Dateiname,0,Dummy);
  _FileExist:= DosError = 0;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _FileMake                                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ berprft, ob eine Datei erzeugt (neu angelegt) werden kann, d.h.บ
 บ ob Rewrite fehlerfrei ausgefhrt werden konnte. Die Datei darf   บ
 บ noch nicht existieren, da sie sonst gel”scht wird.               บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _FileMake(Dateiname: _Str): boolean;
var
  f: file;                                  {Beliebige Diskettendatei}
  Err: byte;                                              {Fehlercode}

begin
  Assign(f,Dateiname);
  {$I-}  rewrite(f);  {$I+}
  if IOResult = 0 then
  begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤDatei”ffnung rckgngigฤฤ}
    _FileMake:= true;
    {$I-}
    Close(f);                                 {Datei wieder schlieแen}
    Erase(f);                                   {Datei wieder l”schen}
    {$I+}
    Err:= IOResult;                                {Ergebnis abfangen}
  end
  else _FileMake:= false;
end;
{อออออออออออออออออออออออออออออออออออออออออออออออออออออออEnd of unitออ}
end.