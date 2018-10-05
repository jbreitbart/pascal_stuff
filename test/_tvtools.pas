{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                        Turbo Vision-Unit                         �
 �                 Autor: Reiner Sch�lles, 05.11.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Unit f�r eigene Turbo Vision-Applikationen und _Quelle.pas.      �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Unit _TVTools;
{$X+}                                              {Erweiterte Syntax}

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Interface (�ffentlicher Teil)                                    �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Interface
uses {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Einzubindende Bibliotheken陳}
  Crt,Dos,App,MsgBox,StdDlg,Dialogs,
  Objects,Views,Drivers,Memory,               {Units aus Turbo Pascal}
  _Tools;                                                {Eigene Unit}

type {陳陳陳陳陳陳陳陳陳陳陳陳陳Verzeichnis der globalen Datentypen陳}

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�_TXStaticText陳}
  { Vereinbart einen Nachfolger von TStaticText mit einer neuen Farb-}
  { palette. Der statische Text wird auf blauem Hintergrund darge-   }
  { stellt.                                                          }
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
  _PXStaticText = ^_TXStaticText;
  _TXStaticText = object (TStaticText)
    function GetPalette: PPalette; virtual;
  end;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�_TXInputLineInt陳}
  { Vereinbart einen Nachfolger von TInputLine mit der Einschr�nkung,}
  { da� bei der Eingabe nur ganze Zahlen akzeptiert werden, falsche  }
  { werden zur�ckgewiesen. Min und Max geben die Grenzen der einzu-  }
  { gebenden Zahl, aus dem Bereich der ganzen Zahlen, an. AMaxLen    }
  { bezeichnet die maximale L�nge der Eingabezeile.                  }
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
  _PXInputLineInt = ^_TXInputLineInt;
  _TXInputLineInt = object (TInputLine)
    Min,Max: integer;
    constructor Init(R: TRect; AMin,AMax,AMaxLen: integer);
    procedure HandleEvent(var Event: TEvent); virtual;
    function Valid(Command: word): boolean; virtual;
  end;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳_TXInputLineReal陳}
  { Vereinbart einen Nachfolger von TInputLine mit der Einschr�nkung,}
  { da� bei der Eingabe nur Realzahlen akzeptiert werden, falsche    }
  { Eingaben werden zur�ckgewiesen. Min und Max geben die Grenzen    }
  { der einzugebenden Zahl, aus dem Bereich der Dezimalzahlen, an.   }
  { MaxLen bezeichnet die maximale L�nge der Eingabezeile.           }
  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳}
  _PXInputLineReal = ^_TXInputLineReal;
  _TXInputLineReal = object (TInputLine)
    Min,Max: real;
    constructor Init(R: TRect; AMin,AMax: real;AMaxLen: integer);
    procedure HandleEvent(var Event: TEvent); virtual;
    function Valid(Command: word): boolean; virtual;
  end;

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Verzeichnis der globalen Routinen陳}

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

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Implementation (Nicht-�ffentlicher Teil)                         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Implementation

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Implementierung der Methoden von _TXStaticText                   �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � _TXStaticText.GetPalette                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Redefiniert die Farbpalette des _TXStaticText-Objekts.           �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
function _TXStaticText.GetPalette: PPalette;
const
  C = #8;                     {Neuer Farbpaletten-Verweis, Farbe Blau}
  P: String[Length(C)] = C;

begin
  GetPalette:= @P;
end;

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Implementierung der Methoden von _TXInputLineInt                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � _TXInputLineInt.Init                                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert die Datenfelder des Objekts.                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
constructor _TXInputLineInt.Init(R: TRect;
                                 AMin,AMax,AMaxLen: integer);
begin
  TInputLine.Init(R,AMaxLen);
  Min:= AMin;
  Max:= AMax;
end;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � _TXInputLineInt.HandleEvent                                      �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Schr�nkt die Eingabe in ein Eingabefeld auf den Datentyp Integer �
 � (Ganze Zahl) ein.                                                �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � _TXInputLineInt.Valid                                            �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Pr�ft die G�ltigkeit der Eingabe und gibt bei Bedarf eine Fehler-�
 � meldung aus.                                                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

  begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Auf g�ltigen Wert pr�fen陳}
    s:= Data^;
    Val(s,Zahl,Code);                          {Umwandlung in Integer}
    if Code = 0

    then begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Grenzen pr�fen陳}
           if (Zahl >= Min) and (Zahl <= Max)
            then Ok:= true
            else Ok:= false;
         end
    else Ok:= false;
  end

  else Ok:= false;
  if Ok then Valid:= TInputLine.Valid(Command)
        else Valid:= false;

  if not Ok {陳陳陳陳陳陳陳陳陳陳�Wenn fehlerhafte Eingabe vorliegt陳}
   then _TVFehlerBox(#13'Eingabe entspricht keinem ' +
           'g�ltigen numerischen Wert oder liegt au�erhalb ' +
           'der Grenzen!');
