{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                        Turbo Vision-Unit                         บ
 บ                 Autor: Reiner Sch”lles, 05.11.92                 บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Unit fr eigene Turbo Vision-Applikationen und _Quelle.pas.      บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Unit _TVTools;
{$X+}                                              {Erweiterte Syntax}

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Interface (ffentlicher Teil)                                    บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Interface
uses {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤEinzubindende Bibliothekenฤฤ}
  Crt,Dos,App,MsgBox,StdDlg,Dialogs,
  Objects,Views,Drivers,Memory,               {Units aus Turbo Pascal}
  _Tools;                                                {Eigene Unit}

type {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤVerzeichnis der globalen Datentypenฤฤ}

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ_TXStaticTextฤฤ}
  { Vereinbart einen Nachfolger von TStaticText mit einer neuen Farb-}
  { palette. Der statische Text wird auf blauem Hintergrund darge-   }
  { stellt.                                                          }
  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ}
  _PXStaticText = ^_TXStaticText;
  _TXStaticText = object (TStaticText)
    function GetPalette: PPalette; virtual;
  end;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ_TXInputLineIntฤฤ}
  { Vereinbart einen Nachfolger von TInputLine mit der Einschrnkung,}
  { daแ bei der Eingabe nur ganze Zahlen akzeptiert werden, falsche  }
  { werden zurckgewiesen. Min und Max geben die Grenzen der einzu-  }
  { gebenden Zahl, aus dem Bereich der ganzen Zahlen, an. AMaxLen    }
  { bezeichnet die maximale Lnge der Eingabezeile.                  }
  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ}
  _PXInputLineInt = ^_TXInputLineInt;
  _TXInputLineInt = object (TInputLine)
    Min,Max: integer;
    constructor Init(R: TRect; AMin,AMax,AMaxLen: integer);
    procedure HandleEvent(var Event: TEvent); virtual;
    function Valid(Command: word): boolean; virtual;
  end;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ_TXInputLineRealฤฤ}
  { Vereinbart einen Nachfolger von TInputLine mit der Einschrnkung,}
  { daแ bei der Eingabe nur Realzahlen akzeptiert werden, falsche    }
  { Eingaben werden zurckgewiesen. Min und Max geben die Grenzen    }
  { der einzugebenden Zahl, aus dem Bereich der Dezimalzahlen, an.   }
  { MaxLen bezeichnet die maximale Lnge der Eingabezeile.           }
  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ}
  _PXInputLineReal = ^_TXInputLineReal;
  _TXInputLineReal = object (TInputLine)
    Min,Max: real;
    constructor Init(R: TRect; AMin,AMax: real;AMaxLen: integer);
    procedure HandleEvent(var Event: TEvent); virtual;
    function Valid(Command: word): boolean; virtual;
  end;

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤVerzeichnis der globalen Routinenฤฤ}

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

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Implementation (Nicht-”ffentlicher Teil)                         บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Implementation

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Implementierung der Methoden von _TXStaticText                   บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}

{ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 ณ _TXStaticText.GetPalette                                         ณ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
 ณ Redefiniert die Farbpalette des _TXStaticText-Objekts.           ณ
 ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู}
function _TXStaticText.GetPalette: PPalette;
const
  C = #8;                     {Neuer Farbpaletten-Verweis, Farbe Blau}
  P: String[Length(C)] = C;

begin
  GetPalette:= @P;
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Implementierung der Methoden von _TXInputLineInt                 บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}

{ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 ณ _TXInputLineInt.Init                                             ณ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
 ณ Initialisiert die Datenfelder des Objekts.                       ณ
 ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู}
constructor _TXInputLineInt.Init(R: TRect;
                                 AMin,AMax,AMaxLen: integer);
begin
  TInputLine.Init(R,AMaxLen);
  Min:= AMin;
  Max:= AMax;
end;
{ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 ณ _TXInputLineInt.HandleEvent                                      ณ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
 ณ Schrnkt die Eingabe in ein Eingabefeld auf den Datentyp Integer ณ
 ณ (Ganze Zahl) ein.                                                ณ
 ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู}
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
{ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 ณ _TXInputLineInt.Valid                                            ณ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
 ณ Prft die Gltigkeit der Eingabe und gibt bei Bedarf eine Fehler-ณ
 ณ meldung aus.                                                     ณ
 ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู}
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

  begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤAuf gltigen Wert prfenฤฤ}
    s:= Data^;
    Val(s,Zahl,Code);                          {Umwandlung in Integer}
    if Code = 0

    then begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤGrenzen prfenฤฤ}
           if (Zahl >= Min) and (Zahl <= Max)
            then Ok:= true
            else Ok:= false;
         end
    else Ok:= false;
  end

  else Ok:= false;
  if Ok then Valid:= TInputLine.Valid(Command)
        else Valid:= false;

  if not Ok {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤWenn fehlerhafte Eingabe vorliegtฤฤ}
   then _TVFehlerBox(#13'Eingabe entspricht keinem ' +
           'gltigen numerischen Wert oder liegt auแerhalb ' +
           'der Grenzen!');
