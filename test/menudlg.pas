{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                Autorin: Gabi Rosenbaum  02.09.1992               �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 �Objekte, Dialoge und allgemeine Funktionen zum Menuprogramm 2.0   �
 ������������������������������������������������������������������ͼ}
Unit MenuDlg;                                     {Datei: MenuDlg.pas}
Interface
Uses
   Dos,                                {Bibliothek aus Borland Pascal}
   Objects, App, ColorSel, Dialogs,
   Drivers, Views, Menus, MsgBox,        {Bibliothek aus Turbo-Vision}
   MenuDat;                           {Datenunit zum Menuprogramm 2.0}

{������������������������������������������������������������������Ŀ
 �Object TDynamicText                                               �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      : Gibt einen Text aus (wie TStaticText), der Text    �
 �               kann �ber die Methode SetIText ver�ndert werden    �
 �Felder       : IText   : Text der ausgegeben werden soll          �
 �Neue Methoden: SetIText: Besetzt das Feld IText                   �
 ��������������������������������������������������������������������}
Type
  PDynamicText = ^TDynamicText;
  TDynamicText = Object(TView)
    IText   : String;
    Constructor Init(Var Bounds: TRect; AText: String);
    Constructor Load(Var S: TStream);
    Procedure   Store(Var S: TStream);
    Procedure   Draw;Virtual;
    Function    GetPalette : PPalette;Virtual;
    Procedure   SetIText(NeuStr: String);
  end;

  {Palettenlayout}
  {1 = Aktiv Normal}

Const
  CDynamicText   = #6;  {Paletteneintrag statischer Text von CDialog}

{������������������������������������������������������������������Ŀ
 �Object TProgrammTitle                                             �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      :  �berschreibt den Fenstertitel des Programmaufruf- �
 �                fensters(rechte Seite)                            �
 �Felder       :  Titel      : Fenstertitel                         �
 �Neue Methoden:  ConvertStr : Konvertiert den Fenstertitel so, da� �
 �                             er in den Rahmen pa�t                �
 �                SetItem    : Titel neu besetzen                   �
 ��������������������������������������������������������������������}
Type
   PProgrammTitle = ^TProgrammTitle;
   TProgrammTitle = Object(TView)
     Titel : String;   
     Constructor Init(Var Bounds: TRect);
     Constructor Load(Var S: TStream);
     Procedure   Store(Var S: TStream);
     Procedure   Draw;Virtual;
     Function    ConvertStr(Eingabe: String):String;Virtual;
     Procedure   SetItem(ATitel: String);Virtual;
   end;

{������������������������������������������������������������������Ŀ
 �Object TDButton                                                   �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      : TButtonobject, welches auch auf die rechte         �
 �               Maustaste reagiert. Generiert das Kommando         �
 �               msMousePressed                                     �
 �Felder       : keine                                              �
 �Neue Methoden: Keine                                              �
 ��������������������������������������������������������������������}
   PDButton = ^TDButton;
   TDButton = Object(TButton)
     Constructor Load(Var S: TStream);
     Procedure   Store(Var S: TStream);
     Procedure   HandleEvent(Var Event: TEvent);Virtual;
   end;

{������������������������������������������������������������������Ŀ
 �Object TProgramChange                                             �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      :  Besetzt einen Programmpunkt neu                   �
 �Felder       :  keine                                             �
 �Neue Methoden:  Keine                                             �
 ��������������������������������������������������������������������}
   PProgramChange = ^TProgramChange;
   TProgramChange = Object(TDialog)
     Constructor Init(Menupunkt: Char; Programmpunkt: Word);
     Constructor Load(Var S: TStream);
     Procedure   Store(Var S: TStream);
   end;

{������������������������������������������������������������������Ŀ
 �Object TScandialog                                                �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      :  Scant die Festplatten und substituierten Laufwerke�
 �                und sucht nach einem File                         �
 �Felder       :  IMessage    : Pfad und Dateiname des Files, das   �
 �                              in der Listbox selektiert ist       �
 �                MListBox    : Listbox, in der die gefundenen Files�
 �                              aufgelistet werden                  �
 �                MCollection : Collection, die mit der Listbox     �
 �                              verbunden ist                       �
 �                IGesucht    : Gesuchter File                      �
 �                LfwBearb    : Momentan bearbeitets Laufwerk       �
 �                ScanOk      : Scannen ist abgeschlossen           �
 �                Neu         : Neue Festplatte / Laufwerk scannen  �
 �                Ende        : Scannen aller Laufwerke beendet     �
 �                GefEintr    : Anzahl der gefundenen Eintr�ge      �
 �Neue Methoden:  Scan        : Routine zum Scannen                 �
 ��������������������������������������������������������������������}
   PScanDialog = ^TScanDialog;
   TScanDialog = Object(TDialog)
     IMessage   : PathStr;          
     MListBox   : PListBox;
     MCollection: PStringCollection; 
     IGesucht   : PathStr;          
     Lfwbearb   : String;        
     ScanOk     : Boolean;          
     Neu,                           
     Ende       : Boolean;          
     GefEintr   : Word;           
     Constructor Init(Gesucht: PathStr);
     Constructor Load(Var S: TStream);
     Procedure   Store(Var S: TStream);
     Destructor  Done;Virtual;
     Procedure   HandleEvent(Var Event: TEvent);virtual;
     Procedure   Scan(Eingabe:PathStr;SuchPfad:PathStr);
     Function    DataSize: Word; Virtual;
     Procedure   GetData(Var Rec);Virtual;
     Procedure   Draw;virtual;
   end;

   {Ein Array, welches 9 Dynamische Anzeigen aufnimmt}
   Anzeige = Array[1..9] of PDynamicText;

{������������������������������������������������������������������Ŀ
 �Object TMenuAuswahl                                               �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      : Linkes Fester zur Anzeige und Auswahl der          �
 �               Programmobergruppen bilden                         �
 �Felder       : Items      :  Anzuzeigende Programmobergruppen     �
 �               Anz        :  9 Dynamische Texte                   �
 �Neue Methoden: ChangeItems:  Die 9 Dynamischen Texte neu ausgeben �
 ��������������������������������������������������������������������}
   PMenuAuswahl = ^TMenuAuswahl;
   TMenuAuswahl = Object(TDialog)
      Items : TAuswahl;
      Anz   : Anzeige;
      Constructor Init;
      Constructor Load(Var S: TStream);
      Procedure   Store(Var S: TStream);
      Procedure   ChangeItems;Virtual;
      Procedure   HandleEvent(Var Event: TEvent);Virtual;
      Function    GetPalette: PPalette;Virtual;
   end;

