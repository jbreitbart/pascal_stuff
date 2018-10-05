{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                        Turbo Vision-Unit                         �
 �                 Autor: Reiner Sch�lles, 05.11.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Unit f�r eigene Turbo Vision-Applikationen und _Quelle.pas.      �
 ������������������������������������������������������������������ͼ}
Unit _TVTools;
{$X+}                                              {Erweiterte Syntax}

{������������������������������������������������������������������ͻ
 � Interface (�ffentlicher Teil)                                    �
 ������������������������������������������������������������������ͼ}
Interface
uses {�����������������������������������Einzubindende Bibliotheken��}
  Crt,Dos,App,MsgBox,StdDlg,Dialogs,
  Objects,Views,Drivers,Memory,               {Units aus Turbo Pascal}
  _Tools;                                                {Eigene Unit}

type {��������������������������Verzeichnis der globalen Datentypen��}

  {���������������������������������������������������_TXStaticText��}
  { Vereinbart einen Nachfolger von TStaticText mit einer neuen Farb-}
  { palette. Der statische Text wird auf blauem Hintergrund darge-   }
  { stellt.                                                          }
  {������������������������������������������������������������������}
  _PXStaticText = ^_TXStaticText;
  _TXStaticText = object (TStaticText)
    function GetPalette: PPalette; virtual;
  end;

  {�������������������������������������������������_TXInputLineInt��}
  { Vereinbart einen Nachfolger von TInputLine mit der Einschr�nkung,}
  { da� bei der Eingabe nur ganze Zahlen akzeptiert werden, falsche  }
  { werden zur�ckgewiesen. Min und Max geben die Grenzen der einzu-  }
  { gebenden Zahl, aus dem Bereich der ganzen Zahlen, an. AMaxLen    }
  { bezeichnet die maximale L�nge der Eingabezeile.                  }
  {������������������������������������������������������������������}
  _PXInputLineInt = ^_TXInputLineInt;
  _TXInputLineInt = object (TInputLine)
    Min,Max: integer;
    constructor Init(R: TRect; AMin,AMax,AMaxLen: integer);
    procedure HandleEvent(var Event: TEvent); virtual;
    function Valid(Command: word): boolean; virtual;
  end;

  {������������������������������������������������_TXInputLineReal��}
  { Vereinbart einen Nachfolger von TInputLine mit der Einschr�nkung,}
  { da� bei der Eingabe nur Realzahlen akzeptiert werden, falsche    }
  { Eingaben werden zur�ckgewiesen. Min und Max geben die Grenzen    }
  { der einzugebenden Zahl, aus dem Bereich der Dezimalzahlen, an.   }
  { MaxLen bezeichnet die maximale L�nge der Eingabezeile.           }
  {������������������������������������������������������������������}
  _PXInputLineReal = ^_TXInputLineReal;
  _TXInputLineReal = object (TInputLine)
    Min,Max: real;
    constructor Init(R: TRect; AMin,AMax: real;AMaxLen: integer);
    procedure HandleEvent(var Event: TEvent); virtual;
    function Valid(Command: word): boolean; virtual;
  end;

  {�������������������������������Verzeichnis der globalen Routinen��}

  procedure _TVFehlerMldRAM;

  procedure _TVInfoRect(x,y: byte; Header,Msg: string);
  procedure _TVInfoBox(Msg: string);

  procedure _TVFehlerBox(Msg: string);

  function _TVFrageRect(x,y: byte; Frage: string): boolean;
  function _TVFrageBox(Frage: string): boolean;

  function _TVRealBox(Min,Max: real; Nach: byte;
                      AHeader,ALabel: string;
                      StartValue: real;
                      var Erg: word): real;

  function _TVIntegerBox(Min,Max: integer;
                         AHeader,ALabel: string;
                         StartValue: integer;
                         var Erg: word): integer;

  procedure _TVInitYesNo(var R: TRect; D: PDialog);
  procedure _TVInitOkCancel(var R: TRect; D: PDialog);
  procedure _TVInitOk(var R: TRect; D: PDialog);

