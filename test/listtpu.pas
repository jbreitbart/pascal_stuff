{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                     Turbo Vision-Demoprogramm                    บ
 บ                 Autor: Reiner Sch”lles, 25.10.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Unit zum Programmlister (Lister.pas).                            บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
{                     Inhalt und Hinweise

   Die Unit enthlt Konstanten, Datentypen, Objekte und Routinen,
   die in Lister.pas ben”tigt werden.

   Der linke Rand und die Seitenlnge sind als Konstanten verein-
   bart und mssen bei Bedarf im Quelltext angepaแt werden (oder
   das Programm muแ um die Eingabe dieser Gr”แe erweitert werden).
   Soll ein anderer Drucker untersttzt werden, der nicht nach
   dem EPSON-Standard arbeitet, mssen die Druckroutinen unter
   'Druckersteuerung' angepaแt werden.
 ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ}

Unit ListTpu;                                     {Datei: ListTpu.pas}
{$X+}                                              {Erweiterte Syntax}
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Interface (ffentlicher Teil)                                    บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Interface
uses {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤEinzubindende Bibliothekenฤฤ}
  Dos,Printer,Views,Dialogs,MsgBox;

const {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤGlobale Konstantenฤฤ}
  cmAbout      = 1001;                            {Copyright anzeigen}
  cmList       = 1002;                                  {Datei listen}
  cmPara       = 1003;                              {Parameter ndern}
  cmChDir      = 1007;                              {Change Directory}
  cmDosShell   = 1009;                                     {Dos-Shell}

  HinweisStr = 'Demo-Programm zu Turbo Vision';
  ListName: PathStr = '';                        {Name der List-Datei}
  Lr: byte = 10;                                         {Linker Rand}
  FlZeilen: byte = 72;                       {Formularlnge in Zeilen}
                                           {Endlospapier  = 72 Zeilen}
                                           {DIN A4-Papier = 66 Zeilen}
  LenHinweis = 40;                                 {Lnge Eingabefeld}

  DrDateiname: boolean = true;                    {Dateiname drucken?}
  DrZeilenNr: boolean = true;                    {Zeilen-Nr. drucken?}
  DrDatum: boolean = true;                            {Datum drucken?}
  DrUhrzeit: boolean = true;                        {Uhrzeit drucken?}
  DrHinweis: string = HinweisStr;               {Hinweis zum Ausdruck}
  DrNormal: boolean = true;                           {Normalschrift?}
  DrKlein: boolean = false;                            {Kleinschrift?}

type {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤGlobale Datentypenฤฤ}

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤTParaDialogฤฤ}
  PParaDialog = ^TParaDialog;
  TParaDialog = object(TDialog)
  end;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤParaDataฤฤ}
  ParaDataRec = record                       {DatenRec fr Dialogfeld}
    DruckData: word;                                 {Markierungsfeld}
    SchriftData: word;                                    {Schaltfeld}
    HinweisData: string[LenHinweis];                     {Eingabefeld}
  end;

var
  ListSeite: integer;                             {Seiten-Numerierung}
  ListZeile: integer;                             {Zeilen-Numerierung}
  ZNr: integer;                               {Zeilen auf einer Seite}

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤVerzeichnis der globalen Routinenฤฤ}

  procedure DruckvorgangVorbereiten;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Implementation (Nicht-”ffentlicher Teil)                         บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Implementation

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                      Allgemeine Routinen                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ                   Wochentag, Datum, Uhrzeit                      บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                  Druckersteuerung                                บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ          Diverse Routinen zur Druckersteuerung.                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure ResetLst; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤDrucker normierenฤฤ}
begin
  write(lst,chr(27),chr(64));
end;

procedure LinkerRand; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤLinken Rand einstellenฤฤ}
begin
  write(lst,chr(27),chr(108),chr(Lr));
end;

procedure ZeichensatzUSA; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤZeichensatz USAฤฤ}
begin
  write(lst,chr(27),chr(82),chr(0));
end;

procedure NormalSchriftEin; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤNormalschriftฤฤ}
begin
  write(lst,chr(27),chr(80));
end;

procedure KleinSchriftEin; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤKleinschrift einฤฤ}
begin
  write(lst,chr(15));
end;

procedure KleinSchriftAus; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤKleinschrift ausฤฤ}
begin
  write(lst,chr(18));
end;

