program xcrack;

uses crt,dos;

var f,a : file of byte;
    fn,an :String;
    b : Byte;

begin
 writeln('Fehlermeldung am Schluá ignorieren!');
 writeln;
 write('Original Datei (mit šbergr”áe) : ');
 readln(fn);
 assign(f,fn);
 write('Zielverzeichnis und Name eingeben : ');
 readln(an);
 assign(a,an);
 while not(eof(f)) do begin
  read(f,b);
  write(a,b);
 end;
end.