end;

{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ Implementierung der Methoden von _TXInputLineReal                บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}

{ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 ณ _TXInputLineReal.Init                                            ณ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
 ณ Initialisiert die Datenfelder des Objekts.                       ณ
 ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู}
constructor _TXInputLineReal.Init(R: TRect; AMin,AMax: real;
                                  AMaxLen: integer);

begin
  TInputLine.Init(R,AMaxLen);
  Min:= AMin;
  Max:= AMax;
end;
{ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 ณ _TXInputLineReal.HandleEvent                                     ณ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
 ณ Schrnkt die Eingabe in ein Eingabefeld auf den Datentyp Real    ณ
 ณ (Dezimalzahlen) ein.                                             ณ
 ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู}
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
{ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
 ณ _TXInputLineReal.Valid                                           ณ
 รฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤด
 ณ Prft die Gltigkeit der Eingabe und gibt bei Bedarf eine Fehler-ณ
 ณ meldung aus.                                                     ณ
 ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู}
function _TXInputLineReal.Valid(Command: word): boolean;
var
  s: string;                                             {Datenstring}
  i: integer;                                           {Zhlvariable}
  Zahl: real;                                      {Umgewandelte Zahl}
  Code: integer;                                  {Fehlercode von Val}
  Ok: boolean;                                         {Ob Eingabe Ok}

begin
  Ok:= true;                                  {Angenommen, Eingabe Ok}
  Select;
  SelectAll(True);
  if (Command <> cmCancel) and (Data <> nil) then

  begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤAuf gltigen Wert prfenฤฤ}
    s:= Data^;
    for i:= 1 to Length(s) do
     if s[i] = ',' then s[i]:= '.';
    Val(s,Zahl,Code);                             {Umwandlung in Real}
    if Code = 0
    then begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤGrenzen prfenฤฤ}
           if (Zahl >= Min) and (Zahl <= Max)
            then Ok:= true
            else Ok:= false;
         end
    else Ok:= false;
  end

  else Ok:= false;
  if Ok then Valid:= TInputLine.Valid(Command)
        else Valid:= false;

  if not Ok {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤWenn fehlerhafte Eingabe vorliegtฤฤ}
   then _TVFehlerBox(#13'Eingabe entspricht keinem ' +
           'gltigen numerischen Wert oder liegt auแerhalb ' +
           'der Grenzen!');
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVFehlerMldRAM                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤออออออฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt in einer Fehlerbox die Meldung aus, daแ der Arbeitsspeicher บ
 บ fr die durchgefhrte Operation nicht ausreicht. Kann im Zusam-  บ
 บ menhang mit LowMemory benutzt werden, wenn auf OutOfMemory kein  บ
 บ Zugriff besteht.                                                 บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure _TVFehlerMldRAM;
begin
  _TVFehlerBox(#13 + 'Arbeitsspeicher reicht fr durch' +
               'gefhrte Operation nicht aus!');
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVInfoRect                                                      บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt eine Info-Dialogbox mit einem OK-Schalter auf dem Bildschirmบ
 บ aus. X und Y geben die Breite und die H”he der Box, Header den   บ
 บ Text in der Umrandung und Msg die auszugebende Meldung an.       บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure _TVInfoRect(x,y: byte; Header,Msg: string);
var
  D: PDialog;                                           {Dialogobjekt}
  R,R1: TRect;                                  {Rechteckiger Bereich}

begin
  R.Assign(0,0,x,y);
  R1:= R;                                               {Fr Schalter}
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
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVInfoBox                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt eine Info-Dialogbox mit einem OK-Schalter in der Standard-  บ
 บ gr”แe 40 x 11 auf dem Bildschirm aus. Msg gibt die auszugebende  บ
 บ Meldung an. Als Standard-Text in der Umrandung wird "Information"บ
 บ ausgegeben. Maximal sind 6 Zeilen Text m”glich.                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure _TVInfoBox(Msg: string);