{������������������������������������������������������������������ͻ
 � Implementation (Nicht-�ffentlicher Teil)                         �
 ������������������������������������������������������������������ͼ}
Implementation

{������������������������������������������������������������������ͻ
 � Implementierung der Methoden von _TXStaticText                   �
 ������������������������������������������������������������������ͼ}

{������������������������������������������������������������������Ŀ
 � _TXStaticText.GetPalette                                         �
 ������������������������������������������������������������������Ĵ
 � Redefiniert die Farbpalette des _TXStaticText-Objekts.           �
 ��������������������������������������������������������������������}
function _TXStaticText.GetPalette: PPalette;
const
  C = #8;                     {Neuer Farbpaletten-Verweis, Farbe Blau}
  P: String[Length(C)] = C;

begin
  GetPalette:= @P;
end;

{������������������������������������������������������������������ͻ
 � Implementierung der Methoden von _TXInputLineInt                 �
 ������������������������������������������������������������������ͼ}

{������������������������������������������������������������������Ŀ
 � _TXInputLineInt.Init                                             �
 ������������������������������������������������������������������Ĵ
 � Initialisiert die Datenfelder des Objekts.                       �
 ��������������������������������������������������������������������}
constructor _TXInputLineInt.Init(R: TRect;
                                 AMin,AMax,AMaxLen: integer);
begin
  TInputLine.Init(R,AMaxLen);
  Min:= AMin;
  Max:= AMax;
end;
{������������������������������������������������������������������Ŀ
 � _TXInputLineInt.HandleEvent                                      �
 ������������������������������������������������������������������Ĵ
 � Schr�nkt die Eingabe in ein Eingabefeld auf den Datentyp Integer �
 � (Ganze Zahl) ein.                                                �
 ��������������������������������������������������������������������}
