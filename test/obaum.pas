{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    22.10.92              �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 �Unit OBaum                                                        �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
{B-,D-,F+,L-,O+,R-,V-,X+}
{$M 16384,0,655360}

Unit OBaum;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�
 �Interface (�ffentlicher Teil)                                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�}
Interface
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Record TTreeItem                                                  �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Aufgabe: Untypisiertes Record zur Aufnahme der Daten, die in      �
 �         einem Baum vom Typ TREE abgespeichert werden             �
 �                                                                  �
 �Felder : Item  :  Zur Aufnahme der Datenstruktur                  �
 �         Left  :  Zeiger zum linken Baumast                       �
 �         Right :  Zeiger zum rechten Baumast                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}

Type
   PTreeItem = ^TTreeItem;
   TTreeItem = Record
      Item  : Pointer;
      Left  : PTreeItem;
      Right : PTreeItem;
   end;
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Prozedurvariable AForEach                                         �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Aufgabe: Format einer Prozedur, die der Methode ForEach des Ob-   �
 �         jectes TTree �bergeben werden kann                       �
 �                                                                  �
 �Parameter: AItem  =  Ein Zeiger auf das Aktuelle Item aus einem   �
 �                     PTreeItem                                    �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Type
   AForEach = Procedure(AItem: Pointer);
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Objekt   TTree                                                    �
*団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Aufgabe : Objekt, welches PTreeItems in einer Baumstruktur verwal-�
 �         tet                                                      �
 �                                                                  �
 �Felder  : First  =  Erstes Element des bin�ren Baumes             �
 �                                                                  �
 �Methoden:                                                         �
 �Init           = Erzeugt das Feld First und setzt es auf NIL      �
 �Done           = L�scht alle Eintr�ge des Baumes, indem es die    �
 �                 Methode FreeL aufruft                            �
 �At             = Mit dieser Methode wird ein Element aus dem      �
 �                 Baum zur�ckgegeben, welches mit dem Schl�sselfeld�
 �                 von Item �bereinstimmt. Das Schl�sselfeld wird   �
 �                 durch die Funktion KeyOf festgelegt.             �
 �Delete         = L�scht das Element des Baumes, welches das       �
 �                 Schl�sselfeld von Item besitzt. Das Schl�sselfeld�
 �                 wird in der Funktion KeyOf festgelegt.           �
 �FreeItem       = Interne Methode, die das rekursive L�schen eines �
 �                 Eintrags �bernimmt.                              �
 �FreeL          = Interne Methode, die die gesamte Liste l�scht    �
 �ForEach        = ForEach �bergibt der Procedure WhatProcedure je- �
 �                 des Element des Baums. WhatProcedure mu� eine als�
 �                 als Far deklarierte Procedure sein, die das For- �
 �                 mat AForEach (Prozedurvariable) besitzt.         �
 �Get            = Interne Methode, die rekursiv das Element sucht  �
 �                 welches in Item spezifiziert ist                 �
 �Insert         = Methode, mit deren Hilfe ein neues Element vom   �
 �                 Typ der benutzten Datenstruktur eingef�gt wird   �
 �KeyOf          = Abstakte Methode                                 �
 �                 Diese Methode mu� �berschrieben werden und       �
 �                 folgendes Zur�ckgeben:                           �
 �                 -1 : Wenn das Schl�sselfeld von ISearch kleiner  �
 �                      ist als das Schl�sselfeld von IFind         �
 �                 0  : Wenn beide Felder gleich sind               �
 �                 1  : Wenn ISearch gr��er ist als IFind           �
 �MakeForEach    = Interne Methode, die durch Rekursion jedes Ele-  �
 �                 ment des Baumes der Prozedurvariablen What       �
 �                 �bergibt                                         �
 �Put            = Interne Methode, die das Einf�gen �bernimmt      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Implementation (Nicht�ffentlicher Teil.)                          �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Implementation

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Constructor TTree.Init                                            �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Erzeugen und initialisieren des Feldes First.                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Constructor TTree.Init;
Begin
  First := New(PTreeItem);
  First := Nil;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Destructor TTree.Done;                                            �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Wenn eine Liste besteht (First <> NIL) dann alle Elemente mit     �
 �Hilfe  von FreeL l�schen                                          �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Destructor TTree.Done;
Begin
  If First <> NIL then
  FreeL(First);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Function  TTree.At                          ;                     �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Das Element suchen, welches �ber die Funktion KeyOf mit Item      �
 ��bereinstimmt                                                     �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Function  TTree.At (Item : Pointer): Pointer;
Begin
  At := Get(Item,First);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Function TTree.Delete                                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Wenn eine Liste besteht, dann das Element l�schen, welches �ber   �
 �die Funktion KeyOf mit Item �bereinstimmt                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Function TTree.Delete(Item: Pointer) : Boolean;
Var
  OK : Boolean;
Begin
  If First <> NIL then
  OK := FreeItem(Item,First);
  Delete := OK;
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Function TTree.FreeItem                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Ein Element rekursiv l�schen                                      �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TTree.MakeForEach                                       �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Die mit What spezifizierte Procedure aufrufen und ihr ein Item    �
 ��bergeben                                                         �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TTree.MakeForEach(What : Pointer; Var AFirst: PTreeItem);
Begin
  AForEach(What)(AFirst^.Item);
  If AFirst^.Left <> NIL then
  MakeForEach(What,AFirst^.Left);
  If AFirst^.Right <> NIL then
  MakeForEach(What,AFirst^.Right);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TTree.ForEach                                           �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Die Elemente des Baumes �bergeben                                 �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
Procedure TTree.ForEach;
Begin
  If First <> NIL then
  MakeForEach(WhatProcedure,First);
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TTree.FreeL                                             �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Alle Elemente des Baumes l�schen                                  �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Function  TTree.Get                                               �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Sucht ein Element                                                 �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TTree.Insert                                            �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �F�gt ein Element ein                                              �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Function TTree.KeyOf                                              �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Abstrakte Methode, die �berschrieben werden mu�                   �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}

Function TTree.KeyOf(Var ISearch, IFind: Pointer): Integer;
Begin
end;

{敖陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳朕
 �Procedure TTree.Put                                               �
 団陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳調
 �Interne Methode, die das Einf�gen �bernimmt                       �
 青陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳潰}
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
