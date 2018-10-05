uses crt;

var a,b,c : Char;
    s : String;
begin
 checkbreak:=false;
 for c:='a' to 'z' DO begin
  mkdir('C:\a\'+c);
  for b:='a' to 'z' DO begin
  mkdir('C:\a\'+c+'\'+b);
   for a:= 'a' to 'z' DO begin
    s:='C:\a\'+c+'\'+b+'\'+a;
    mkdir(s);
   end;
  end;
 end;
end.