{������������������������������������������������������������������Ŀ
 �Object TProgrammAuswahl                                           �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      : Rechtes Fester zur Anzeige und Auswahl der         �
 �               Programmpunkte bilden                              �
 �Felder       : Items      :  Anzuzeigende Programmpunkte          �
 �                Anz        :  9 Dynamische Texte                  �
 �Neue Methoden : ChangeItems:  Die 9 Dynamischen Texte neu ausgeben�
 ��������������������������������������������������������������������}
   PProgrammAuswahl = ^TProgrammAuswahl;
   TProgrammAuswahl = Object(TDialog)
      Items  : TProgramm;
      Anz    : Anzeige;
      Titel  : PProgrammTitle;
      Constructor Init;
      Constructor Load(Var S: TStream);
      Procedure   Store(Var S: TStream);
      Procedure   ChangeItems;Virtual;
      Procedure   HandleEvent(Var Event: TEvent);Virtual;
      Function    GetPalette: PPalette;Virtual;
   end;

{������������������������������������������������������������������Ŀ
 �Object TProgBesDlg                                                �
 ������������������������������������������������������������������Ĵ
 �Aufgabe      : Besetzt einen neuen Programmpunkt (Rechtes         �
 �               Fenster), wird mit rechter Maustaste oder          �
 �               ALT - Fxx aufgerufen                               �
 �Felder       : Keine                                              �
 �Neue Methoden: Keine                                              �
 ��������������������������������������������������������������������}
   PProgBesDlg = ^TProgBesDlg;
   TProgBesDlg = Object(TDialog)
     Constructor Init;
     Constructor Load(Var S: TStream);
     Procedure   Store(Var S: TStream);
     Procedure   HandleEvent(Var Event: TEvent);Virtual;
   end;

{������������������������������������������������������������������Ŀ
 �Streamregistrierrecords und -prozedur                             �
 ��������������������������������������������������������������������}
CONST
    RDynamicText     : TStreamRec = (
    ObjType          : 2001;
    VmtLink          : Ofs(TypeOf(TDynamicText)^);
    Load             : @TDynamicText.Load;
    Store            : @TDynamicText.Store
  );
    RProgrammTitle   : TStreamRec = (
    ObjType          : 2002;
    VmtLink          : Ofs(TypeOf(TProgrammTitle)^);
    Load             : @TProgrammTitle.Load;
    Store            : @TProgrammTitle.Store
  );
    RDButton         : TStreamRec = (
    ObjType          : 2003;
    VmtLink          : Ofs(TypeOf(TDButton)^);
    Load             : @TDButton.Load;
    Store            : @TDButton.Store
  );
    RProgramChange   : TStreamRec = (
    ObjType          : 2004;
    VmtLink          : Ofs(TypeOf(TProgramChange)^);
    Load             : @TProgramChange.Load;
    Store            : @TProgramChange.Store
  );
    RScanDialog      : TStreamRec = (
    ObjType          : 2005;
    VmtLink          : Ofs(TypeOf(TScanDialog)^);
    Load             : @TScanDialog.Load;
    Store            : @TScanDialog.Store
  );
    RMenuAuswahl     : TStreamRec = (
    ObjType          : 2006;
    VmtLink          : Ofs(TypeOf(TMenuAuswahl)^);
    Load             : @TMenuAuswahl.Load;
    Store            : @TMenuAuswahl.Store
  );
    RProgrammAuswahl : TStreamRec = (
    ObjType          : 2007;
    VmtLink          : Ofs(TypeOf(TProgrammAuswahl)^);
    Load             : @TProgrammAuswahl.Load;
    Store            : @TProgrammAuswahl.Store
  );
    RProgBesDlg      : TStreamRec = (
    ObjType          : 2008;
    VmtLink          : Ofs(TypeOf(TProgBesDlg)^);
    Load             : @TProgBesDlg.Load;
    Store            : @TProgBesDlg.Store
  );

Procedure RegisterMenuDlg;

{������������������������������������������������������������������Ŀ
 �Functionen zum Aufbau von Dialogboxen                             �
 ��������������������������������������������������������������������}

Function CreateMenuEintragDlg : PDialog;

Function CreateVoreinDlg      : PDialog;

Function CreateColorDlg       : PDialog;

Function CreateHotKeyDlg      : PDialog;

{������������������������������������������������������������������Ŀ
 �Allgemeine Funktionen                                             �
 ��������������������������������������������������������������������}

{������������������������������������������������������������������Ŀ
 �Function DriveValid                                               �
 ������������������������������������������������������������������Ĵ
 �Aufgabe  : �berpr�ft die G�ligkeit eines Laufwerkes               �
 �Eingaben : Drive = Laufwerk (A,B,C..)                             �
 �Ausgabe  : True wenn Laufwerk ansprechbar ist                     �
 ��������������������������������������������������������������������}
Function DriveValid(Drive: Char): Boolean;

{������������������������������������������������������������������Ŀ
 �Function Dunkel                                                   �
 ������������������������������������������������������������������Ĵ
 �Aufgabe  : Mi� die Zeit zwischen Anfang und Ende in Ticks, und    �
 �           entscheidet anhand der eingestellten Dunkelzeit        �
 �           'Eingest' ob der Bildschirm dunkelgeschaltet werden    �
 �           soll                                                   �
 �Eingaben : Anfang und Ende des Zeitabschnittes                    �
 �Ausgabe  : True wenn Bildschirm dunkel geschaltet werden soll     �
 ��������������������������������������������������������������������}
Function Dunkel(Anfang,Ende: LongInt):Boolean;

{������������������������������������������������������������������Ŀ
 �Function MUpCase                                                  �
 ������������������������������������������������������������������Ĵ
 �Aufgabe  : Wandelt einen String in Gro�buchstaben um              �
 �Eingaben : Eing = Zu wandelner String                             �
 �Ausgabe  : Gewandelter String                                     �
 ��������������������������������������������������������������������}
Function MUpcase(Eing:String):String;

IMPLEMENTATION
{������������������������������������������������������������������Ŀ
 �Function DriveValid(Drive: Char): Boolean; Assembler;             �
 ��������������������������������������������������������������������}
