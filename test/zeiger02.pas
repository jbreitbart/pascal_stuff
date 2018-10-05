program Zeiger02;  {Zeiger02.PAS}
uses crt;
type
  zeiger = ^integer;
var
  a,b,c: zeiger;
begin
  clrscr;
  {Erzeugung der dynamischen Variablen a^,b^,c^}
  new(a);
  new(b);
  new(c);
  {Zuweisung von Werten an die Variablen}
  a^:= 20;
  b^:= 40;
  c^:= 60;
  writeln('a^ = ',a^,'  b^ = ',b^,'   c^ = ',c^);
  writeln;
  writeln('Inhalt von b^ wird a^ zugewiesen');
  writeln;
  a^:= b^;
  writeln('a^ = ',a^,'  b^ = ',b^,'   c^ = ',c^);
  writeln;
  writeln('c^ wird das Produkt a^ * b^ zugewiesen');
  writeln;
  c^:= a^ * b^;
  writeln('a^ = ',a^,'  b^ = ',b^,'   c^ = ',c^);
  gotoxy(1,25);
  write('Bitte [Return] drÅcken...');
  readln;
  {Dynamische Variablen wieder entfernen}
  dispose(a);
  dispose(b);
  dispose(c);
end.
