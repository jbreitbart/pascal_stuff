UNIT MenuDat;
{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                Autorin: Gabi Rosenbaum  02.09.1992               º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 ºDatenstrukturen und Initialisierungen zum Menuprogramm 2.0        º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Interface
Uses  Dos,                              {Bibiothek aus Borland-Pascal}
      Objects;                            {Bibiothen aus Turbo-Vision}

Type
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Datenstruktur fr 9 Auswahlmenues                                 ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
                                  {9 verschiedene Programmobergruppen}
   TAuswahl   = Array[1..9] of String[30];  
                       {Pro Obergruppe 9 verschiedene Programmaufrufe}
   TProgramm  = Array[1..9] of TAuswahl;
                                {Insgesamt 81 Files fr die Programme}
   TFiles     = Array[1..9] of Array[1..9]
                of String[127];

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³DatenStruktur fr die allgemeinen Voreinstellungen                ³
 ³TVorEinRec ist als Record vereinbart, damit zus„tzliche           ³
 ³Initialisierungen einfach eingefgt werden k”nnen                 ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
   TVorEinRec = Record
     ScreenSaveZeit : Word;           {Zeit fr den Bildschirmschoner}
   end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Datenstruktur fr die Initialisierungsdatei                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
   IniDateiRec = Record
     Auswahl         : TAuswahl;                 {Programmobergruppen}
     Programm        : TProgramm;                    {Programmaufrufe} 
     Voreinstellungen: TVorEinRec;                  {Voreinstellungen}
   end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³File zum Abspeichern der Initialisierungsdaten                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
   IniFile     = File of IniDateiRec;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Datenstruktur fr den Menudialog                                  ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
    MenueintragData = Array [1..9] of String [19];

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Datenstruktur fr den Programmpunktdialog                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
    ProgrammpunktData = Record
      String0: String [29];
      String1: String [127];
    END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Datenstruktur fr den Voreinstellungendialog                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
    RVoreinData = Record
      Cluster0 : WORD;
    END;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Datenstruktur fr die Erstinitialisierung                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
    RFirstDlgData = Record
      Cluster0 : WORD;
    end;

CONST
  {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³cm-Konstanten fr das Menuprogramm                              ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
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

  {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³Messages fr BroadCast-Rundrufe                                 ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
   msMenuChanged  = 4000;
   msTextChanged  = 4001;
   msMousePressed = 4002;
   msEintrag      = 4003;

  {ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
   ³Farbpaletten                                                    ³
   ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
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
  Parameter       : String;                    {šbergebener Parameter}
  ActMenu         : TAuswahl;                  {Aktuelle Menueintr„ge}
  ActProgramm     : TProgramm;             {Aktuelle Programmeintr„ge}
  ActFiles        : TFiles;                  {Aktuelle Aufrufeintr„ge}
  ActProgramFile  : File of TFiles; {Dateivariable fr Aufrufeintr„ge}
  ActVorein       : TVorEinRec;            {Aktuelle Voreinstellungen}
  MenuEintrag     : MenuEintragData;  {Daten fr Dialog-Menueintragen}
  ProgrammPunkt   : ProgrammPunktData; {Daten Dialog-Programmeintr„ge}
  ActMenuSel      : Char;                       {Aktuelle Menuauswahl}
  Gef             : PString;         {Eintrag gefunden in TScanDialog}
  VoreinData      : RVoreinData;   {Daten fr Dialog-Voreinstellungen}
  FirstDlgData    : RFirstDlgData; {Erstinitialisierung des Programms}

Procedure InitActMenu;

Procedure InitActProgrammauswahl;

Procedure InitFiles;

Procedure InitActVoreinstellungen;

IMPLEMENTATION

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure InitActMenu;                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Initialisierung der Aktuellen Menueintr„ge auf +++                ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure InitActMenu;                                              
var
  Lauf: Word;                                          {Laufvariable}
Begin
  For Lauf := 1 to 9 do
  ActMenu[Lauf] := '+++';
end;                                                     {InitActMenu}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure InitActProgrammauswahl;                                 ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Initialisierung der aktuellen Programmpunkte                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure InitActProgrammauswahl;                                   
Var
  Lauf1: Word;                                          {Laufvariable}
  Lauf2: Word;                                          {Laufvariable}
Begin
  For Lauf1 := 1 to 9 do
  For Lauf2 := 1 to 9 do
  ActProgramm[Lauf1][Lauf2] := '+++';
end;                                          {InitactProgrammauswahl}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure InitFiles;                                              ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Initialisierung der Programmaufrufe                               ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure InitFiles;                                                
Var
  Lauf1: Word;                                          {Laufvariable}
  Lauf2: Word;                                          {Laufvariable}
Begin
  For Lauf1 := 1 to 9 do
  For Lauf2 := 1 to 9 do
  ActFiles[Lauf1][Lauf2] := '';
end;                                                       {InitFiles}


{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure InitActVoreinstellungen;                                ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Initialisierungen der Voreinstellungen                            ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure InitActVoreinstellungen;                                  
Begin
  With ActVorein do
  Begin
    ScreenSaveZeit := 2;
  end;
end;                                         {InitActVoreinstellungen}
END.