Function DriveValid(Drive: Char): Boolean; Assembler;
Asm
	MOV	DL,Drive                            {Laufwerksnummer nach DL}
        MOV	AH,36H                          {Dos-Funktion 36H laden}
        SUB	DL,'A'-1                      {Vom Laufwerk 65 abziehen,
                                             so da�  A = 0, B = 1 ...}
        INT	21H                             {Dos-Interrupt aufrufen}
                    {Dieser Interrupt gibt FFFFh zur�ck, wenn Laufwerk
                                                  nicht vorhanden ist}
        INC	AX                            {Ax erh�hen (FFFFh +1 = 0}
        JE	@@2                         {Wenn 0 dann Funktion false}
@@1:	MOV	AL,1                                             {Sonst true}
@@2:
End;

{������������������������������������������������������������������Ŀ
 �Function Dunkel(Anfang,Ende: LongInt):Boolean;                    �
 ��������������������������������������������������������������������}
Function Dunkel(Anfang,Ende: LongInt):Boolean;
Var
  Zaehler,
  Rest                  : LongInt;
  Stunde,Minute         : Word;
Begin
  Zaehler := Ende-Anfang;
  Stunde := Trunc(Zaehler/65543);
  Rest := Zaehler Mod 65543;
  Minute := Trunc(Rest/1092);
  If (Minute > Eingest-1) then
  Dunkel := true else
  Dunkel := false;
end;

{������������������������������������������������������������������Ŀ
 �Function MUpcase(Eing:String):String;                             �
 ��������������������������������������������������������������������}
Function MUpcase(Eing:String):String;
Var
  Str:String;                             {Zu konvertierbaren String}
  I  :Byte;                                            {Z�hlvariable}
Begin
  Str:='';
  For I:=1 to Length(Eing) do
    Case Eing[I] of
    'a'..'z': Str:=Str+Chr(Ord(Eing[I])-32);
    '�'     : Str:=Str+'�';
    '�'     : Str:=Str+'�';
    '�'     : Str:=Str+'�';
    else Str:=Str+Eing[I];
    end;
  MUpcase:=Str;
end;

{
�������������������������������������������������������������������Ŀ
� Methoden von TDYNAMICTEXT                                         �
���������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TDynamicText.Init;                                    �
 ��������������������������������������������������������������������}
Constructor TDynamicText.Init;
Begin
  Bounds.B.Y := Bounds.A.Y +1;
  TView.Init(Bounds);
  EventMask := EventMask or evBroadCast;
  IText     := AText;
end;

{������������������������������������������������������������������Ŀ
 �Constructor TDynamicText.Load;                                    �
 ��������������������������������������������������������������������}
Constructor TDynamicText.Load;
Begin
  TView.Load(S);
  S.Read(S, SizeOf(PString));
end;

{������������������������������������������������������������������Ŀ
 �Procedure TDynamicText.Store;                                     �
 ��������������������������������������������������������������������}
Procedure TDynamicText.Store;
Begin
  TView.Store(S);
  S.Write(S, SizeOf(PString));
end;

{������������������������������������������������������������������Ŀ
 �Procedure TDynamicText.Draw;                                      �
 ��������������������������������������������������������������������}
Procedure TDynamicText.Draw;
Var
  B       : TDrawBuffer;
  Anf     : Word;
  Color   : Word;
Begin
  MoveChar(B, ' ', GetColor(1), Size.X);
  MoveStr(B,IText,GetColor(1));
  WriteLine(0, 0, Size.X, Size.Y, B);
end;

{������������������������������������������������������������������Ŀ
 �Function TDynamicText.GetPalette;                                 �
 ��������������������������������������������������������������������}
Function TDynamicText.GetPalette;
Const
  P : String[Length(CDynamicText)] = CDynamicText;
Begin
  GetPalette := @P;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TDynamicText.SetIText;                                  �
 ��������������������������������������������������������������������}
Procedure TDynamicText.SetIText;
Begin
   IText := NeuStr;
   DrawView;
end;
{
�������������������������������������������������������������������Ŀ
� Methoden von TPROGRAMMTITLE                                       �
���������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TProgrammTitle.Init;                                  �
 ��������������������������������������������������������������������}
Constructor TProgrammTitle.Init;
Begin
  TView.Init(Bounds);
  Titel := '';
end;

{������������������������������������������������������������������Ŀ
 �Constructor TProgrammTitle.Load;                                  �
 ��������������������������������������������������������������������}
Constructor TProgrammTitle.Load;
Begin
  TView.Load(S);
  S.Read(Titel,   SizeOf(String));
End;

{������������������������������������������������������������������Ŀ
 �Procedure TProgrammTitle.Store;                                   �
 ��������������������������������������������������������������������}
Procedure TProgrammTitle.Store;
Begin
  TView.Store(S);
  S.Write(Titel, SizeOf(String));
end;

{������������������������������������������������������������������Ŀ
 �Procedure TProgrammTitle.Draw;                                    �
 ��������������������������������������������������������������������}
Procedure TProgrammTitle.Draw;
Var
  B: TDrawBuffer;
Begin
  MoveChar(B,'�',GetColor(1),Size.X);
  MoveStr(B,ConvertStr(Titel),GetColor(1));
  WriteBuf(0,0,Size.X,1,B);
end;

{������������������������������������������������������������������Ŀ
 �Function TProgrammTitle.ConvertStr(Eingabe: String):String;       �
 ��������������������������������������������������������������������}
Function TProgrammTitle.ConvertStr(Eingabe: String):String;
Var
  I : Word;
  ch: String;
Begin
  If (Eingabe[1] = '�') then
  Begin
   ch := Eingabe[2];
   Eingabe := Concat('Menupunkt ',Ch);
  end;
  Eingabe := Concat(' ',Eingabe,' ');
  For I := 1 to (Size.X - Length(Eingabe)) DIV 2 do
  Eingabe := Concat('�',Eingabe);
  ConvertStr := Eingabe;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TProgrammTitle.SetItem;                                 �
 ��������������������������������������������������������������������}
Procedure TProgrammTitle.SetItem;
Begin
  Titel := ATitel;
  DrawView;
end;

{
�������������������������������������������������������������������Ŀ
� Methoden von TDBUTTON                                             �
���������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TDButton.Load(Var S: TStream);                        �
 ��������������������������������������������������������������������}
Constructor TDButton.Load(Var S: TStream);
Begin
  TButton.Load(S);
end;

{������������������������������������������������������������������Ŀ
 �Procedure TDButton.Store(Var S: TStream);                         �
 ��������������������������������������������������������������������}