procedure FormularLaenge; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤFormularlnge in Zeilenฤฤ}
begin
  write(lst,chr(27),chr(67),chr(FlZeilen));
end;

procedure Seitenvorschub; {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤSeitenvorschubฤฤ}
begin
  write(lst,chr(12));
end;

procedure HorizontaleLst(Len,Zeichen: byte); {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤLinieฤฤ}
var i: byte;
begin
  for i:= 1 to Len do write(lst,chr(Zeichen));
end;

procedure LeerLst(n: byte); {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤLeerzeilenฤฤ}
var i: byte;
begin
  for i:= 1 to n do writeln(lst);
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ ListKopfDrucken                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Druckt die Kopfzeilen.                                           บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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
  if DrDatum {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤDatum druckenฤฤ}
  then begin
         write(lst,'Programmlisting vom: ',Wochentag);
         write(lst,', den ',Datum);
         write(lst,' ':18-Length(Wochentag));
         writeln(lst,'Seite: ',ListSeite:3);
       end
  else writeln(lst,' ':30,'- ',ListSeite:3,' -');
  Inc(ZNr);
  if DrDateiname then {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤDateiname druckenฤฤ}
  begin
    writeln(lst,'Programmname       : ',ListName);
    Inc(ZNr);
  end;
  if DrUhrzeit then {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤUhrzeit druckenฤฤ}
  begin
    writeln(lst,'Uhrzeit            : ',Uhrzeit);
    Inc(ZNr);
  end;
  if DrHinweis <> '' then {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤHinweis druckenฤฤ}
  begin
    writeln(lst,'Hinweis            : ',DrHinweis);
    Inc(ZNr);
  end;
  HorizontaleLst(65,61);
  LeerLst(3);
  Inc(ZNr,4);
  if DrKlein then KleinschriftEin;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Ausdruck                                                         บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Steuert den Ausdruck der Datei.                                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure Ausdruck;
var
  f: Text;                                   {Listdatei als Textdatei}
  TZeile: string[249];                       {Eine gelesene Textzeile}

begin
  ResetLst;                                        {Drucker normieren}
  ZeichensatzUSA;                                 {Zeichensatz whlen}
  FormularLaenge;                               {Formularlnge setzen}
  LinkerRand;                                 {Linken Rand einstellen}
  ListSeite:= 0;                                         {Anfangswert}
  ListZeile:= 0;                                         {Anfangswert}
  Assign(f,ListName);
  reset(f);                                             {Datei ”ffnen}
  if DrKlein
   then KleinSchriftEin
   else NormalschriftEin;
  ListKopfDrucken;
  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤTextdatei druckenฤฤ}
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
  close(f);                                   {Datei wieder schlieแen}
  Seitenvorschub;
  if DrKlein then
  begin
    KleinschriftAus;
    NormalSchriftEin;
  end;
  ResetLst;                              {Drucker wieder zurcksetzen}
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ DruckerOK                                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Prft, ob der Drucker betriebsbereit ist und liefert als Ergebnisบ
 บ True oder False.                                                 บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function DruckerOK: boolean;
begin
  {$I-}
  write(lst,' ');
  {$I+}
  if IOResult <> 0 then DruckerOk:= false
                   else DruckerOk:= true;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ DruckvorgangVorbereiten                                          บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Bereitet nach der Auswahl einer Datei den Druckvorgang vor.      บ
 บ .EXE- und .COM-Dateien werden nicht gelistet!                    บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure DruckvorgangVorbereiten;
const
  Msg = 'Drucker einschalten und Papier ' +
        'auf Blattanfang stellen!';

var
  Dir: DirStr;                                   {Dummy fr Directory}
  Name: NameStr;                                 {Dummy fr Dateiname}
  Ext: ExtStr;                                 {Dateiendung mit Punkt}
  s: string;                                {Eventuelle Fehlermeldung}
  ok,Abbruch: boolean;                                   {Drucker ok?}
  Erg: word;                                        {Ergebnis Abfrage}

begin
  s:= '-Dateien k”nnen nicht gelistet werden!';
  FSplit(ListName,Dir,Name,Ext);               {Dateiname aufsplitten}
  s:= Ext + s;
  if (Ext <> '.EXE') and
     (Ext <> '.COM')
  then begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤGltiger Dateinameฤฤ}
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
{อออออออออออออออออออออออออออออออออออออออออออออออออออออออEnd of unitออ}
end.