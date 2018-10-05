{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                     Turbo Vision-Demoprogramm                    �
 �                 Autor: Reiner Sch�lles, 25.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Unit zum Programmlister (Lister.pas).                            �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
{                     Inhalt und Hinweise

   Die Unit enth�lt Konstanten, Datentypen, Objekte und Routinen,
   die in Lister.pas ben�tigt werden.

   Der linke Rand und die Seitenl�nge sind als Konstanten verein-
   bart und m�ssen bei Bedarf im Quelltext angepa�t werden (oder
   das Programm mu� um die Eingabe dieser Gr��e erweitert werden).
   Soll ein anderer Drucker unterst�tzt werden, der nicht nach
   dem EPSON-Standard arbeitet, m�ssen die Druckroutinen unter
   'Druckersteuerung' angepa�t werden.
 陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}

Unit ListTpu;                                     {Datei: ListTpu.pas}
{$X+}                                              {Erweiterte Syntax}
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Interface (�ffentlicher Teil)                                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Interface
uses {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Einzubindende Bibliotheken陳}
  Dos,Printer,Views,Dialogs,MsgBox;

const {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Globale Konstanten陳}
  cmAbout      = 1001;                            {Copyright anzeigen}
  cmList       = 1002;                                  {Datei listen}
  cmPara       = 1003;                              {Parameter �ndern}
  cmChDir      = 1007;                              {Change Directory}
  cmDosShell   = 1009;                                     {Dos-Shell}

  HinweisStr = 'Demo-Programm zu Turbo Vision';
  ListName: PathStr = '';                        {Name der List-Datei}
  Lr: byte = 10;                                         {Linker Rand}
  FlZeilen: byte = 72;                       {Formularl�nge in Zeilen}
                                           {Endlospapier  = 72 Zeilen}
                                           {DIN A4-Papier = 66 Zeilen}
  LenHinweis = 40;                                 {L�nge Eingabefeld}

  DrDateiname: boolean = true;                    {Dateiname drucken?}
  DrZeilenNr: boolean = true;                    {Zeilen-Nr. drucken?}
  DrDatum: boolean = true;                            {Datum drucken?}
  DrUhrzeit: boolean = true;                        {Uhrzeit drucken?}
  DrHinweis: string = HinweisStr;               {Hinweis zum Ausdruck}
  DrNormal: boolean = true;                           {Normalschrift?}
  DrKlein: boolean = false;                            {Kleinschrift?}

type {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Globale Datentypen陳}

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�TParaDialog陳}
  PParaDialog = ^TParaDialog;
  TParaDialog = object(TDialog)
  end;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳ParaData陳}
  ParaDataRec = record                       {DatenRec f�r Dialogfeld}
    DruckData: word;                                 {Markierungsfeld}
    SchriftData: word;                                    {Schaltfeld}
    HinweisData: string[LenHinweis];                     {Eingabefeld}
  end;

var
  ListSeite: integer;                             {Seiten-Numerierung}
  ListZeile: integer;                             {Zeilen-Numerierung}
  ZNr: integer;                               {Zeilen auf einer Seite}

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Verzeichnis der globalen Routinen陳}

  procedure DruckvorgangVorbereiten;

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Implementation (Nicht-�ffentlicher Teil)                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Implementation

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                      Allgemeine Routinen                         �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 �                   Wochentag, Datum, Uhrzeit                      �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function Wochentag: string;
var
  year,month,day,DayOfWeek: word;

begin
  GetDate(year,month,day,DayOfWeek);
  case DayOfWeek of
    0: Wochentag:= 'Sonntag';
    1: Wochentag:= 'Montag';
    2: Wochentag:= 'Dienstag';
    3: Wochentag:= 'Mittwoch';
    4: Wochentag:= 'Donnerstag';
    5: Wochentag:= 'Freitag';
    6: Wochentag:= 'Samstag';
  end; {case}
end; {Wochentag}