Procedure TDButton.Store(Var S: TStream);
Begin
  TButton.Store(S);
end;

{������������������������������������������������������������������Ŀ
 �Procedure TDButton.HandleEvent;                                   �
 ��������������������������������������������������������������������}
Procedure TDButton.HandleEvent;
Begin
  If (Event.What = evMouseDown) AND
     (Event.Buttons = mbRightButton) then
  Begin
    Message(Application,evCommand,msMousePressed,Title);
    ClearEvent(Event);
  end;
  TButton.HandleEvent(Event);
end;

{
��������������������������������������������������������������������Ŀ
� Methoden von TPROGRAMCHANGE                                        �
����������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TProgramChange.Init;                                  �
 ��������������������������������������������������������������������}
Constructor TProgramChange.Init;
Var
  R     : TRect;
  View  : PView;
  Dialog: PDialog;
  TStr  : String;
  PrgStr: String;
BEGIN
  R.Assign (13,4,73,16);
  TDialog.Init(R,'Programmpunkt besetzen');
  Flags := 5;
  Options := 1091;

  If (ActMenu[Ord(ActMenuSel)-64] = '+++') or
  (ActMenu[Ord(ActMenuSel)-64] = '') then
  Begin
    PrgStr := Concat('Menupunkt ',ActMenuSel)
  end else
  PrgStr := ActMenu[Ord(ActMenuSel)-64];


  R.Assign(3,2,31,3);
  Insert (New (PStaticText, Init (R, 'Aktueller Menupunkt       :')));

  R.Assign(35,2,58,3);
  Insert (New (PStaticText,Init (R,PrgStr)));

  R.Assign(3,3,31,4);
  Insert(New(PStaticText,Init(R,     'Aktueller Programmeintrag :')));
  System.Str(Programmpunkt,TStr);

  R.Assign(35,3,58,4);
  Insert(New(PStaticText,Init(R,Tstr)));
  R.Assign (1,4,59,5);
  Insert (New (PStaticText, Init (R, '����������������������������������������������������������')));

  R.Assign (3, 6, 23, 7);
  View := New (PInputLine, Init (R, 29));
  View^.HelpCtx := hcNoContext;
  Insert (View);
  R.Assign (3, 5, 16, 6);
  Insert (New (PLabel, Init (R, 'Programmtext', View)));
  R.Assign (23, 6, 26, 7);
  Insert (New (PHistory, Init  (R, PInputLine (View), 0)));
 
  R.Assign (30, 6, 50, 7);
  View := New (PInputLine, Init (R, 127));
  View^.HelpCtx := hcNoContext;
  Insert (View);
  R.Assign (30, 5, 45, 6);
  Insert (New (PLabel, Init (R, 'Programmaufruf', View)));
  R.Assign (50, 6, 53, 7);
  Insert(New(PHistory,Init(R,PInputLine(View),100)));

  R.Assign (5,9,13,11);
  View := New(PButton,Init(R,'~O~K',cmOk,bfDefault));
  View^.HelpCtx := hcNoContext;
  Insert(PButton(View));

  R.Assign (16,9,28,11);
  View := New(PButton,Init(R,'~L~oeschen',cmYes,bfNormal));
  View^.HelpCtx := hcNoContext;
  Insert(PButton(View));

  R.Assign (31,9,44,11);
  View := New(PButton,Init(R,'~A~bbruch',cmCancel,bfNormal));
  View^.HelpCtx := hcNoContext;
  Insert(PButton(View));

  Insert(PButton(View));
  SelectNext (FALSE);
END;

{������������������������������������������������������������������Ŀ
 �Constructor TProgramChange.Load;                                  �
 ��������������������������������������������������������������������}
Constructor TProgramChange.Load;
Begin
  TDialog.Load(S);
end;

{������������������������������������������������������������������Ŀ
 �Procedure TProgramChange.Store;                                   �
 ��������������������������������������������������������������������}
Procedure TProgramChange.Store;
Begin
  TDialog.Store(S);
end;
{
�������������������������������������������������������������������Ŀ
� Methoden von TSCANDIALOG                                          �
���������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TScanDialog.Init;                                     �
 ��������������������������������������������������������������������}
Constructor TScanDialog.Init;
Var
  R   : TRect;                          {Ausma�e eines View-Objektes}
  View: PButton;                      {Zeiger auf ein TButton-Objekt}
  Pst : PStaticText;              {Zeiger auf ein TStatictext-Objekt}
  VS  : PScrollBar;                     {Zeiger auf einen Rollbalken}
Begin
                         {Dialog dimensionieren und Fenster zeichnen}
  R.Assign(5,5,75,22);
  TDialog.Init(R,'Festplatte(n) scannen');
  Options := Options or ofCentered;
  Flags   := Flags and not wfmove;
  Flags   := Flags and not wfclose;

                                                   {Initialisierungen}
  IGesucht := Gesucht;
  LfwBearb := '';
  ScanOk   := False;
  Neu := False;
  Ende:= False;
  GefEintr := 0;

                                                    {Buttons einf�gen}
  R.Assign(47,14,58,16);
  View := New(PButton,Init(R,'~C~ancel',cmCancel,bfnormal));
  Insert(View);
  R.Assign(12,14,24,16);
  View := New(PButton,Init(R,'~O~k',cmAkzept,bfDefault));
  Insert(View);

                        {Listbox zeichnen f�r die gefundenen Eintr�ge}
  R.Assign(67,3,68,9);
  VS := New(PScrollBar,Init(R));
  Insert(VS);
  R.Assign(2,3,67,9);
  MListBox := New(PListBox,Init(R,1,VS));
  Insert(MListBox);
                                               {Label f�r die ListBox}
  R.Assign(3,2,67,3);
  Insert(New(PLabel,Init(R,'~G~efundene Eintr�ge',MListBox)));
  {Collection f�r die Eintr�ge erzeugen}
  MCollection := New(PStringCollection,Init(5,3));

                                            {Statische Texte erzeugen}
  R.Assign(2,10,37,11);
  Insert(New(PStaticText,
                Init(R,'Gesuchter File       : '+MUpCase(IGesucht))));
  R.Assign(2,11,30,12);
  PSt :=New(PStaticText,Init(R,'Durchsuchte Laufwerke:'));
  Insert(PStaticText(PSt));
  R.Assign(2,12,30,13);
  PSt :=New(PStaticText,Init(R,'Gefundene Eintr�ge   :'));
  Insert(PStaticText(PSt));

