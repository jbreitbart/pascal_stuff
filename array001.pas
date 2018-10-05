program Liste001;

uses crt;

var z :    BYTE;
    Name : ARRAY[1..20] OF STRING;



begin
  clrscr;
  for z := 1 to 20 do
      begin
        write('Bitte geben Sie den ', z, '. Namen ein: ');
        readln(Name[z])
      end;
  ClrScr;
  for z := 1 to 20 do writeln('Der ', z, '. Name ist: ', Name[z]);
  readln
end.