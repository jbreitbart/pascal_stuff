program DynVarErzeugen;  {Dynamic2.PAS}
uses crt;
const
  n = 250;
type
  Ary = array[1..n] of ^string;
var
  x: Ary;
  i: integer;
begin
  clrscr;
  writeln('Speicherplatz auf dem Heap vorher: ',memAvail);
  for i:= 1 to n do new(x[i]);
  writeln('Speicherplatz auf dem Heap nachher: ',memAvail);
  gotoxy(1,25);
  write('Bitte [Return] drÅcken...');
  readln;
end.
