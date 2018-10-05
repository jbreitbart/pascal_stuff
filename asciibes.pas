program hallo;

uses crt,alles;

var c:char;
begin
 clrscr;
 repeat
  tpl;
  c:=readkey;
  writeln(ord(c));
 until esc;
end.