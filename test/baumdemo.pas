{…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª
 ∫                Das gro·e Buch zu Turbo Pascal 7.0                ∫
 ∫                                                                  ∫
 ∫                 Autorin: Gabi Rosenbaum    22.10.92              ∫
 ∫                                                                  ∫
 «ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ∂
 ∫Programm BaumDemo                                                 ∫
 »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº}
Program BaumDemo;                                       {BaumDemo.pas}
Uses
  Crt, Objects, OBaum;
{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥Object TMyTree                                                    ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}
Type
  PMyTree = ^TMyTree;
  TMyTree = Object(TTree)
     Function KeyOf(Var ISearch, IFind: Pointer): Integer;Virtual;
  end;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥Record TMyItem                                                    ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}
  MyItem  = ^TMyItem;
  TMyItem = Record
    Name    : String;
    Vorname : String;
    Alter   : String;
  end;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥Function TMyTreeKeyOf                                             ≥
 √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
 ≥Diese Methode wird so Åberschrieben, da· das SchlÅsselfeld Name   ≥
 ≥ist. Anhand dieses SchlÅsselfelds wird entschieden, ob ein Ein-   ≥
 ≥trag rechts oder links in den Baum eingefÅgt wird.                ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}
Function TMyTree.KeyOf;
Begin
  If MyItem(ISearch)^.Name = MyItem(IFind)^.Name then
     KeyOf := 0
  else
     If MyItem(ISearch)^.Name > MyItem(IFind)^.Name then
        KeyOf := 1
     else
       If MyItem(ISearch)^.Name < MyItem(IFind)^.Name then
          KeyOf := -1;
end;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥Procedure NamenAusgeben                                           ≥
 √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
 ≥Gibt die im Baum abgelegten Namen aus.                            ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}
Procedure NamenAusgeben(AItem: Pointer);Far;
Var
  S : String;
Begin
  S := MyItem(AItem)^.Name;
  Writeln(S);
end;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥Procedure VornamenAusgeben                                        ≥
 √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
 ≥Gibt die im Baum abgelegten Vornamen aus.                         ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}
Procedure VornamenAusgeben(AItem: Pointer);Far;
Var
  S: String;
Begin
  S := MyItem(AItem)^.Vorname;
  Writeln(S);
end;

Var
  Baum : PMyTree;

{⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
 ≥Procedure Hauptschleife                                           ≥
 √ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥
 ≥Erstellt ein MenÅ zur Bearbeitung des Baumes.                     ≥
 ¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ}
Procedure Hauptschleife;
Var
  S    : String;
  ch   : Char;
  PtrS : MyItem;
  Erg  : Pointer;
  OK   : Boolean;
Begin
  Repeat
    ClrScr;
    WriteLn('Demonstration des Objectes TTree');WriteLn;
    Writeln('      1   =   Ein Element EinfÅgen');
    Writeln('      2   =   Ein Element Suchen');
    Writeln('      3   =   Alle Namen ausgeben');
    Writeln('      4   =   Alle Vornamen ausgeben');
    Writeln('      5   =   Einen Namen lîschen');
    Writeln('      6   =   Programm beenden');
    Writeln;
    ch := UpCase(ReadKey);
    Case ch of
    '1' : Begin
            PtrS := New(MyItem);
            Write('Bitte den Namen eingeben            : ');
            ReadLn(PtrS^.Name);
            Write('Bitte den Vornamen eingeben         : ');
            ReadLn(PtrS^.Vorname);
            Write('Bitte das Alter eingeben            : ');
            ReadLn(PtrS^.Alter);
            Baum^.Insert(PtrS);
          end;
    '2' : Begin
            PtrS := New(MyItem);
            Write('Welcher Name soll gesucht werden ? : ');
            ReadLn(PtrS^.Name);
            PtrS^.Vorname := '';
            PtrS^.Alter := '';
            Erg  := Baum^.At(PtrS);
            Dispose(PtrS);

            If Erg <> NIL then
               S := MyItem(Erg)^.Name + ', '+MyItem(Erg)^.Vorname +
                ', ' + MyItem(erg)^.Alter
            else
               S := 'Es wurde kein Eintrag gefunden';

            Writeln;
            Writeln(S);
            Writeln;
            Writeln('Bitte eine Taste drÅcken !!');
            ReadKey
          end;
    '3' : Begin
            Baum^.ForEach(@NamenAusgeben);
            Writeln;
            Writeln('Bitte eine Taste drÅcken !!');
            ReadKey;
          end;
    '4' : Begin
            Baum^.ForEach(@VornamenAusgeben);
            Writeln;
            Writeln('Bitte eine Taste drÅcken !!');
            readKey;
          end;
    '5' : Begin
            PtrS := New(MyItem);
            Write('Welcher Name soll gelîscht werden ? : ');
            ReadLn(PtrS^.Name);
            PtrS^.Vorname := '';
            PtrS^.Alter := '';
            OK  := Baum^.Delete(PtrS);
            Dispose(PtrS);

            If OK then
            S := 'Der Eintrag wurde gelîscht' else
            S := 'Es wurde kein Eintrag gefunden';
            Writeln;
            Writeln(S);
            Writeln;
            Writeln('Bitte eine Taste drÅcken !!');
            ReadKey
          end;
    '6' : Begin
            Writeln;
            Writeln('Soll das Programm wirklich beendet werden <J>');
            ch := UpCase(ReadKey);
            If ch <> 'J' then
               ch := 'J'
            else
               ch := '6';
          end;
    end;
  Until ch = '6';
end;

Begin
  Baum := New(PMyTree,Init);
  Hauptschleife;
  Dispose(Baum,Done);
end.