end;

{������������������������������������������������������������������Ŀ
 �Constructor TScanDialog.Load;                                     �
 ��������������������������������������������������������������������}
Constructor TScanDialog.Load;
Begin
  TDialog.Load(S);
  S.Read(IMessage    , SizeOf(PathStr));
  GetSubViewPtr(S, MListBox);           
  S.Read(S, SizeOf(MCollection)); 
  S.Read(IGesucht    , SizeOf(PathStr));          
  S.Read(Lfwbearb    , SizeOf(String));        
  S.Read(ScanOk      , SizeOf(Boolean));          
  S.Read(Neu         , SizeOf(Boolean));                            
  S.Read(Ende        , SizeOf(Boolean));          
  S.Read(GefEintr    , SizeOf(Word));           
end;

{������������������������������������������������������������������Ŀ
 �Procedure TScanDialog.Store;                                      �
 ��������������������������������������������������������������������}
Procedure TScanDialog.Store;
Begin
  TDialog.Store(S);
  S.Write(IMessage    , SizeOf(PathStr));
  PutSubViewPtr(S, MListBox);           
  S.Write(S, SizeOf(MCollection));
  S.Write(IGesucht    , SizeOf(PathStr));
  S.Write(Lfwbearb    , SizeOf(String));
  S.Write(ScanOk      , SizeOf(Boolean));
  S.Write(Neu         , SizeOf(Boolean));
  S.Write(Ende        , SizeOf(Boolean));
  S.Write(GefEintr    , SizeOf(Word));           
end;

{�������������������������������������������������������������������Ŀ
 �PROCEDURE TSCANDIALOG.SCAN                                         �
 �Aufgabe: Durchsucht ein Laufwerk rekursiv nach dem Auftreten       �
 �         des in Eingabe spezifizierten Filenamens (ohne Extension) �
 �Eingabe: Eingabe  = Gesuchter Filename                             �
 �         Suchpfad = Laufwerk (oder Pfad) welches durchsucht werden �
 �         soll                                                      �
 �Ausgabe: Keine                                                    ��
 ��������������������������������������������������������������������}

Procedure TScanDialog.Scan;
Var
  S            : Searchrec;        {Record f�r Findfirst und Findnext}
  Dir          : DirStr;
  Name         : NameStr;
  Ext          : ExtStr;                       {Variablen f�r FSplit}
  Str          : String;                              {Hilfsvariable}
  I            : Word;                                 {Laufvariable}
Begin
                  {Gesuchten File in Gro�buchstaben umwandeln, da DOS
                             nur Gro�buchstaben kennt und zur�ckgibt}
  IGesucht := MUpCase(IGesucht);

                                          {Den ersten Eintrag suchen}
  FindFirst(SuchPfad+'\*.*',AnyFile,s);
  While (DosError = 0)  do
  begin
                                   {Unerw�nschte Eintr�ge ausfiltern}
    If (s.name <> '.') and
       (s.name <> '..') and
       ((S.attr and VolumeId) <> VolumeId) then
    begin
                           {Wenn Dir gefunden, dann rekursiver Aufruf}
     if (s.attr and Directory) = Directory then
     Scan(eingabe,Suchpfad+'\'+s.name)
     else
     begin
                              {Ist gefundener File COM, EXE oder BAT?}
       FSplit(s.name,dir,name,ext);
       if (name = IGesucht) and
       ((ext = '.COM') or (ext = '.EXE') or (ext = '.BAT')) then
       Begin
         Str := Suchpfad+'\'+Name+Ext;
                                      {Eintrag in Collection einf�gen}
         Gef  := NewStr(Str);
         MCollection^.Insert(Gef);
                                          {Gefundene Eintr�ge erh�hen}
         Inc(GefEintr);
                         {Dialog samt Subviews (Listbox) neu ausgeben}
         DrawView;

                        {Wenn das erste Mal ein Eintrag gefunden wurde
                            dann Collection mit der Listbox verbinden}
         If not Neu then
         Begin
          MListBox^.NewList(MCollection);
          Neu := True;
         end;
                     {Rollbalkeninformationen f�r die Listbox updaten}
         MListBox^.VScrollbar^.SetRange(0,(MListBox^.Range));
         MListBox^.VScrollbar^.SetValue(1);
         MListBox^.VScrollbar^.SetStep(1,1);
         MListBox^.Range := MCollection^.Count;
         MListBox^.DrawView;
       end;
      end;
     end;
                                       {Einen weiteren Eintrag suchen}
  FindNext(s);
  end;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TScanDialog.HandleEvent;                                �
 ��������������������������������������������������������������������}
Procedure TScanDialog.HandleEvent;
Var
  P : PView;    {Zeiger auf ein View-Objekt       }
  Ch: Char;     {Zeichen f�r die Laufwerkskennung }
Begin
  TDialog.HandleEvent(Event);;
  if Event.What = evCommand then
  begin
    case Event.Command of
      cmBearbeiten: Begin
                      For Ch := 'C' to 'Z' do
                      If DriveValid(ch) then
                      Begin
                       LfwBearb := LfwBearb+Ch+': ';
                       DrawView;
                       Scan(IGesucht,Ch+':');
                      end;
                      Ende := True;
                      DrawView;
                    end;
       cmAkzept    : Begin
                      IMessage := MListbox^.GetText(MListbox^.Focused,
                                  10);
                      {Dialog eigenst�ndig beenden}
                      message(@self,EvCommand,cmOK,NIL);
                     end;
      else Exit;
    end;{Case}
    ClearEvent(Event);
  end;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TScanDialog.Draw;                                       �
 ��������������������������������������������������������������������}
Procedure TScanDialog.Draw;
Var
  P   : PView;
  R   : TRect;
  B   : TDrawBuffer;
  TStr: String;