function Datum: string;
const p = '.';
var
  Day,Month,Year,DayOfWeek: word;
  d,m,y: string[4];

begin
  GetDate(Year,Month,Day,DayOfWeek);                 {Datum ermitteln}

  Str(Year,y);
  Str(Month,m);
  Str(Day,d);

  Datum:= d + p + m  + p + y;
end; {Datum}

function Uhrzeit: string;
const p = ':';
var
  Hour,Min,Second,Sec100: word;
  h,m: string[2];

begin
  GetTime(Hour,Min,Second,Sec100);                    {Zeit ermitteln}

  Str(Hour,h);
  Str(Min,m);
  if Min < 10 then m:= '0' + m;

  Uhrzeit:= h + p + m;
end; {Uhrzeit}

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                  Druckersteuerung                                �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 �          Diverse Routinen zur Druckersteuerung.                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure ResetLst; {陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Drucker normieren陳}
begin
  write(lst,chr(27),chr(64));
end;

procedure LinkerRand; {陳陳陳陳陳陳陳陳陳陳陳Linken Rand einstellen陳}
begin
  write(lst,chr(27),chr(108),chr(Lr));
end;

procedure ZeichensatzUSA; {陳陳陳陳陳陳陳陳陳陳陳陳�Zeichensatz USA陳}
begin
  write(lst,chr(27),chr(82),chr(0));
end;

procedure NormalSchriftEin; {陳陳陳陳陳陳陳陳陳陳陳陳�Normalschrift陳}
begin
  write(lst,chr(27),chr(80));
end;

procedure KleinSchriftEin; {陳陳陳陳陳陳陳陳陳陳陳�Kleinschrift ein陳}
begin
  write(lst,chr(15));
end;

procedure KleinSchriftAus; {陳陳陳陳陳陳陳陳陳陳陳�Kleinschrift aus陳}
begin
  write(lst,chr(18));
end;

procedure FormularLaenge; {陳陳陳陳陳陳陳陳�Formularl�nge in Zeilen陳}
begin
  write(lst,chr(27),chr(67),chr(FlZeilen));
end;

procedure Seitenvorschub; {陳陳陳陳陳陳陳陳陳陳陳陳陳Seitenvorschub陳}
begin
  write(lst,chr(12));
end;

procedure HorizontaleLst(Len,Zeichen: byte); {陳陳陳陳陳陳陳陳Linie陳}
var i: byte;
begin
  for i:= 1 to Len do write(lst,chr(Zeichen));
end;

procedure LeerLst(n: byte); {陳陳陳陳陳陳陳陳陳陳陳陳陳陳Leerzeilen陳}
var i: byte;
begin
  for i:= 1 to n do writeln(lst);
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � ListKopfDrucken                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Druckt die Kopfzeilen.                                           �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure ListKopfDrucken;
begin
  ZNr:= 0;                           {Relative Zeilennummer pro Seite}
  if DrKlein then
  begin
    KleinschriftAus;                      {Kopf wird immer in Normal-}
    NormalschriftEin;                            {schrift geschrieben}
  end;
  Inc(ListSeite);
  LeerLst(1);                               {Eine Leerzeile am Anfang}
  Inc(ZNr);
  if DrDatum {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Datum drucken陳}
  then begin
         write(lst,'Programmlisting vom: ',Wochentag);
         write(lst,', den ',Datum);
         write(lst,' ':18-Length(Wochentag));
         writeln(lst,'Seite: ',ListSeite:3);
       end
  else writeln(lst,' ':30,'- ',ListSeite:3,' -');
  Inc(ZNr);
  if DrDateiname then {陳陳陳陳陳陳陳陳陳陳陳陳陳�Dateiname drucken陳}
  begin
    writeln(lst,'Programmname       : ',ListName);
    Inc(ZNr);
  end;
  if DrUhrzeit then {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Uhrzeit drucken陳}
  begin
    writeln(lst,'Uhrzeit            : ',Uhrzeit);
    Inc(ZNr);
  end;
  if DrHinweis <> '' then {陳陳陳陳陳陳陳陳陳陳陳陳�Hinweis drucken陳}
  begin
    writeln(lst,'Hinweis            : ',DrHinweis);
    Inc(ZNr);
  end;
  HorizontaleLst(65,61);
  LeerLst(3);
  Inc(ZNr,4);
  if DrKlein then KleinschriftEin;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Ausdruck                                                         �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Steuert den Ausdruck der Datei.                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure Ausdruck;
