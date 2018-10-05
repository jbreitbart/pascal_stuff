uses modplay;

var i : Integer;
    a : effect_type;

begin
 init_sb;
 write_sbconfig;
 i:=Lade_soundeffekt('D:\data\tubells.mod',a);
 writeln(i);
 starte_soundeffekt(a,63000,50,AMIGA);
{ i:=lade_moddatei ('D:\data\tubells.mod',AUTO,AUTO);}
 readln;
end.