Begin
             {Wenn Viewobject sichtbar ist dann TDialog.Draw aufrufen}
  If Exposed and Not ScanOk then
  TDialog.Draw;
                                           {Dynamische Texte erzeugen}
  MoveChar(B,' ',GetColor(6),5);
  MoveStr(B,LfwBearb,GetColor(6));
  WriteBuf(25,11,5,1,B);
  System.Str(GefEintr,TStr);
  MoveChar(B,' ',GetColor(6),5);
  MoveStr(B,TStr,GetColor(6));
  WriteBuf(25,12,5,1,B);
                                                 {Endtexte darstellen}
  If Ende then 
  Begin
   Ende := False;
   MoveChar(B,' ',GetColor(6),30);
   MoveStr(B,'Scannen Beendet !!!',GetColor(6));
   WriteBuf(38,10,30,1,B);
   MoveChar(B,' ',GetColor(6),30);
   MoveStr(B,'File Ausw�hlen !!!',GetColor(6));
   WriteBuf(38,11,30,1,B);
  end;
                             {Wenn Dialog dargestellt worden ist, dann
                                   das Scannen automatisch  einleiten}
  If Exposed and Not ScanOk then
  Begin
     ScanOk := True;
     Message(@self,EvCommand,cmBearbeiten,NIL);
    end;
end;

{������������������������������������������������������������������Ŀ
 �Function TScanDialog.DataSize;                                    �
 ��������������������������������������������������������������������}
Function TScanDialog.DataSize;
Begin
  DataSize := Sizeof(PathStr);
end;

{������������������������������������������������������������������Ŀ
 �Procedure TScanDialog.GetData;                                    �
 ��������������������������������������������������������������������}
Procedure TScanDialog.GetData;
Begin
  PathStr(Rec) := IMessage;
end;

{������������������������������������������������������������������Ŀ
 �Destructor TScanDialog.Done;                                      �
 ��������������������������������������������������������������������}
Destructor TScanDialog.Done;
Begin
  Dispose(MCollection,Done);
  Dispose(MListBox,Done);
  TDialog.Done;
end;

{
��������������������������������������������������������������������Ŀ
� Methoden von TMENUAUSWAHL                                          �
����������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TMenuAuswahl.Init;                                    �
 ��������������������������������������������������������������������}
Constructor TMenuAuswahl.Init;
Var
  R : TRect;      {Ausma�e eines View-Objektes}
  I : Word;       {Lokale Laufvariable        }
  B : PButton;
Const
  Inhalt : ARRAY[1..9] of Char = ('A','B','C','D',
                                   'E','F','G','H','I');
Begin
  DeskTop^.GetExtent(R);
  R.B.X := 35;
  TDialog.Init(R,'Menuauswahl');
  Flags    := 0;
  For I := 1 to 9 do
  Begin
    R.Assign(3,(I*2),13,I*2+2);
    B := New(PDButton,Init(R,Inhalt[I],cmMenuAuswahl[I],bfNormal));
    B^.Options := B^.Options and not ofSelectable;
    Insert(B);
  end;
  For I := 1 to 9 do
  Begin
   R.Assign(15,I*2,34,I*2+1);
   Anz[I] := New(PDynamicText,Init(R,' '));
   Insert(Anz[I]);
  end;
end;

{������������������������������������������������������������������Ŀ
 �Constructor TMenuAuswahl.Load;                                    �
 ��������������������������������������������������������������������}
Constructor TMenuAuswahl.Load;
Begin
  TDialog.Load(S);
  S.Read(Items, SizeOf(TAuswahl));
  S.Read(S, SizeOf(Anzeige));
end;

{������������������������������������������������������������������Ŀ
 �Procedure TMenuAuswahl.Store;                                     �
 ��������������������������������������������������������������������}
Procedure TMenuAuswahl.Store;
Begin
  TDialog.Load(S);
  S.Write(Items, SizeOf(TAuswahl));
  S.Write(S, SizeOf(Anzeige));
end;

{������������������������������������������������������������������Ŀ
 �Procedure TMenuAuswahl.ChangeItems;                               �
 ��������������������������������������������������������������������}
Procedure TMenuAuswahl.ChangeItems;
Var
  I     : Word;
  Temp  : String;
Begin
  For I := 1 to 9 do
  Begin
    Temp := ActMenu[I];
    Anz[I]^.SetIText(Temp);
    {Message(Anz[I],evBroadCast, cmDynChanged, @Temp);}
  end;
end;

{������������������������������������������������������������������Ŀ
 �Function TMenuAuswahl.GetPalette: PPalette;                       �
 ��������������������������������������������������������������������}
Function TMenuAuswahl.GetPalette: PPalette;
Const
   NewColor = #64#33#34#35#36#65#38#39#40#66#42#68#44#45#67#47#48#49+
              #50#51#52#53#54#55#56#57#58#59#60#61#62#63;
   P : String[Length(NewColor)] = NewColor;
Begin
  GetPalette := @P;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TMenuAuswahl.HandleEvent(Var Event: TEvent);            �
 ��������������������������������������������������������������������}
Procedure TMenuAuswahl.HandleEvent(Var Event: TEvent);
Begin
  TDialog.HandleEvent(Event);
  If Event.What = evBroadCast then
  Begin
     Case Event.Command of
     msMenuChanged: ChangeItems;
     else Exit;
     end;
     ClearEvent(Event);
  end;
end;

{
�������������������������������������������������������������������Ŀ
� Methoden von TPROGRAMMAUSWAHL                                     �
���������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TProgrammAuswahl.Init;                                �
 ��������������������������������������������������������������������}
Constructor TProgrammAuswahl.Init;
Var
  R : TRect;                            {Ausma�e eines View-Objektes}
  I : Word;                                     {Lokale Laufvariable}
  B : PButton;
CONST
  Inhalt : ARRAY[1..9] of Char = ('1','2','3','4','5','6','7','8','9');

Begin
  DeskTop^.GetExtent(R);
  R.A.X := 35;
  TDialog.Init(R,'Programmauswahl');
  Flags    := 0;
  For I := 1 to 9 do
  Begin
    R.Assign(3,(I*2),13,I*2+2);
    B := New(PDButton,Init(R,Inhalt[I],cmMenuSelect[I],bfNormal));
    B^.Options := B^.Options and not ofSelectable;
    Insert(B);
  end;
    For I := 1 to 9 do
    Begin
     R.Assign(15,I*2,44,I*2+1);
     Anz[I] := New(PDynamicText,Init(R,' '));
     Insert(Anz[I]);
  end;
  R.Assign(1,0,44,1);
  Titel := New(PProgrammTitle,Init(R));
  Insert(Titel);
end;

{������������������������������������������������������������������Ŀ
 �Constructor TProgrammAuswahl.Load;                                �
 ��������������������������������������������������������������������}
Constructor TProgrammAuswahl.Load;
Begin
  TDialog.Load(S);
  S.Read(Items, SizeOf(TAuswahl));
  S.Read(S, SizeOf(Anzeige));