begin
  _TVInfoRect(40,11,'Information',Msg);
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVFehlerBox                                                     บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt eine Fehler-Dialogbox mit einem OK-Schalter in der vordefi- บ
 บ nierten Gr”แe 40 x 9 auf dem Bildschirm aus. Msg gibt die auszu- บ
 บ gebende Fehlermeldung an. Als Standard-Text in der Umrandung wirdบ
 บ "Fehler" ausgegeben. Maximal sind 4 Zeilen Text m”glich.         บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
procedure _TVFehlerBox(Msg: string);
begin
  _Signalton;
  _TVInfoRect(40,9,'Fehler',Msg);
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVFrageRect                                                     บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt eine Frage-Dialogbox mit einem JA- und einem NEIN-Schalter  บ
 บ auf dem Bildschirm aus. X und Y geben die Breite und die H”he derบ
 บ Box an. FRAGE gibt den auszugebenden Text an. In der Umrandung   บ
 บ wird der Text "Frage:" ausgegeben. Wird die Frage mit JA beant-  บ
 บ wortet, liefert die Funktion das Ergebnis True, sonst False.     บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _TVFrageRect(x,y: byte; Frage: string): boolean;
var
  D: PDialog;                                           {Dialogobjekt}
  R,R1: TRect;                                  {Rechteckiger Bereich}
  E: word;                                     {Ergebnis von ExecView}

begin
  R.Assign(0,0,x,y);
  R1:= R;                                               {Fr Schalter}
  D:= New(PDialog,Init(R,'Frage:'));
  with D^ do
  begin
    Options:= Options or ofCentered;
    R.Grow(-2,-1);
    Dec(R.B.Y,3);
    Insert(New(PStaticText,Init(R,Frage)));
    {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤSchalterฤฤ}
    _TVInitYesNo(R1,D);
  end;
  E:= Desktop^.ExecView(D);
  if E = cmYes then _TVFrageRect:= true
               else _TVFrageRect:= false;
  Dispose(D,Done);
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVFrageBox                                                      บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt eine Frage-Dialogbox mit einem JA- und einem NEIN-Schalter  บ
 บ in der vordefinierten Gr”แe 40 x 11 auf dem Bildschirm aus. FRAGEบ
 บ gibt den auszugebenden Text an. In der Umrandung wird der Text   บ
 บ "Frage:" ausgegeben. Wird die Frage mit JA beantwortet, liefert  บ
 บ die Funktion das Ergebnis True, sonst False.                     บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _TVFrageBox(Frage: string): boolean;
begin
  _TVFrageBox:= _TVFrageRect(40,11,Frage);
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVRealBox                                                       บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt eine Dialogbox zur Eingabe einer Dezimalzahl auf dem Bild-  บ
 บ schirm aus, wobei die Grenzen der Zahl (Min,Max) vorgegeben wer- บ
 บ den k”nnen. Die maximale Lnge des Eingabefeldes betrgt 11      บ
 บ Zeichen, die Nachkommastellen, die Beschriftung (AHeader), der   บ
 บ Label-Text (ALabel) und der Startwert (StartValue) mssen der    บ
 บ Funktion als Parameter bergeben werden. Als Ergebnis wird die   บ
 บ eingegebene Dezimalzahl als Ergebnis der Funktion und ein cmXXXX-บ
 บ Befehl als Variablenparameter (Erg) zurckgeliefert.             บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _TVRealBox(Min,Max: real; Nach: byte;
                    AHeader,ALabel: string;
                    StartValue: real;
                    var Erg: word): real;

const
  MaxBoxLen = 70;                                {Max. Breite der Box}
  MinBoxLen = 40;                                {Min. Breite der Box}
  Delta = 20;
  Len = 11;                                        {Lnge Eingabefeld}

var
  D: PDialog;                                   {Zeiger auf Dialogbox}
  R,R1: TRect;                                  {Rechteckiger Bereich}
  Ptr: PView;                                {Zeiger auf Eingabezeile}
  x: byte;                                            {Breite der Box}
  y1: byte;                               {Zeile rechteckiger Bereich}
  XAOk,XAAbbr: byte;                            {Spalten der Schalter}
  S: string[Len];                                         {MWSt-Daten}