end;

{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � Implementierung der Methoden von _TXInputLineReal                �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � _TXInputLineReal.Init                                            �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Initialisiert die Datenfelder des Objekts.                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
constructor _TXInputLineReal.Init(R: TRect; AMin,AMax: real;
                                  AMaxLen: integer);

begin
  TInputLine.Init(R,AMaxLen);
  Min:= AMin;
  Max:= AMax;
end;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � _TXInputLineReal.HandleEvent                                     �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Schr�nkt die Eingabe in ein Eingabefeld auf den Datentyp Real    �
 � (Dezimalzahlen) ein.                                             �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 � _TXInputLineReal.Valid                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 � Pr�ft die G�ltigkeit der Eingabe und gibt bei Bedarf eine Fehler-�
 � meldung aus.                                                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

  begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Auf g�ltigen Wert pr�fen陳}
    s:= Data^;
    for i:= 1 to Length(s) do
     if s[i] = ',' then s[i]:= '.';
    Val(s,Zahl,Code);                             {Umwandlung in Real}
    if Code = 0
    then begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Grenzen pr�fen陳}
           if (Zahl >= Min) and (Zahl <= Max)
            then Ok:= true
            else Ok:= false;
         end
    else Ok:= false;
  end

  else Ok:= false;
  if Ok then Valid:= TInputLine.Valid(Command)
        else Valid:= false;

  if not Ok {陳陳陳陳陳陳陳陳陳陳�Wenn fehlerhafte Eingabe vorliegt陳}
   then _TVFehlerBox(#13'Eingabe entspricht keinem ' +
           'g�ltigen numerischen Wert oder liegt au�erhalb ' +
           'der Grenzen!');
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVFehlerMldRAM                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳様様様陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt in einer Fehlerbox die Meldung aus, da� der Arbeitsspeicher �
 � f�r die durchgef�hrte Operation nicht ausreicht. Kann im Zusam-  �
 � menhang mit LowMemory benutzt werden, wenn auf OutOfMemory kein  �
 � Zugriff besteht.                                                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure _TVFehlerMldRAM;
begin
  _TVFehlerBox(#13 + 'Arbeitsspeicher reicht f�r durch' +
               'gef�hrte Operation nicht aus!');
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVInfoRect                                                      �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt eine Info-Dialogbox mit einem OK-Schalter auf dem Bildschirm�
 � aus. X und Y geben die Breite und die H�he der Box, Header den   �
 � Text in der Umrandung und Msg die auszugebende Meldung an.       �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVInfoBox                                                       �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt eine Info-Dialogbox mit einem OK-Schalter in der Standard-  �
 � gr��e 40 x 11 auf dem Bildschirm aus. Msg gibt die auszugebende  �
 � Meldung an. Als Standard-Text in der Umrandung wird "Information"�
 � ausgegeben. Maximal sind 6 Zeilen Text m�glich.                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure _TVInfoBox(Msg: string);
begin
  _TVInfoRect(40,11,'Information',Msg);
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVFehlerBox                                                     �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt eine Fehler-Dialogbox mit einem OK-Schalter in der vordefi- �
 � nierten Gr��e 40 x 9 auf dem Bildschirm aus. Msg gibt die auszu- �
 � gebende Fehlermeldung an. Als Standard-Text in der Umrandung wird�
 � "Fehler" ausgegeben. Maximal sind 4 Zeilen Text m�glich.         �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
procedure _TVFehlerBox(Msg: string);
begin
  _Signalton;
  _TVInfoRect(40,9,'Fehler',Msg);
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVFrageRect                                                     �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt eine Frage-Dialogbox mit einem JA- und einem NEIN-Schalter  �
 � auf dem Bildschirm aus. X und Y geben die Breite und die H�he der�
 � Box an. FRAGE gibt den auszugebenden Text an. In der Umrandung   �
 � wird der Text "Frage:" ausgegeben. Wird die Frage mit JA beant-  �
 � wortet, liefert die Funktion das Ergebnis True, sonst False.     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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
    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Schalter陳}
    _TVInitYesNo(R1,D);
  end;
  E:= Desktop^.ExecView(D);
  if E = cmYes then _TVFrageRect:= true
               else _TVFrageRect:= false;
  Dispose(D,Done);
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVFrageBox                                                      �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt eine Frage-Dialogbox mit einem JA- und einem NEIN-Schalter  �
 � in der vordefinierten Gr��e 40 x 11 auf dem Bildschirm aus. FRAGE�
 � gibt den auszugebenden Text an. In der Umrandung wird der Text   �
 � "Frage:" ausgegeben. Wird die Frage mit JA beantwortet, liefert  �
 � die Funktion das Ergebnis True, sonst False.                     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
