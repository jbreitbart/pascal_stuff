{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º        Demoprogramm zum Turbo Vision-Hilfesystem           º
 º                                                            º
 º            Autor: Reiner Sch”lles, 30.10.92                º
 º                                                            º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
Program HDemo4;
{$X+}                                        {Erweiterte Syntax}
{$M 16384,8192,655360}
uses {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄEinzubindende BibliothekenÄÄ}
  Dos,App,Objects,Menus,
  Drivers,Views,Dialogs,
  MsgBox,StdDlg,Memory,
  Gadgets,HelpFile,                     {Units aus Turbo Pascal}
  HText;                               {Unit von TVHC generiert}

const {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄGlobale KonstantenÄÄ}
  cmAbout      = 1001;                      {Copyright anzeigen}
  cmComp       = 1002;                           {Compiler-Info}
  cmDosShell   = 1003;                               {Dos-Shell}

  PrgName   = ^C'Help-Demo-Programm'#13;          {Programmname}
  AutorName = ^C'Reiner Sch”lles';             {Name des Autors}

  _EXEDatei = 'HDemo4.Exe';             {Name dieser .EXE-Datei}
  _HLPDatei = 'HText.Hlp';               {Datei mit Hilfetexten}



  PrgInfo = PrgName +                            {Programm-Info}
            ^C'Copyright (C) 1992 by' +  #13 +
             AutorName;

  CompInfo = ^C'Programm erstellt mit'#13 +      {Compiler-Info}
             ^C'Turbo Pascal 7.0'#13 +
             ^C'Borland International, Inc.';

type {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄGlobale DatentypenÄÄ}
  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄTDemo ÄÄ}
  TDemo = object (TApplication)
    Uhrzeit: PClockView;
    Heap: PHeapView;
    constructor Init;
    procedure Idle; virtual;
    procedure InitStatusLine; virtual;
    procedure InitMenuBar; virtual;
    procedure OutOfMemory; virtual;
    procedure DosShell;
    procedure HandleEvent(var Event: TEvent); virtual;
    procedure GetEvent(var Event: TEvent); virtual;
    function GetPalette: PPalette; virtual;
  end;

var {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄGlobale VariablenÄÄ}
  HDemoApp: TDemo;                           {Programm-Variable}

  {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄVerzeichnis der globalen RoutinenÄÄ}

