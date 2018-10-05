uses dos;
var s,a: String;
begin
 repeat
  s:='C:\';
  readln(a);
  s:=s+a;
  mkdir(s)
 until S=' ';
end.