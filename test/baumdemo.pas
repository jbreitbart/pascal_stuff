{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autorin: Gabi Rosenbaum    22.10.92              �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 �Programm BaumDemo                                                 �
 ������������������������������������������������������������������ͼ}
Program BaumDemo;                                       {BaumDemo.pas}
Uses
  Crt, Objects, OBaum;
{������������������������������������������������������������������Ŀ
 �Object TMyTree                                                    �
 ��������������������������������������������������������������������}
Type
  PMyTree = ^TMyTree;
  TMyTree = Object(TTree)
     Function KeyOf(Var ISearch, IFind: Pointer): Integer;Virtual;
  end;

{������������������������������������������������������������������Ŀ
 �Record TMyItem                                                    �
 ��������������������������������������������������������������������}
  MyItem  = ^TMyItem;
  TMyItem = Record
    Name    : String;
    Vorname : String;
    Alter   : String;
  end;

{������������������������������������������������������������������Ŀ
 �Function TMyTreeKeyOf                                             �
 ������������������������������������������������������������������Ĵ
 �Diese Methode wird so �berschrieben, da� das Schl�sselfeld Name   �
 �ist. Anhand dieses Schl�sselfelds wird entschieden, ob ein Ein-   �
 �trag rechts oder links in den Baum eingef�gt wird.                �
 ��������������������������������������������������������������������}
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

{������������������������������������������������������������������Ŀ
 �Procedure NamenAusgeben                                           �
 ������������������������������������������������������������������Ĵ
 �Gibt die im Baum abgelegten Namen aus.                            �
 ��������������������������������������������������������������������}
Procedure NamenAusgeben(AItem: Pointer);Far;
Var
  S : String;
Begin
  S := MyItem(AItem)^.Name;
  Writeln(S);
end;

{������������������������������������������������������������������Ŀ
 �Procedure VornamenAusgeben                                        �
 ������������������������������������������������������������������Ĵ
 �Gibt die im Baum abgelegten Vornamen aus.                         �
 ��������������������������������������������������������������������}
Procedure VornamenAusgeben(AItem: Pointer);Far;
Var
  S: String;
Begin
  S := MyItem(AItem)^.Vorname;
  Writeln(S);
end;

Var
  Baum : PMyTree;

{������������������������������������������������������������������Ŀ
 �Procedure Hauptschleife                                           �
 ������������������������������������������������������������������Ĵ
 �Erstellt ein Men� zur Bearbeitung des Baumes.                     �
 ��������������������������������������������������������������������}
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
    Writeln('      1   =   Ein Element Einf�gen');
    Writeln('      2   =   Ein Element Suchen');
    Writeln('      3   =   Alle Namen ausgeben');
    Writeln('      4   =   Alle Vornamen ausgeben');
    Writeln('      5   =   Einen Namen l�schen');
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
            Writeln('Bitte eine Taste dr�cken !!');
            ReadKey
          end;
    '3' : Begin
            Baum^.ForEach(@NamenAusgeben);
            Writeln;
            Writeln('Bitte eine Taste dr�cken !!');
            ReadKey;
          end;
    '4' : Begin
            Baum^.ForEach(@VornamenAusgeben);
            Writeln;
            Writeln('Bitte eine Taste dr�cken !!');
            readKey;
          end;
    '5' : Begin
            PtrS := New(MyItem);
            Write('Welcher Name soll gel�scht werden ? : ');
            ReadLn(PtrS^.Name);
            PtrS^.Vorname := '';
            PtrS^.Alter := '';
            OK  := Baum^.Delete(PtrS);
            Dispose(PtrS);

            If OK then
            S := 'Der Eintrag wurde gel�scht' else
            S := 'Es wurde kein Eintrag gefunden';
            Writeln;
            Writeln(S);
            Writeln;
            Writeln('Bitte eine Taste dr�cken !!');
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