{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º Implementierung der Methoden von TDemo                     º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.Init                                                 ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ šbernimmt die notwendigen Initialisierungen, z.B. Anzeige  ³
 ³ der Uhrzeit und des freien Arbeitsspeiches.                ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
constructor TDemo.Init;
var
  R: TRect;                     {Rechteckiger Bildschirmbereich}

begin
  TApplication.Init;               {Init-Methode des Vorg„ngers}
  RegisterHelpFile;                   {Help-Stream registrieren}

  GetExtent(R); {ÄÄÄÄÄÄÄÄÄÄÄInitialisiert Anzeige der UhrzeitÄÄ}
  R.A.X:= R.B.X - 9;
  R.B.Y:= R.A.Y + 1;
  Uhrzeit:= New(PClockView,Init(R));
  Insert(Uhrzeit);

  GetExtent(R); {ÄÄÄÄInitialisiert Anzeige d.freien SpeichersÄÄ}
  Dec(R.B.X);
  R.A.X:= R.B.X - 9;
  R.A.Y:= R.B.Y - 1;
  Heap := New(PHeapView,Init(R));
  Insert(Heap);

  MessageBox(PrgInfo,nil,               {Programm-Info anzeigen}
             mfInformation + mfOkButton);
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.Idle                                                 ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Idle ist eine abstrakte Methode, die hier berschrieben    ³
 ³ wird. Sie wird immer dann aufgerufen, wenn keine Ereignisse³
 ³ zur Bearbeitung vorliegen.                                 ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TDemo.Idle;
begin
  TApplication.Idle;                     {Aufruf des Vorg„ngers}
  Uhrzeit^.Update;                       {Uhrzeit aktualisieren}
  Heap^.Update;                  {Freien Speicher aktualisieren}
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.InitStatusLine                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Initialisiert eine neue Statuszeile und berschreibt damit ³
 ³ die von TProgram.InitStatusLine.                           ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TDemo.InitStatusLine;
var
  R: TRect;                           {Rechteck fr Statuszeile}

begin
  GetExtent(R);            {Liefert H”he und Breite des Objekts}
  R.A.Y:= R.B.Y - 1;        {Gr”áe und Position der Statuszeile}
  StatusLine:= New(PStatusLine,Init(R,
    NewStatusDef(0,$FFFF,
      NewStatusKey('~F1~ Hilfe',kbF1,cmHelp,
      NewStatusKey('~Alt-F3~ Schlieáen',kbAltF3,cmClose,
      NewStatusKey('~F10~ Men',kbF10,cmMenu,
      NewStatusKey('~Alt-X~ Programm beenden',kbAltX,cmQuit,
      nil)))),
    nil)
  ));
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.InitMenuBar                                          ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Initialisiert eine neue Menleiste und berschreibt  damit ³
 ³ die von TProgram.InitMenuBar.                              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TDemo.InitMenuBar;
var
  R: TRect;                            {Rechteck fr Menleiste}

begin
  GetExtent(R);               {Liefert Gr”áe der aktuellen View}
  R.B.Y:= R.A.Y + 1;         {Gr”áe und Position der Menleiste}
  MenuBar:= New(PMenuBar,Init(R,NewMenu(
    NewSubMenu('~S~ystem',hcNoContext,NewMenu(
      NewItem('šber das ~P~rogramm...','',kbNoKey,cmAbout,hcSAbout,
      NewItem('~C~ompiler-Info...','',kbNoKey,cmComp,hcSCompiler,
      NewItem('~D~OS shell','',kbNoKey,cmDosShell,hcSDosShell,
      NewLine(
      NewItem('~B~eenden','Alt-X',kbAltX,cmQuit,hcSBeenden,
      nil)))))),
    nil)
  )));
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.OutOfMemory                                          ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ šberschreibt die gleichnamige Methode und implementiert    ³
 ³ eine eigene Fehlermeldung, die auf Grund von ValidView     ³
 ³ gleich True ausgegeben wird.                               ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TDemo.OutOfMemory;
begin
  MessageBox(#13 + 'Arbeitsspeicher reicht fr durch' +
               'gefhrte Operation nicht aus!',nil,
               mfError + mfOkButton);
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.DosShell                                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Wechselt auf die DOS-Ebene.                                ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TDemo.DosShell;
begin
  DoneSysError;
  DoneEvents;
  DoneVideo;
  DoneMemory;
  SetMemTop(HeapPtr);
  PrintStr('Mit EXIT zurck zum Programm...');
  SwapVectors;
  Exec(GetEnv('COMSPEC'), '');
  SwapVectors;
  SetMemTop(HeapEnd);
  InitMemory;
  InitVideo;
  InitEvents;
  InitSysError;
  Redraw;
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.HandleEvent                                          ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Stellt fr den oben genannten Objekttyp einen Event-Handler³
 ³ zur Verfgung.                                             ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TDemo.HandleEvent(var Event: TEvent);
begin
  TApplication.HandleEvent(Event);
  if Event.What = evCommand then
  begin
    case Event.Command of
      cmAbout     : MessageBox(PrgInfo,nil,
                               mfInformation + mfOkButton);
      cmComp      : MessageBox(CompInfo,nil,
                               mfInformation + mfOkButton);
      cmDosShell  : DosShell;
      else Exit;
    end; {case}
    ClearEvent(Event);
  end; {if}
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.GetEvent                                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ F„ngt cmHelp ab und ”ffnet den Help-Stream.                ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
procedure TDemo.GetEvent(var Event: TEvent);
const
  HelpInUse: boolean = false;

{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄErmittleHelpNameÄÄ}
function ErmittleHelpName: PathStr;
var
  EXEName: PathStr;                   {Dateiname der .EXE-Datei}
  D: DirStr;                                         {Directory}
  N: NameStr;                                   {Name der Datei}
  E: ExtStr;                                       {Erweiterung}

begin
  if Lo(DosVersion) >= 3
   then EXEName:= ParamStr(0)
   else EXEName:= FSearch(_EXEDatei,GetEnv('PATH'));
   FSplit(EXEName,D,N,E);
   if D[Length(D)] = '\' then Dec(D[0]);
   ErmittleHelpName:= FSearch(_HLPDatei,D);
end;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄCallHelpFileÄÄ}
procedure CallHelpFile(var HelpFree: boolean);
var
  W: PWindow;
  HelpFile: PHelpFile;
  HelpStrm: PDosStream;

begin
  HelpStrm:= New(PDosStream,Init(ErmittleHelpName,stOpenRead));
  HelpFile:= New(PHelpFile,Init(HelpStrm));
  if HelpStrm^.Status <> stOk
  then begin
         MessageBox('Hilfedatei ' + _HLPDatei + ' konnte nicht ' +
                    'ge”ffnet werden!',nil,mfError + mfOkButton);
         Dispose(HelpFile,Done);
       end
  else begin
         HelpFree:= true;
         W:= New(PHelpWindow,Init(Helpfile,GetHelpCtx));
         if ValidView(W) <> nil then
         begin
           ExecView(W);
           Dispose(W,Done);
         end;
         HelpFree:= false;
         ClearEvent(Event);
       end;
end;
{ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ}

begin
  TApplication.GetEvent(Event);       {Aufruf Vorg„nger-Methode}
  If (Event.What = evCommand) and
     (Event.Command = cmHelp) and not HelpInUse
  then CallHelpFile(HelpInUse);
end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³ TDemo.GetPalette                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³ Paát die Farbpalette an. Siehe auch Demo-Programm (TVDemo) ³
 ³ zu Turbo Vision von Borland.                               ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
function TDemo.GetPalette: PPalette;
const
  CNewColor = CAppColor + CHelpColor;
  CNewBW = CAppBlackWhite + CHelpBlackWhite;
  CNewMono = CAppMonochrome + CHelpMonochrome;
  P: array[apColor..apMonochrome]
      of string[Length(CNewColor)] = (CNewColor,CNewBW,CNewMono);

begin
  GetPalette:= @P[AppPalette];
end;

{ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ}

begin {ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄHauptprogrammÄÄ}
  HDemoApp.Init;
  HDemoApp.Run;
  HDemoApp.Done;
end.
{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º End of Program                                             º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}