begin
  _TVRealBox:= StartValue;              {Mindestens StartValue zurck}
  S:= _AlleLeerzEntf(_NumToStr(StartValue,Len,Nach));

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤBreite der Box ermittelnฤฤ}
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
  R1:= R;                                    {Fr die beiden Schalter}
  D:= New(PDialog,Init(R,AHeader));
  with D^ do
  begin
    Options:= Options or ofCentered;                  {Box zentrieren}
    R.Grow(-1,-1);                               {Fenster verkleinern}

    {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤEingabezeile und Label einfgenฤฤ}
    y1:= 2;                                              {Anfangswert}
    R.Assign((x div 2) - 7,y1+1,(x div 2) + 6,y1+2);
    Ptr:= New(_PXInputLineReal,Init(R,Min,Max,Len));
    Insert(Ptr);
    R.Assign((x div 2) - 8,y1,(x div 2) + Length(ALabel),y1+1);
    Insert(New(PLabel,Init(R,ALabel,Ptr)));

    {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤSchalter installierenฤฤ}
    _TVInitOkCancel(R1,D);
  end; {with}

  if not LowMemory                            {Sicherheitszone prfen}
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
  else begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤZu wenig Speicherฤฤ}
         Dispose(D,Done);
         _TVFehlerMldRAM;
       end;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVIntegerBox                                                    บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Gibt eine Dialogbox zur Eingabe einer ganzen Zahl auf dem Bild-  บ
 บ schirm aus, wobei die Grenzen der Zahl (Min,Max) vorgegeben wer- บ
 บ den k”nnen. Die maximale Lnge des Eingabefeldes betrgt 10      บ
 บ Zeichen, die Beschriftung (AHeader), der Label-Text (ALabel) und บ
 บ der Startwert (StartValue) mssen der Funktion als Parameter     บ
 บ bergeben werden. Als  Ergebnis wird die eingegebene Integer-Zahlบ
 บ als Ergebnis und ein cmXXXX-Befehl als Variablenparameter (Erg)  บ
 บ zurckgeliefert.                                                 บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
function _TVIntegerBox(Min,Max: integer;
                       AHeader,ALabel: string;
                       StartValue: integer;
                       var Erg: word): integer;

const
  MaxBoxLen = 70;                                {Max. Breite der Box}
  MinBoxLen = 40;                                {Min. Breite der Box}
  Delta = 20;
  Len = 10;                                        {Lnge Eingabefeld}

var
  D: PDialog;                                   {Zeiger auf Dialogbox}
  R,R1: TRect;                                  {Rechteckiger Bereich}
  Ptr: PView;                                {Zeiger auf Eingabezeile}
  x: byte;                                            {Breite der Box}
  y1: byte;                               {Zeile rechteckiger Bereich}
  S: string[Len];                                         {MWSt-Daten}

begin
  _TVIntegerBox:= StartValue;           {Mindestens StartValue zurck}
  S:= _AlleLeerzEntf(_NumToStr(StartValue,Len,0));

  {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤBreite der Box ermittelnฤฤ}
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
  R1:= R;                                    {Fr die beiden Schalter}
  D:= New(PDialog,Init(R,AHeader));
  with D^ do
  begin
    Options:= Options or ofCentered;                  {Box zentrieren}
    R.Grow(-1,-1);                               {Fenster verkleinern}

    {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤEingabezeile und Label einfgenฤฤ}
    y1:= 2;                                              {Anfangswert}
    R.Assign((x div 2) - 7,y1+1,(x div 2) + 6,y1+2);
    Ptr:= New(_PXInputLineInt,Init(R,Min,Max,Len));
    Insert(Ptr);
    R.Assign((x div 2) - 8,y1,(x div 2) + Length(ALabel),y1+1);
    Insert(New(PLabel,Init(R,ALabel,Ptr)));

    {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤSchalter installierenฤฤ}
    _TVInitOkCancel(R1,D);
  end; {with}

  if not LowMemory                            {Sicherheitszone prfen}
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
  else begin {ฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤZu wenig Speicherฤฤ}
         Dispose(D,Done);
         _TVFehlerMldRAM;
       end;
end;
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVInitYesNo                                                     บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Positioniert innerhalb einer Dialogbox die beiden Schalter JA undบ
 บ NEIN zentriert in der Zeile (R.B.Y - 3). R ist der zu bergebendeบ
 บ Bereich der Dialogbox, D ein Zeiger auf die Dialogbox.           บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVInitOkCancel                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Positioniert innerhalb einer Dialogbox die beiden Schalter OK undบ
 บ ABBRUCH zentriert in der Zeile (R.B.Y - 3). R ist der zu berge- บ
 บ bende Bereich der Dialogbox, D ein Zeiger auf die Dialogbox.     บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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
{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ _TVInitOk                                                        บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ Positioniert innerhalb einer Dialogbox den OK-Schalter zentriert บ
 บ in der Zeile (R.B.Y - 3). R ist der zu bergebende Bereich der   บ
 บ Dialogbox, D ein Zeiger auf die Dialogbox.                       บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
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
{อออออออออออออออออออออออออออออออออออออออออออออออออออออออEnd of unitออ}
end.