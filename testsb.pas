uses modplay,crt;

var b : Integer;

begin
 init_sb;
 b:=lade_moddatei('d:\data\tubells.mod',Auto,auto);
 writeln(b);
end.