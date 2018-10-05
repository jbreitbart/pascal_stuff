{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                                                                  บ
 บ                 Autorin: Gabi Rosenbaum 20.10.1992               บ
 บ                                                                  บ
 วฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤถ
 บ        Einfache verkettete Listen                                บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program VerketteteListe;                          {Datei: Liste02.Pas}
uses
   Crt;                                  {Bibliothek aus Turbo-Pascal}

Type
    PString = ^String;

    PSItem = ^TSItem;
    TSItem = Record
      Value : PString;
      Next  : PSItem;
    end;

Function NewStr(Const S: String): PString;
var
  P: PString;
begin
  if S = '' then P := nil else
  begin
    GetMem(P, Length(S) + 1);   {Speicher fr den String + 1 Byte     }
                                {Stringlngeninformation bereitstellen}
    P^ := S;                    {Der Dynamischen Variablen den Wert S }
                                {zuweisen                             }
  end;
  NewStr := P;                  {Funktionsergebnis ist der zeiger P    }
end;

Procedure DisposeStr(P: PString);
begin
  if P <> nil then FreeMem(P, Length(P^) + 1);
end;

Function NewSItem(Const Str: String; ANext: PSItem): PSItem;
var
  Item: PSItem;
begin
  New(Item);
  Item^.Value := NewStr(Str); 
  Item^.Next := ANext;
  NewSItem := Item;
end;

Function BuildList: PSItem;
Begin
   BuildList := NewSItem('Erster String',
                NewSItem('Zweiter String',
                NewSItem('Dritter String',
                {...}
                NIL)));
end;

Procedure WriteList(P :PSItem);
Begin
  If P <> Nil then
  While P <> NIL do
  Begin
    Writeln(P^.Value^);
    P := P^.Next;
  end;
end;

Procedure DeleteList(P :PSItem);
Var
  Help : PSItem;
Begin
  Help := NIL;
  If P <> NIL then
  Begin
    While P <> NIL do
    Begin
      Help := P^.Next;
      DisposeStr(P^.Value);
      Dispose(P);
      P := Help;
    end;
  end;
end;

Var
  ActList : PSItem;

begin
  ClrScr;
  ActList := BuildList;
  WriteList(ActList);
  ReadLn;
  DeleteList(ActList);
end.