procedure _TXInputLineInt.HandleEvent(var Event: TEvent);
const
  WrongChars: set of char = [#32..#42,#44,#46..#47,#58..#255];

begin
  if (Event.What <> evKeyDown) or not
     (Event.Charcode in WrongChars)
   then TInputLine.HandleEvent(Event)
   else begin
          _SignalTon;
          ClearEvent(Event);
        end;
end;
{������������������������������������������������������������������Ŀ
 � _TXInputLineInt.Valid                                            �
 ������������������������������������������������������������������Ĵ
 � Pr�ft die G�ltigkeit der Eingabe und gibt bei Bedarf eine Fehler-�
 � meldung aus.                                                     �
 ��������������������������������������������������������������������}
function _TXInputLineInt.Valid(Command: word): boolean;
var
  s: string;                                             {Datenstring}
  Zahl: integer;                                   {Umgewandelte Zahl}
  Code: integer;                                  {Fehlercode von Val}
  Ok: boolean;                                         {Ob Eingabe Ok}

begin
  Ok:= true;                                  {Angenommen, Eingabe Ok}
  Select;
  SelectAll(True);
  if (Command <> cmCancel) and (Data <> nil) then

  begin {����������������������������������Auf g�ltigen Wert pr�fen��}
    s:= Data^;
    Val(s,Zahl,Code);                          {Umwandlung in Integer}
    if Code = 0

    then begin {�������������������������������������Grenzen pr�fen��}
           if (Zahl >= Min) and (Zahl <= Max)
            then Ok:= true
            else Ok:= false;
         end
    else Ok:= false;
  end

  else Ok:= false;
  if Ok then Valid:= TInputLine.Valid(Command)
        else Valid:= false;

  if not Ok {���������������������Wenn fehlerhafte Eingabe vorliegt��}
   then _TVFehlerBox(#13'Eingabe entspricht keinem ' +
           'g�ltigen numerischen Wert oder liegt au�erhalb ' +
           'der Grenzen!');
end;

{������������������������������������������������������������������ͻ
 � Implementierung der Methoden von _TXInputLineReal                �
 ������������������������������������������������������������������ͼ}

{������������������������������������������������������������������Ŀ
 � _TXInputLineReal.Init                                            �
 ������������������������������������������������������������������Ĵ
 � Initialisiert die Datenfelder des Objekts.                       �
 ��������������������������������������������������������������������}
constructor _TXInputLineReal.Init(R: TRect; AMin,AMax: real;
                                  AMaxLen: integer);

begin
  TInputLine.Init(R,AMaxLen);
  Min:= AMin;
  Max:= AMax;
end;
{������������������������������������������������������������������Ŀ
 � _TXInputLineReal.HandleEvent                                     �
 ������������������������������������������������������������������Ĵ
 � Schr�nkt die Eingabe in ein Eingabefeld auf den Datentyp Real    �
 � (Dezimalzahlen) ein.                                             �
 ��������������������������������������������������������������������}
procedure _TXInputLineReal.HandleEvent(var Event: TEvent);
const
  WrongChars: set of char = [#32..#42,#47,#58..#255];

begin
  if (Event.What <> evKeyDown) or not
     (Event.Charcode in WrongChars)
   then TInputLine.HandleEvent(Event)
   else begin
          _SignalTon;
          ClearEvent(Event);
        end;
end;
{������������������������������������������������������������������Ŀ
 � _TXInputLineReal.Valid                                           �
 ������������������������������������������������������������������Ĵ
 � Pr�ft die G�ltigkeit der Eingabe und gibt bei Bedarf eine Fehler-�
 � meldung aus.                                                     �
 ��������������������������������������������������������������������}
function _TXInputLineReal.Valid(Command: word): boolean;
var
  s: string;                                             {Datenstring}
  i: integer;                                           {Z�hlvariable}
  Zahl: real;                                      {Umgewandelte Zahl}
  Code: integer;                                  {Fehlercode von Val}
  Ok: boolean;                                         {Ob Eingabe Ok}

begin
  Ok:= true;                                  {Angenommen, Eingabe Ok}
  Select;
  SelectAll(True);
  if (Command <> cmCancel) and (Data <> nil) then

  begin {����������������������������������Auf g�ltigen Wert pr�fen��}
    s:= Data^;
    for i:= 1 to Length(s) do
     if s[i] = ',' then s[i]:= '.';
    Val(s,Zahl,Code);                             {Umwandlung in Real}
    if Code = 0
    then begin {�������������������������������������Grenzen pr�fen��}
           if (Zahl >= Min) and (Zahl <= Max)
            then Ok:= true
            else Ok:= false;
         end
    else Ok:= false;
  end

  else Ok:= false;
  if Ok then Valid:= TInputLine.Valid(Command)
        else Valid:= false;

  if not Ok {���������������������Wenn fehlerhafte Eingabe vorliegt��}
   then _TVFehlerBox(#13'Eingabe entspricht keinem ' +
           'g�ltigen numerischen Wert oder liegt au�erhalb ' +
           'der Grenzen!');
end;
{������������������������������������������������������������������ͻ
 � _TVFehlerMldRAM                                                  �
 ������������������������������������������������������������������Ķ
 � Gibt in einer Fehlerbox die Meldung aus, da� der Arbeitsspeicher �
 � f�r die durchgef�hrte Operation nicht ausreicht. Kann im Zusam-  �
 � menhang mit LowMemory benutzt werden, wenn auf OutOfMemory kein  �
 � Zugriff besteht.                                                 �
 ������������������������������������������������������������������ͼ}
procedure _TVFehlerMldRAM;
begin
  _TVFehlerBox(#13 + 'Arbeitsspeicher reicht f�r durch' +
               'gef�hrte Operation nicht aus!');
end;
{������������������������������������������������������������������ͻ
 � _TVInfoRect                                                      �
 ������������������������������������������������������������������Ķ
 � Gibt eine Info-Dialogbox mit einem OK-Schalter auf dem Bildschirm�
 � aus. X und Y geben die Breite und die H�he der Box, Header den   �
 � Text in der Umrandung und Msg die auszugebende Meldung an.       �
 ������������������������������������������������������������������ͼ}
procedure _TVInfoRect(x,y: byte; Header,Msg: string);
var
  D: PDialog;                                           {Dialogobjekt}
  R,R1: TRect;                                  {Rechteckiger Bereich}

begin
  R.Assign(0,0,x,y);
  R1:= R;                                               {F�r Schalter}
  D:= New(PDialog,Init(R,Header));
  with D^ do
  begin
    Options:= Options or ofCentered;
    R.Grow(-2,-1);
    Dec(R.B.Y,3);
    Insert(New(PStaticText,Init(R,Msg)));
    _TVInitOk(R1,D);                                     {OK-Schalter}
  end;
  Desktop^.ExecView(D);
  Dispose(D,Done);
end;
{������������������������������������������������������������������ͻ
 � _TVInfoBox                                                       �
 ������������������������������������������������������������������Ķ
 � Gibt eine Info-Dialogbox mit einem OK-Schalter in der Standard-  �
 � gr��e 40 x 11 auf dem Bildschirm aus. Msg gibt die auszugebende  �
 � Meldung an. Als Standard-Text in der Umrandung wird "Information"�
 � ausgegeben. Maximal sind 6 Zeilen Text m�glich.                  �
 ������������������������������������������������������������������ͼ}
procedure _TVInfoBox(Msg: string);
begin
  _TVInfoRect(40,11,'Information',Msg);
end;
{������������������������������������������������������������������ͻ
 � _TVFehlerBox                                                     �
 ������������������������������������������������������������������Ķ
 � Gibt eine Fehler-Dialogbox mit einem OK-Schalter in der vordefi- �
 � nierten Gr��e 40 x 9 auf dem Bildschirm aus. Msg gibt die auszu- �
 � gebende Fehlermeldung an. Als Standard-Text in der Umrandung wird�
 � "Fehler" ausgegeben. Maximal sind 4 Zeilen Text m�glich.         �
 ������������������������������������������������������������������ͼ}
procedure _TVFehlerBox(Msg: string);
begin
  _Signalton;
  _TVInfoRect(40,9,'Fehler',Msg);
end;
{������������������������������������������������������������������ͻ
 � _TVFrageRect                                                     �
 ������������������������������������������������������������������Ķ
 � Gibt eine Frage-Dialogbox mit einem JA- und einem NEIN-Schalter  �
 � auf dem Bildschirm aus. X und Y geben die Breite und die H�he der�
 � Box an. FRAGE gibt den auszugebenden Text an. In der Umrandung   �
 � wird der Text "Frage:" ausgegeben. Wird die Frage mit JA beant-  �
 � wortet, liefert die Funktion das Ergebnis True, sonst False.     �
 ������������������������������������������������������������������ͼ}
function _TVFrageRect(x,y: byte; Frage: string): boolean;
var
  D: PDialog;                                           {Dialogobjekt}
  R,R1: TRect;                                  {Rechteckiger Bereich}
  E: word;                                     {Ergebnis von ExecView}

begin
  R.Assign(0,0,x,y);
  R1:= R;                                               {F�r Schalter}
  D:= New(PDialog,Init(R,'Frage:'));
  with D^ do
  begin
    Options:= Options or ofCentered;
    R.Grow(-2,-1);
    Dec(R.B.Y,3);
    Insert(New(PStaticText,Init(R,Frage)));
    {������������������������������������������������������Schalter��}
    _TVInitYesNo(R1,D);
  end;
  E:= Desktop^.ExecView(D);
  if E = cmYes then _TVFrageRect:= true
               else _TVFrageRect:= false;
  Dispose(D,Done);
end;
{������������������������������������������������������������������ͻ
 � _TVFrageBox                                                      �
 ������������������������������������������������������������������Ķ
 � Gibt eine Frage-Dialogbox mit einem JA- und einem NEIN-Schalter  �
 � in der vordefinierten Gr��e 40 x 11 auf dem Bildschirm aus. FRAGE�
 � gibt den auszugebenden Text an. In der Umrandung wird der Text   �
 � "Frage:" ausgegeben. Wird die Frage mit JA beantwortet, liefert  �
 � die Funktion das Ergebnis True, sonst False.                     �
 ������������������������������������������������������������������ͼ}
function _TVFrageBox(Frage: string): boolean;
begin
  _TVFrageBox:= _TVFrageRect(40,11,Frage);
end;
{������������������������������������������������������������������ͻ
 � _TVRealBox                                                       �
 ������������������������������������������������������������������Ķ
 � Gibt eine Dialogbox zur Eingabe einer Dezimalzahl auf dem Bild-  �
 � schirm aus, wobei die Grenzen der Zahl (Min,Max) vorgegeben wer- �
 � den k�nnen. Die maximale L�nge des Eingabefeldes betr�gt 11      �
 � Zeichen, die Nachkommastellen, die Beschriftung (AHeader), der   �
 � Label-Text (ALabel) und der Startwert (StartValue) m�ssen der    �
 � Funktion als Parameter �bergeben werden. Als Ergebnis wird die   �
 � eingegebene Dezimalzahl als Ergebnis der Funktion und ein cmXXXX-�
 � Befehl als Variablenparameter (Erg) zur�ckgeliefert.             �
 ������������������������������������������������������������������ͼ}
function _TVRealBox(Min,Max: real; Nach: byte;
                    AHeader,ALabel: string;
                    StartValue: real;
                    var Erg: word): real;

const
  MaxBoxLen = 70;                                {Max. Breite der Box}
  MinBoxLen = 40;                                {Min. Breite der Box}
  Delta = 20;
  Len = 11;                                        {L�nge Eingabefeld}

var
  D: PDialog;                                   {Zeiger auf Dialogbox}
  R,R1: TRect;                                  {Rechteckiger Bereich}
  Ptr: PView;                                {Zeiger auf Eingabezeile}
  x: byte;                                            {Breite der Box}
  y1: byte;                               {Zeile rechteckiger Bereich}
  XAOk,XAAbbr: byte;                            {Spalten der Schalter}
  S: string[Len];                                         {MWSt-Daten}

begin
  _TVRealBox:= StartValue;              {Mindestens StartValue zur�ck}
  S:= _AlleLeerzEntf(_NumToStr(StartValue,Len,Nach));

  {����������������������������������������Breite der Box ermitteln��}
  if (Length(AHeader) <= MaxBoxLen-Delta) and
     (Length(ALabel) <= MaxBoxLen-Delta) then
     begin
       if Length(AHeader) < Length(ALabel)
        then x:= Length(ALabel) + Delta
        else x:= Length(AHeader) + Delta;
     end
     else x:= MaxBoxLen;
  if x < MinBoxLen then x:= MinBoxLen;
  R.Assign(0,0,x,8);
  R1:= R;                                    {F�r die beiden Schalter}
  D:= New(PDialog,Init(R,AHeader));
  with D^ do
  begin
    Options:= Options or ofCentered;                  {Box zentrieren}
    R.Grow(-1,-1);                               {Fenster verkleinern}

    {�������������������������������Eingabezeile und Label einf�gen��}
    y1:= 2;                                              {Anfangswert}
    R.Assign((x div 2) - 7,y1+1,(x div 2) + 6,y1+2);
    Ptr:= New(_PXInputLineReal,Init(R,Min,Max,Len));
    Insert(Ptr);
    R.Assign((x div 2) - 8,y1,(x div 2) + Length(ALabel),y1+1);
    Insert(New(PLabel,Init(R,ALabel,Ptr)));

    {�����������������������������������������Schalter installieren��}
    _TVInitOkCancel(R1,D);
  end; {with}

  if not LowMemory                            {Sicherheitszone pr�fen}
  then begin
         D^.SetData(S);
         Erg:= DeskTop^.ExecView(D);
         if Erg <> cmCancel then
         begin
           D^.GetData(S);
           _TVRealBox:= _StrToReal(S);
         end;
         Dispose(D,Done);
       end
  else begin {������������������������������������Zu wenig Speicher��}
         Dispose(D,Done);
         _TVFehlerMldRAM;
       end;
end;
{������������������������������������������������������������������ͻ
 � _TVIntegerBox                                                    �
 ������������������������������������������������������������������Ķ
 � Gibt eine Dialogbox zur Eingabe einer ganzen Zahl auf dem Bild-  �
 � schirm aus, wobei die Grenzen der Zahl (Min,Max) vorgegeben wer- �
 � den k�nnen. Die maximale L�nge des Eingabefeldes betr�gt 10      �
 � Zeichen, die Beschriftung (AHeader), der Label-Text (ALabel) und �
 � der Startwert (StartValue) m�ssen der Funktion als Parameter     �
 � �bergeben werden. Als  Ergebnis wird die eingegebene Integer-Zahl�
 � als Ergebnis und ein cmXXXX-Befehl als Variablenparameter (Erg)  �
 � zur�ckgeliefert.                                                 �
 ������������������������������������������������������������������ͼ}
function _TVIntegerBox(Min,Max: integer;
                       AHeader,ALabel: string;
                       StartValue: integer;
                       var Erg: word): integer;

const
  MaxBoxLen = 70;                                {Max. Breite der Box}
  MinBoxLen = 40;                                {Min. Breite der Box}
  Delta = 20;
  Len = 10;                                        {L�nge Eingabefeld}

var
  D: PDialog;                                   {Zeiger auf Dialogbox}
  R,R1: TRect;                                  {Rechteckiger Bereich}
  Ptr: PView;                                {Zeiger auf Eingabezeile}
  x: byte;                                            {Breite der Box}
  y1: byte;                               {Zeile rechteckiger Bereich}
  S: string[Len];                                         {MWSt-Daten}

begin
  _TVIntegerBox:= StartValue;           {Mindestens StartValue zur�ck}
  S:= _AlleLeerzEntf(_NumToStr(StartValue,Len,0));

  {����������������������������������������Breite der Box ermitteln��}
  if (Length(AHeader) <= MaxBoxLen-Delta) and
     (Length(ALabel) <= MaxBoxLen-Delta) then
     begin
       if Length(AHeader) < Length(ALabel)
        then x:= Length(ALabel) + Delta
        else x:= Length(AHeader) + Delta;
     end
     else x:= MaxBoxLen;
  if x < MinBoxLen then x:= MinBoxLen;
  R.Assign(0,0,x,8);
  R1:= R;                                    {F�r die beiden Schalter}
  D:= New(PDialog,Init(R,AHeader));
  with D^ do
  begin
    Options:= Options or ofCentered;                  {Box zentrieren}
    R.Grow(-1,-1);                               {Fenster verkleinern}

    {�������������������������������Eingabezeile und Label einf�gen��}
    y1:= 2;                                              {Anfangswert}
    R.Assign((x div 2) - 7,y1+1,(x div 2) + 6,y1+2);
    Ptr:= New(_PXInputLineInt,Init(R,Min,Max,Len));
    Insert(Ptr);
    R.Assign((x div 2) - 8,y1,(x div 2) + Length(ALabel),y1+1);
    Insert(New(PLabel,Init(R,ALabel,Ptr)));

    {�����������������������������������������Schalter installieren��}
    _TVInitOkCancel(R1,D);
  end; {with}

  if not LowMemory                            {Sicherheitszone pr�fen}
  then begin
         D^.SetData(S);
         Erg:= DeskTop^.ExecView(D);
         if Erg <> cmCancel then
         begin
           D^.GetData(S);
           _TVIntegerBox:= _StrToInteger(S);
         end;
         Dispose(D,Done);
       end
  else begin {������������������������������������Zu wenig Speicher��}
         Dispose(D,Done);
         _TVFehlerMldRAM;
       end;
end;
{������������������������������������������������������������������ͻ
 � _TVInitYesNo                                                     �
 ������������������������������������������������������������������Ķ
 � Positioniert innerhalb einer Dialogbox die beiden Schalter JA und�
 � NEIN zentriert in der Zeile (R.B.Y - 3). R ist der zu �bergebende�
 � Bereich der Dialogbox, D ein Zeiger auf die Dialogbox.           �
 ������������������������������������������������������������������ͼ}
procedure _TVInitYesNo(var R: TRect; D: PDialog);
var
  XAJa,XANein: byte;                            {Spalten der Schalter}
  y: byte;                                        {Zeile der Schalter}

begin
  with D^ do
  begin
    y:= R.B.Y - 3;
    XAJa:= ((R.B.X - R.A.X) div 2) - 13;
    XANein:= ((R.B.X - R.A.X) div 2);
    R.Assign(XAJa,y,XAJa + 10,y+2);
    Insert(New(PButton,Init(R,'~J~a',cmYes,bfDefault)));
    R.Assign(XANein,y,XANein + 12,y+2);
    Insert(New(PButton,Init(R,'~N~ein',cmNo,bfNormal)));
  end;
end;
{������������������������������������������������������������������ͻ
 � _TVInitOkCancel                                                  �
 ������������������������������������������������������������������Ķ
 � Positioniert innerhalb einer Dialogbox die beiden Schalter OK und�
 � ABBRUCH zentriert in der Zeile (R.B.Y - 3). R ist der zu �berge- �
 � bende Bereich der Dialogbox, D ein Zeiger auf die Dialogbox.     �
 ������������������������������������������������������������������ͼ}
procedure _TVInitOkCancel(var R: TRect; D: PDialog);
var
  XAOk,XAAbbr: byte;                            {Spalten der Schalter}
  y: byte;                                        {Zeile der Schalter}

begin
  with D^ do
  begin
    y:= R.B.Y - 3;
    XAOk:= ((R.B.X - R.A.X) div 2) - 13;
    XAAbbr:= ((R.B.X - R.A.X) div 2);
    R.Assign(XAOk,y,XAOk + 10,y+2);
    Insert(New(PButton,Init(R,'~O~K',cmOK,bfDefault)));
    R.Assign(XAAbbr,y,XAAbbr + 13,y+2);
    Insert(New(PButton,Init(R,'Abbruch',cmCancel,bfNormal)));
  end;
end;
{������������������������������������������������������������������ͻ
 � _TVInitOk                                                        �
 ������������������������������������������������������������������Ķ
 � Positioniert innerhalb einer Dialogbox den OK-Schalter zentriert �
 � in der Zeile (R.B.Y - 3). R ist der zu �bergebende Bereich der   �
 � Dialogbox, D ein Zeiger auf die Dialogbox.                       �
 ������������������������������������������������������������������ͼ}
procedure _TVInitOk(var R: TRect; D: PDialog);
var
  XAOk: byte;                                   {Spalte des Schalters}
  y: byte;                                       {Zeile des Schalters}

begin
  with D^ do
  begin
    y:= R.B.Y - 3;
    XAOk:= ((R.B.X - R.A.X) div 2);
    R.Assign(XAOk - 5,y,XAOk + 5,y+2);
    Insert(New(PButton,Init(R,'~O~K',cmOK,bfDefault)));
  end;
end;
{�������������������������������������������������������End of unit��}
end.