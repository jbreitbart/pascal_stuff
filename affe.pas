uses crt,alles;

var an,a,x : Word;

begin
 an:=0;
 a:=0;
 x:=0;
 repeat
  an:=an+(x*3);
  x:=x+1;
  a:=a+3;
 until a=99+3;
 x:=1600-an;
 writeln;
 writeln (an:10);
 writeln (x:10);
 writeln (a:10);
end.