var
  f: Text;                                   {Listdatei als Textdatei}
  TZeile: string[249];                       {Eine gelesene Textzeile}

begin
  ResetLst;                                        {Drucker normieren}
  ZeichensatzUSA;                                 {Zeichensatz w�hlen}
  FormularLaenge;                               {Formularl�nge setzen}
  LinkerRand;                                 {Linken Rand einstellen}
  ListSeite:= 0;                                         {Anfangswert}
  ListZeile:= 0;                                         {Anfangswert}
  Assign(f,ListName);
  reset(f);                                             {Datei �ffnen}
  if DrKlein
   then KleinSchriftEin
   else NormalschriftEin;
  ListKopfDrucken;
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Textdatei drucken陳}
  while not Eof(f) do
  begin
    readln(f,TZeile);
    Inc(ListZeile);                               {Absolute ZeilenNr.}
    Inc(ZNr);                                     {Relative ZeilenNr.}
    if DrZeilenNr
     then writeln(lst,ListZeile:4,': ',TZeile)
     else writeln(lst,TZeile);
    if ZNr = (FlZeilen - 6) then
    begin
      Seitenvorschub;
      ListKopfDrucken;
    end;
  end; {while}
  close(f);                                   {Datei wieder schlie�en}
  Seitenvorschub;
  if DrKlein then
  begin
    KleinschriftAus;
    NormalSchriftEin;
  end;
  ResetLst;                              {Drucker wieder zur�cksetzen}
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � DruckerOK                                                        �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Pr�ft, ob der Drucker betriebsbereit ist und liefert als Ergebnis�
 � True oder False.                                                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function DruckerOK: boolean;
begin
  {$I-}
  write(lst,' ');
  {$I+}
  if IOResult <> 0 then DruckerOk:= false
                   else DruckerOk:= true;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � DruckvorgangVorbereiten                                          �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Bereitet nach der Auswahl einer Datei den Druckvorgang vor.      �
 � .EXE- und .COM-Dateien werden nicht gelistet!                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure DruckvorgangVorbereiten;
const
  Msg = 'Drucker einschalten und Papier ' +
        'auf Blattanfang stellen!';

var
  Dir: DirStr;                                   {Dummy f�r Directory}
  Name: NameStr;                                 {Dummy f�r Dateiname}
  Ext: ExtStr;                                 {Dateiendung mit Punkt}
  s: string;                                {Eventuelle Fehlermeldung}
  ok,Abbruch: boolean;                                   {Drucker ok?}
  Erg: word;                                        {Ergebnis Abfrage}

begin
  s:= '-Dateien k�nnen nicht gelistet werden!';
  FSplit(ListName,Dir,Name,Ext);               {Dateiname aufsplitten}
  s:= Ext + s;
  if (Ext <> '.EXE') and
     (Ext <> '.COM')
  then begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�G�ltiger Dateiname陳}
       ok:= false;
       Abbruch:= false;
       repeat
         Erg:= MessageBox(Msg,nil,mfInformation +
                          mfOkButton + mfCancelButton);
         if Erg <> cmCancel
         then begin
                if DruckerOk then ok:= true
                             else ok:= false;
              end
         else Abbruch:= true;
       until ok or Abbruch;
       if ok then Ausdruck;
       end
  else MessageBox(s,nil,mfError + mfOKButton);
end;
{様様様様様様様様様様様様様様様様様様様様様様様様様様様�End of unit様}
end.