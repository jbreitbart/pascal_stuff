UNIT MenuDat;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                Autorin: Gabi Rosenbaum  02.09.1992               �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 �Datenstrukturen und Initialisierungen zum Menuprogramm 2.0        �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Interface
Uses  Dos,                              {Bibiothek aus Borland-Pascal}
      Objects;                            {Bibiothen aus Turbo-Vision}

Type
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Datenstruktur f�r 9 Auswahlmenues                                 �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
                                  {9 verschiedene Programmobergruppen}
   TAuswahl   = Array[1..9] of String[30];  
                       {Pro Obergruppe 9 verschiedene Programmaufrufe}
   TProgramm  = Array[1..9] of TAuswahl;
                                {Insgesamt 81 Files f�r die Programme}
   TFiles     = Array[1..9] of Array[1..9]
                of String[127];

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �DatenStruktur f�r die allgemeinen Voreinstellungen                �
 �TVorEinRec ist als Record vereinbart, damit zus�tzliche           �
 �Initialisierungen einfach eingef�gt werden k�nnen                 �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
   TVorEinRec = Record
     ScreenSaveZeit : Word;           {Zeit f�r den Bildschirmschoner}
   end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Datenstruktur f�r die Initialisierungsdatei                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
   IniDateiRec = Record
     Auswahl         : TAuswahl;                 {Programmobergruppen}
     Programm        : TProgramm;                    {Programmaufrufe} 
     Voreinstellungen: TVorEinRec;                  {Voreinstellungen}
   end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �File zum Abspeichern der Initialisierungsdaten                    �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
   IniFile     = File of IniDateiRec;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Datenstruktur f�r den Menudialog                                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
    MenueintragData = Array [1..9] of String [19];

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Datenstruktur f�r den Programmpunktdialog                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
    ProgrammpunktData = Record
      String0: String [29];
      String1: String [127];
    END;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Datenstruktur f�r den Voreinstellungendialog                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
    RVoreinData = Record
      Cluster0 : WORD;
    END;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Datenstruktur f�r die Erstinitialisierung                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
    RFirstDlgData = Record
      Cluster0 : WORD;
    end;

CONST
  {敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
   �cm-Konstanten f�r das Menuprogramm                              �
   青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
   cmMenuInit    = 100;
   cmLoeschen    = 101;
   cmMenuAuswahl : Array[1..9] of Word =
                   (102,103,104,105,106,107,108,109,110);
   cmMenuSelect  : Array[1..9] of Word =
                   (111,112,113,114,115,116,117,118,119);
   cmProgBesA    : Array[1..9] of Word =
                   (151,152,153,154,155,156,157,158,159);
   cmColor        = 120;
   cmSaveOpt      = 122;
   cmAbout        = 123;
   cmProgramm     = 124;
   cmAkzept       = 125;
   cmBearbeiten   = 126;
   cmHotKey       = 127;
   cmDatManager   = 128;
   cmVorein       = 129;
   cmDos          = 130;
   cmFertig       = 131;
   cmProgBes      = 132;

  {敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
   �Messages f�r BroadCast-Rundrufe                                 �
   青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
   msMenuChanged  = 4000;
   msTextChanged  = 4001;
   msMousePressed = 4002;
   msEintrag      = 4003;

  {敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
   �Farbpaletten                                                    �
   青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
   NewCM   =  #$70#$70#$20#$70#$2F;         {Farbpalette  Menufenster}
   NewBWM  =  #$70#$70#$07#$78#$0F;         {BW-Palette   Menufenster}
   NewMM   =  #$70#$70#$07#$70#$0F;         {Monopalette  Menufenster}
   NewCS   =  #$70#$70#$20#$70#$2F;      {Farbpalette Programmfenster}
   NewBWS  =  #$70#$70#$07#$78#$0F;      {BW-Palette  Programmfenster}
   NewMS   =  #$70#$70#$07#$70#$0F;      {Monopalette Programmfenster}
   Zaehlt  :  Boolean = False;              {Screensavezaehlung aktiv}
   Anf     :  LongInt = 0;              {Beginn der Screensavezaelung}

VAR
  ColorFileName   : PathStr;     {Zum Speichern der Farbeinstellungen}
  InitFileName    : PathStr;     {Zum Speichern der Initialisierungen}
  AufrufDateiName : PathStr;               {Zum Speichern der Aufrufe }
  HilfeName       : PathStr;                    {Datei der Hilfetexte}
  BatchName       : PathStr;                {Dateiname der Batchdatei}
  EinGest         : Word;                {Eingestellte Screensavezeit}
  Parameter       : String;                    {�bergebener Parameter}
  ActMenu         : TAuswahl;                  {Aktuelle Menueintr�ge}
  ActProgramm     : TProgramm;             {Aktuelle Programmeintr�ge}
  ActFiles        : TFiles;                  {Aktuelle Aufrufeintr�ge}
  ActProgramFile  : File of TFiles; {Dateivariable f�r Aufrufeintr�ge}
  ActVorein       : TVorEinRec;            {Aktuelle Voreinstellungen}
  MenuEintrag     : MenuEintragData;  {Daten f�r Dialog-Menueintragen}
  ProgrammPunkt   : ProgrammPunktData; {Daten Dialog-Programmeintr�ge}
  ActMenuSel      : Char;                       {Aktuelle Menuauswahl}
  Gef             : PString;         {Eintrag gefunden in TScanDialog}
  VoreinData      : RVoreinData;   {Daten f�r Dialog-Voreinstellungen}
  FirstDlgData    : RFirstDlgData; {Erstinitialisierung des Programms}

Procedure InitActMenu;

Procedure InitActProgrammauswahl;

Procedure InitFiles;

Procedure InitActVoreinstellungen;

IMPLEMENTATION

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure InitActMenu;                                            �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisierung der Aktuellen Menueintr�ge auf +++                �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure InitActMenu;                                              
var
  Lauf: Word;                                          {Laufvariable}
Begin
  For Lauf := 1 to 9 do
  ActMenu[Lauf] := '+++';
end;                                                     {InitActMenu}


{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure InitActProgrammauswahl;                                 �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisierung der aktuellen Programmpunkte                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure InitActProgrammauswahl;                                   
Var
  Lauf1: Word;                                          {Laufvariable}
  Lauf2: Word;                                          {Laufvariable}
Begin
  For Lauf1 := 1 to 9 do
  For Lauf2 := 1 to 9 do
  ActProgramm[Lauf1][Lauf2] := '+++';
end;                                          {InitactProgrammauswahl}


{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure InitFiles;                                              �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisierung der Programmaufrufe                               �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure InitFiles;                                                
Var
  Lauf1: Word;                                          {Laufvariable}
  Lauf2: Word;                                          {Laufvariable}
Begin
  For Lauf1 := 1 to 9 do
  For Lauf2 := 1 to 9 do
  ActFiles[Lauf1][Lauf2] := '';
end;                                                       {InitFiles}


{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure InitActVoreinstellungen;                                �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Initialisierungen der Voreinstellungen                            �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure InitActVoreinstellungen;                                  
Begin
  With ActVorein do
  Begin
    ScreenSaveZeit := 2;
  end;
end;                                         {InitActVoreinstellungen}
END.
