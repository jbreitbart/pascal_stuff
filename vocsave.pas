uses crt,graph,alles;

type Tvoc=string[40];

var d,e : File of TVoc;
    deu,eng : TVoc;

begin
 clrscr;
 assign(d,'Deutsch.dat');
 assign(e,'Englisch.dat');
 rewrite(d);
 rewrite(e);
 repeat
  write('Deutsch : ');
  readln(Deu);
  write('English : ');
  readln(eng);
  if (deu <>'') and (eng <>'') then begin
   write(d,deu);
   write(e,eng);
  end;
 until (deu='') or (eng='');
 close(d);
 close(e);
end.