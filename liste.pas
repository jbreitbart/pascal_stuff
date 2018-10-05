program Liste;

type Zeiger  = ^Element;
     Element = Record
                Naechster : Zeiger;
                Inhalt    : Integer;
               end;

var Wurzel,z : Zeiger;

Begin
 writeln('Erstellen der Liste.');
 writeln('Geben Sie Zahlen ein (Ende mit Null):');
 wurzel:=nil;
 repeat
  new(z);
  readln(z^.inhalt);
  z^.Naechster:=Wurzel;
  wurzel:=z;
 until z^.Inhalt=0;
 writeln('Ausgabe der Liste : ');
 z:=Wurzel;
 while z<> nil Do begin
  writeln(z^.Inhalt);
  z:=z^.naechster;
 end;
end.