end;

{������������������������������������������������������������������Ŀ
 �Procedure TProgrammAuswahl.Store;                                 �
 ��������������������������������������������������������������������}
Procedure TProgrammAuswahl.Store;
Begin
  TDialog.Load(S);
  S.Write(Items, SizeOf(TAuswahl));
  S.Write(S, SizeOf(Anzeige));
end;


{������������������������������������������������������������������Ŀ
 �Function TProgrammAuswahl.GetPalette: PPalette;                   �
 ��������������������������������������������������������������������}
Function TProgrammAuswahl.GetPalette: PPalette;
Const
   NewColor = #69#33#34#35#36#70#38#39#40#71#42#73#44#45#72#47#48#49+
              #50#51#52#53#54#55#56#57#58#59#60#61#62#63;
   P : String[Length(NewColor)] = NewColor;
Begin
  GetPalette := @P;
end;

{������������������������������������������������������������������Ŀ
 �Procedure TProgrammAuswahl.ChangeItems;                           �
 ��������������������������������������������������������������������}
Procedure TProgrammAuswahl.ChangeItems;
Var
  I   : Word;
  D   : PDialog;
  Temp: String;
Begin
  For I := 1 to 9 do
  Begin
    Temp := ActProgramm[Ord(ActMenuSel)-64][I];
    Anz[I]^.SetIText(Temp);
    {Message(Anz[I],evBroadCast, cmDynChanged,@Temp);}
  end;
end;


{������������������������������������������������������������������Ŀ
 �Procedure TProgrammAuswahl.HandleEvent(Var Event: TEvent);        �
 ��������������������������������������������������������������������}
Procedure TProgrammAuswahl.HandleEvent(Var Event: TEvent);
Var
  MStr : PString;
Begin
  TDialog.HandleEvent(Event);
  If Event.What = evBroadCast then
  Begin
    Case Event.Command of
    msTextChanged   : ChangeItems;
    end;
    ClearEvent(Event);
  end;
end;
{
��������������������������������������������������������������������Ŀ
� Methoden von TPROGBESDLG                                           �
����������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Constructor TProgBesDlg.Init;                                     �
 ��������������������������������������������������������������������}
Constructor TProgBesDlg.Init;
Var
  R    : TRect;                          {Ausma�e eines View-Objectes}
  V    : PView;                          {Zeiger auf ein TView-Object}
  AMenu: String;                {String f�r den aktuellen Menueintrag}
  I    : Word;                                          {Laufvariable}