function _TVFrageBox(Frage: string): boolean;
begin
  _TVFrageBox:= _TVFrageRect(40,11,Frage);
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVRealBox                                                       �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt eine Dialogbox zur Eingabe einer Dezimalzahl auf dem Bild-  �
 � schirm aus, wobei die Grenzen der Zahl (Min,Max) vorgegeben wer- �
 � den k�nnen. Die maximale L�nge des Eingabefeldes betr�gt 11      �
 � Zeichen, die Nachkommastellen, die Beschriftung (AHeader), der   �
 � Label-Text (ALabel) und der Startwert (StartValue) m�ssen der    �
 � Funktion als Parameter �bergeben werden. Als Ergebnis wird die   �
 � eingegebene Dezimalzahl als Ergebnis der Funktion und ein cmXXXX-�
 � Befehl als Variablenparameter (Erg) zur�ckgeliefert.             �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Breite der Box ermitteln陳}
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

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabezeile und Label einf�gen陳}
    y1:= 2;                                              {Anfangswert}
    R.Assign((x div 2) - 7,y1+1,(x div 2) + 6,y1+2);
    Ptr:= New(_PXInputLineReal,Init(R,Min,Max,Len));
    Insert(Ptr);
    R.Assign((x div 2) - 8,y1,(x div 2) + Length(ALabel),y1+1);
    Insert(New(PLabel,Init(R,ALabel,Ptr)));

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Schalter installieren陳}
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
  else begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Zu wenig Speicher陳}
         Dispose(D,Done);
         _TVFehlerMldRAM;
       end;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVIntegerBox                                                    �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Gibt eine Dialogbox zur Eingabe einer ganzen Zahl auf dem Bild-  �
 � schirm aus, wobei die Grenzen der Zahl (Min,Max) vorgegeben wer- �
 � den k�nnen. Die maximale L�nge des Eingabefeldes betr�gt 10      �
 � Zeichen, die Beschriftung (AHeader), der Label-Text (ALabel) und �
 � der Startwert (StartValue) m�ssen der Funktion als Parameter     �
 � �bergeben werden. Als  Ergebnis wird die eingegebene Integer-Zahl�
 � als Ergebnis und ein cmXXXX-Befehl als Variablenparameter (Erg)  �
 � zur�ckgeliefert.                                                 �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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

  {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Breite der Box ermitteln陳}
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

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Eingabezeile und Label einf�gen陳}
    y1:= 2;                                              {Anfangswert}
    R.Assign((x div 2) - 7,y1+1,(x div 2) + 6,y1+2);
    Ptr:= New(_PXInputLineInt,Init(R,Min,Max,Len));
    Insert(Ptr);
    R.Assign((x div 2) - 8,y1,(x div 2) + Length(ALabel),y1+1);
    Insert(New(PLabel,Init(R,ALabel,Ptr)));

    {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Schalter installieren陳}
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
  else begin {陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Zu wenig Speicher陳}
         Dispose(D,Done);
         _TVFehlerMldRAM;
       end;
end;
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVInitYesNo                                                     �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Positioniert innerhalb einer Dialogbox die beiden Schalter JA und�
 � NEIN zentriert in der Zeile (R.B.Y - 3). R ist der zu �bergebende�
 � Bereich der Dialogbox, D ein Zeiger auf die Dialogbox.           �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVInitOkCancel                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Positioniert innerhalb einer Dialogbox die beiden Schalter OK und�
 � ABBRUCH zentriert in der Zeile (R.B.Y - 3). R ist der zu �berge- �
 � bende Bereich der Dialogbox, D ein Zeiger auf die Dialogbox.     �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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
{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 � _TVInitOk                                                        �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Positioniert innerhalb einer Dialogbox den OK-Schalter zentriert �
 � in der Zeile (R.B.Y - 3). R ist der zu �bergebende Bereich der   �
 � Dialogbox, D ein Zeiger auf die Dialogbox.                       �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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
{様様様様様様様様様様様様様様様様様様様様様様様様様様様�End of unit様}
end.