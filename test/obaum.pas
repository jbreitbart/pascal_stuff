{ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
 º                Das groáe Buch zu Turbo Pascal 7.0                º
 º                                                                  º
 º                 Autorin: Gabi Rosenbaum    22.10.92              º
 º                                                                  º
 ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶
 ºUnit OBaum                                                        º
 ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼}
{B-,D-,F+,L-,O+,R-,V-,X+}
{$M 16384,0,655360}

Unit OBaum;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Interface (™ffentlicher Teil)                                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Interface
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Record TTreeItem                                                  ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Aufgabe: Untypisiertes Record zur Aufnahme der Daten, die in      ³
 ³         einem Baum vom Typ TREE abgespeichert werden             ³
 ³                                                                  ³
 ³Felder : Item  :  Zur Aufnahme der Datenstruktur                  ³
 ³         Left  :  Zeiger zum linken Baumast                       ³
 ³         Right :  Zeiger zum rechten Baumast                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Type
   PTreeItem = ^TTreeItem;
   TTreeItem = Record
      Item  : Pointer;
      Left  : PTreeItem;
      Right : PTreeItem;
   end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Prozedurvariable AForEach                                         ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Aufgabe: Format einer Prozedur, die der Methode ForEach des Ob-   ³
 ³         jectes TTree bergeben werden kann                       ³
 ³                                                                  ³
 ³Parameter: AItem  =  Ein Zeiger auf das Aktuelle Item aus einem   ³
 ³                     PTreeItem                                    ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Type
   AForEach = Procedure(AItem: Pointer);
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Objekt   TTree                                                    ³
*ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Aufgabe : Objekt, welches PTreeItems in einer Baumstruktur verwal-³
 ³         tet                                                      ³
 ³                                                                  ³
 ³Felder  : First  =  Erstes Element des bin„ren Baumes             ³
 ³                                                                  ³
 ³Methoden:                                                         ³
 ³Init           = Erzeugt das Feld First und setzt es auf NIL      ³
 ³Done           = L”scht alle Eintr„ge des Baumes, indem es die    ³
 ³                 Methode FreeL aufruft                            ³
 ³At             = Mit dieser Methode wird ein Element aus dem      ³
 ³                 Baum zurckgegeben, welches mit dem Schlsselfeld³
 ³                 von Item bereinstimmt. Das Schlsselfeld wird   ³
 ³                 durch die Funktion KeyOf festgelegt.             ³
 ³Delete         = L”scht das Element des Baumes, welches das       ³
 ³                 Schlsselfeld von Item besitzt. Das Schlsselfeld³
 ³                 wird in der Funktion KeyOf festgelegt.           ³
 ³FreeItem       = Interne Methode, die das rekursive L”schen eines ³
 ³                 Eintrags bernimmt.                              ³
 ³FreeL          = Interne Methode, die die gesamte Liste l”scht    ³
 ³ForEach        = ForEach bergibt der Procedure WhatProcedure je- ³
 ³                 des Element des Baums. WhatProcedure muá eine als³
 ³                 als Far deklarierte Procedure sein, die das For- ³
 ³                 mat AForEach (Prozedurvariable) besitzt.         ³
 ³Get            = Interne Methode, die rekursiv das Element sucht  ³
 ³                 welches in Item spezifiziert ist                 ³
 ³Insert         = Methode, mit deren Hilfe ein neues Element vom   ³
 ³                 Typ der benutzten Datenstruktur eingefgt wird   ³
 ³KeyOf          = Abstakte Methode                                 ³
 ³                 Diese Methode muá berschrieben werden und       ³
 ³                 folgendes Zurckgeben:                           ³
 ³                 -1 : Wenn das Schlsselfeld von ISearch kleiner  ³
 ³                      ist als das Schlsselfeld von IFind         ³
 ³                 0  : Wenn beide Felder gleich sind               ³
 ³                 1  : Wenn ISearch gr”áer ist als IFind           ³
 ³MakeForEach    = Interne Methode, die durch Rekursion jedes Ele-  ³
 ³                 ment des Baumes der Prozedurvariablen What       ³
 ³                 bergibt                                         ³
 ³Put            = Interne Methode, die das Einfgen bernimmt      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Type
   PTree = ^TTree;
   TTree = Object
     First: PTreeItem;
     Constructor Init;
     Destructor  Done;Virtual;
     Function    At (Item : Pointer): Pointer;
     Function    Delete(Item: Pointer): Boolean;Virtual;
     Function    FreeItem(Item: Pointer; Var AFirst: PTreeItem): Boolean;
     Procedure   FreeL(AFirst: PTreeItem);
     Procedure   ForEach(WhatProcedure: Pointer);Virtual;
     Function    Get(Item : Pointer; Var AFirst: PTreeItem): Pointer;
     Procedure   Insert(AItem: Pointer);Virtual;
     Function    KeyOf(Var ISearch, IFind: Pointer): Integer;Virtual;
     Procedure   MakeForEach(What : Pointer; Var AFirst: PTreeItem);
     Procedure   Put(Var AItem, AFirst: PTreeItem);
   end;
{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Implementation (Nicht”ffentlicher Teil.)                          ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Implementation

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Constructor TTree.Init                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Erzeugen und initialisieren des Feldes First.                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Constructor TTree.Init;
Begin
  First := New(PTreeItem);
  First := Nil;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Destructor TTree.Done;                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Wenn eine Liste besteht (First <> NIL) dann alle Elemente mit     ³
 ³Hilfe  von FreeL l”schen                                          ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Destructor TTree.Done;
Begin
  If First <> NIL then
  FreeL(First);
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function  TTree.At                          ;                     ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Das Element suchen, welches ber die Funktion KeyOf mit Item      ³
 ³bereinstimmt                                                     ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Function  TTree.At (Item : Pointer): Pointer;
Begin
  At := Get(Item,First);
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function TTree.Delete                                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Wenn eine Liste besteht, dann das Element l”schen, welches ber   ³
 ³die Funktion KeyOf mit Item bereinstimmt                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Function TTree.Delete(Item: Pointer) : Boolean;
Var
  OK : Boolean;
Begin
  If First <> NIL then
  OK := FreeItem(Item,First);
  Delete := OK;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function TTree.FreeItem                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Ein Element rekursiv l”schen                                      ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Function TTree.FreeItem(Item: Pointer;Var AFirst:PTreeItem): Boolean;
Var
  OK      : Boolean;
  AKeyOf  : Integer;
  ALeft,
  ARight  : PTreeItem;
Begin
  OK := False;
  AKeyOf := KeyOf(Item,AFirst^.Item);
  If AKeyOf = 0 then
  Begin
     ALeft  := AFirst^.Left;
     ARight := AFirst^.Right;
     OK := True;
     Dispose(AFirst);
     AFirst := NIL;
     If ALeft <> NIL then
     Put(ALeft,First);
     If ARight <> NIL then
     Put(ARight,First);
   end;

   If AKeyOf = -1 then
   If First^.Left <> NIL then
   OK := FreeItem(Item,AFirst^.Left);

   If AKeyOf = 1 then
   If First^.Right <> NIL then
   OK := FreeItem(Item,AFirst^.Right);
   FreeItem := OK;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TTree.MakeForEach                                       ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Die mit What spezifizierte Procedure aufrufen und ihr ein Item    ³
 ³bergeben                                                         ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TTree.MakeForEach(What : Pointer; Var AFirst: PTreeItem);
Begin
  AForEach(What)(AFirst^.Item);
  If AFirst^.Left <> NIL then
  MakeForEach(What,AFirst^.Left);
  If AFirst^.Right <> NIL then
  MakeForEach(What,AFirst^.Right);
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TTree.ForEach                                           ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Die Elemente des Baumes bergeben                                 ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TTree.ForEach;
Begin
  If First <> NIL then
  MakeForEach(WhatProcedure,First);
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TTree.FreeL                                             ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Alle Elemente des Baumes l”schen                                  ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TTree.FreeL(AFirst: PTreeItem);
Begin
  If (AFirst^.Right = NIL) AND
     (AFirst^.Left  = NIL) then
  Dispose(AFirst) else
  Begin
    If AFirst^.Right <> NIL then
    FreeL(AFirst^.Right);

    If AFirst^.Left <> NIL then
    FreeL(AFirst^.Left);
  end;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function  TTree.Get                                               ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Sucht ein Element                                                 ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Function  TTree.Get(Item : Pointer; Var AFirst: PTreeItem): Pointer;
Var
  Result: Pointer;
  AKeyOf: Integer;
Begin
  Get    := NIL;
  Result := NIL;
  AKeyOf := KeyOf(Item,AFirst^.Item);

  If AKeyOf = 0 then
    Result := AFirst^.Item

  else
  Begin
    If AKeyOf = -1 then
    Begin
     If AFirst^.Left <> NIL then
     Result := Get(Item,AFirst^.Left)
    end;

    If AKeyOf = 1 then
    Begin
     If AFirst^.Right <> NIL then
     Result := Get(Item,AFirst^.Right);
    end;
  end;
  Get := Result;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TTree.Insert                                            ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Fgt ein Element ein                                              ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TTree.Insert(AItem: Pointer);
Var
  Temp: PTreeItem;
Begin
  Temp := New(PTreeItem);
  With Temp^ do
  Begin
    Item  := AItem;
    Left  := NIL;
    Right := NIL;
    Put(Temp,First);
  end;
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Function TTree.KeyOf                                              ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Abstrakte Methode, die berschrieben werden muá                   ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}

Function TTree.KeyOf(Var ISearch, IFind: Pointer): Integer;
Begin
end;

{ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 ³Procedure TTree.Put                                               ³
 ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
 ³Interne Methode, die das Einfgen bernimmt                       ³
 ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ}
Procedure TTree.Put(Var AItem, AFirst: PTreeItem);
Var
  AKeyOf: Integer;
Begin
  If AFirst = NIL then
  AFirst := AItem
  else
  Begin
    AKeyOf := KeyOf(AItem^.Item,AFirst^.Item);
    If AKeyOf = -1 then
    Put(AItem,AFirst^.Left) else
    If AKeyOf = 1 then
    Put(AItem,AFirst^.Right);
  end;
end;
end.                                                  {Der Unit OBaum}