Begin
  If (ActMenu[Ord(ActMenuSel)-64] = '+++') or
     (ActMenu[Ord(ActMenuSel)-64] = '') then
  AMenu := Concat('Programmpunkt ',ActMenuSel) else
  AMenu := ActMenu[Ord(ActMenuSel)-64];

  R.Assign(0,0,50,10);
  TDialog.Init(R,'Programmpunkt besetzen');
  I := 1;
  Options := Options or ofCentered;
  R.Assign(5,1,45,2);
  Insert(New(PStatictext,Init(R,'Aktuelles Menu  '+AMenu)));
  R.Assign(5,3,15,5);
  V := New(PButton,Init(R,'1',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(20,3,30,5);
  V := New(PButton,Init(R,'2',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(35,3,45,5);
  V := New(PButton,Init(R,'3',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(5,5,15,7);
  V := New(PButton,Init(R,'4',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(20,5,30,7);
  V := New(PButton,Init(R,'5',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(35,5,45,7);
  V := New(PButton,Init(R,'6',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(5,7,15,9);
  V := New(PButton,Init(R,'7',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(20,7,30,9);
  V := New(PButton,Init(R,'8',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  R.Assign(35,7,45,9);
  V := New(PButton,Init(R,'9',cmProgBesA[I],bfNormal));
  V^.HelpCtx := hcNoContext;
  Insert(PButton(V));
  inc(I);
  SelectNext(False);
end;

{������������������������������������������������������������������Ŀ
 �Constructor TProgBesDlg.Load;                                     �
 ��������������������������������������������������������������������}
Constructor TProgBesDlg.Load;
Begin
   TDialog.Load(S);
end;

{������������������������������������������������������������������Ŀ
 �Procedure TProgBesDlg.Store;                                      �
 ��������������������������������������������������������������������}
Procedure TProgBesDlg.Store;
Begin
  TDialog.Store(S);
end;

{������������������������������������������������������������������Ŀ
 �Procedure TProgBesDlg.HandleEvent;                                �
 ��������������������������������������������������������������������}
Procedure TProgBesDlg.HandleEvent;
Begin
  TDialog.HandleEvent(Event);
  If (Event.What = evCommand) and
     (Event.Command in [151..159]) then
  Begin
    EndModal(Event.Command);
    ClearEvent(Event);
  end;
end;
{
��������������������������������������������������������������������Ŀ
� Dialogerstellungsfunktionen                                        �
����������������������������������������������������������������������}
{������������������������������������������������������������������Ŀ
 �Function CreateMenuEintragDlg : PDialog;                          �
 ��������������������������������������������������������������������}
Function CreateMenuEintragDlg : PDialog;
VAR
  R      : TRect;
  View   : PView;
  Dialog : PDialog;
BEGIN
  R.Assign (0, 2, 80, 17);
  Dialog := New (PDialog, Init (R, 'Menueintragungen'));
  Dialog^.Options := Dialog^.Options or ofCentered;

  R.Assign (2, 3, 27, 4);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (2, 2, 19, 3);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~A~', View)));

  R.Assign (28, 3, 53, 4);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (28, 2, 45, 3);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~B~', View)));

  R.Assign (54, 3, 79, 4);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (54, 2, 71, 3);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~C~', View)));

  R.Assign (2, 6, 27, 7);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (2, 5, 19, 6);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~D~', View)));

  R.Assign (28, 6, 53, 7);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (28, 5, 45, 6);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~E~', View)));

  R.Assign (54, 6, 79, 7);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (54, 5, 71, 6);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~F~', View)));

  R.Assign (2, 9, 27, 10);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (2, 8, 19, 9);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~G~', View)));

  R.Assign (28, 9, 53, 10);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (28, 8, 45, 9);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~H~', View)));

  R.Assign (54, 9, 79, 10);
  View := New (PInputLine, Init (R, 19));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (54, 8, 71, 9);
  Dialog^.Insert (New (PLabel, Init (R, 'Menueintrag ~I~', View)));

  R.Assign(20,12,30,14);
  View := New(PButton,Init(R,'O~K~',cmOK,bfDefault));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert(PButton(View));

  R.Assign(50,12,65,14);
  View := New(PButton,Init(R,'Abbruch',cmCancel,bfNormal));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert(PButton(View));

  Dialog^.SelectNext (FALSE);
  CreateMenuEintragDlg := Dialog;
END;

{������������������������������������������������������������������Ŀ
 �Function CreateVoreinDlg : PDialog;                               �
 ��������������������������������������������������������������������}
Function CreateVoreinDlg : PDialog;
VAR
   R     : TRect;
   View  : PView;
   Dialog: PDialog;
Begin
  R.Assign (0,0,40,9);
  Dialog := New (PDialog, Init (R, 'Voreinstellungen'));
  Dialog^.Options := Dialog^.Options or ofCentered;
  R.Assign (3,3,21,6);
  View := New(PRadioButtons, Init (R,
             NewSItem ('~2~ Minuten',
             NewSItem ('~5~ Minuten',
             NewSItem ('~1~0 Minuten',
             NIL)))));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert (View);
  R.Assign (3,2,21,3);
  Dialog^.Insert(New(PLabel,Init(R,'Bildschirmschoner', View)));
  R.Assign (23, 2, 35, 4);
  View := New(pButton, Init(R, '~O~K',cmOk,bfDefault));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert(PButton(View));
  R.Assign (23, 4, 35, 6);
  View := New(pButton, Init(R, '~A~bbruch',cmCancel,bfNormal));
  View^.HelpCtx := hcNoContext;
  Dialog^.Insert(PButton(View));
  Dialog^.Insert(PButton(View));
  Dialog^.SelectNext (False);
  CreateVoreinDlg := Dialog;
END;

{������������������������������������������������������������������Ŀ
 �Function CreateColorDlg;                                          �
 ��������������������������������������������������������������������}
Function CreateColorDlg;
Var
  D: PDialog;
Begin
  D := New(PColorDialog, Init('',
         ColorGroup('Menue',
         ColorItem('Vorder/Hintergr.',    2,
         ColorItem('Tastenk�rzel',        4,
         ColorItem('Selektiert',          5,
         ColorItem('K�rzel selektiert',   7, NIL)))),
         ColorGroup('Dialog',
         ColorItem('Rahmen/Hintergrund', 33,
         ColorItem('Rahmen-Icon',        34,
         ColorItem('Rollbalken',         35,
         ColorItem('Rollbalkenpfeile',   36,
         ColorItem('Statischer Text',    37,
         ColorItem('Label normal',       38,
         ColorItem('Label selektiert',   39,
         ColorItem('Label K�rzel',       40,
         ColorItem('Button normal',      41,
         ColorItem('Button default',     42,
         ColorItem('Button selektiert',  43,
         ColorItem('Button inaktiv',     44,
         ColorItem('Button K�rzel',      45,
         ColorItem('Button Schatten',    46,
         ColorItem('Cluster Normal',     47,
         ColorItem('Cluster selektiert', 48,
         ColorItem('Cluster K�rzel',     49,
         ColorItem('Eingabe normal',     50,
         ColorItem('Eingabe selektiert', 51,
         ColorItem('Eingabepfeil',       52,
         ColorItem('History button',     53,
         ColorItem('History Seiten',     54,
         ColorItem('History bar Seite',  55,
         ColorItem('History bar icons',  56,
         ColorItem('Liste normal',       57,
         ColorItem('Listeintrag normal', 57,
         ColorItem('Liste Focussiert',   58,
         ColorItem('Liste Selektiert',   59,
                    NIL)))))))))))))))))))))))))))),
         ColorGroup('Menuauswahl',
         ColorItem('Rahmen/Hintergrund', 64,
         ColorItem('Statischer Text',    65,
         ColorItem('Button normal',      66,
         ColorItem('Button Schatten',    67,
         ColorItem('Button Selektiert',  68,
         NIL))))),

         ColorGroup('Programm',
         ColorItem('Rahmen/Hintergrund', 69,
         ColorItem('Statischer Text',    70,
         ColorItem('Button normal',      71,
         ColorItem('Button Schatten',    72,
         ColorItem('Button Selektiert',  73,
         NIL))))),
 NIL))))));
 CreateColorDlg := D;
end;

{������������������������������������������������������������������Ŀ
 �Function CreateHotKeyDlg: PDialog;                                �
 ��������������������������������������������������������������������}
Function CreateHotKeyDlg: PDialog;
Var
  R   : Trect;
  D   : PDialog;
  View: PButton;
Begin
  R.Assign(0,0,61,12);
  D := New(PDialog,Init(R,'Hotkeys'));
  With D^ do Begin
    Options := Options or OfCentered;
    R.Assign(2,2,59,3);
    Insert(New(PStaticText,Init(R,
      'HotKeys des Menusystems                                    ')));
    R.Assign(2,3,59,4);
    Insert(New(PStaticText,Init(R,
      '                               F2 Einstellungen speichern')));
    R.Assign(2,4,59,5);
    Insert(New(PStaticText,Init(R,
      'F3   Menueintragungen          F4 Hotkeybelegung            ')));
    R.Assign(2,5,59,6);
    Insert(New(PStaticText,Init(R,
      'F5   Menueintragungen l�schen  F6 Programmbelegungen l�schen')));
    R.Assign(2,6,59,7);
    Insert(New(PStaticText,Init(R,
      'F7   Farben ver�ndern          F8 Voreinstellungen �ndern   ')));
    R.Assign(2,7,59,8);
    Insert(New(PStaticText,Init(R,
      'ALT-<F-Taste X> Programmpunkt X besetzen')));
    R.Assign(25,9,35,11);
    View := New(PButton,Init(R,'O~K~',cmOk,bfDefault));
    Insert(View);
  end;
  CreateHotKeyDlg := D;
end;

{������������������������������������������������������������������Ŀ
 �Procedure RegisterMenuDlg;                                        �
 ��������������������������������������������������������������������}
Procedure RegisterMenuDlg;
Begin
  RegisterType(RDynamicText);
  RegisterType(RProgrammTitle);
  RegisterType(RDButton);
  RegisterType(RProgramChange);
  RegisterType(RScanDialog);
  RegisterType(RMenuAuswahl);
  RegisterType(RProgrammAuswahl);
  RegisterType(RProgBesDlg);
end;

END.
