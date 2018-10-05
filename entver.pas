program verschlusseln;

uses crt,dos;

var f,fe,f1,fe1: File of byte;
    i : byte;

begin
 if paramstr(2) = 'v' then begin
  assign(f,paramstr(1));
  assign(f1,paramstr(1));
  reset(f);
  reset(f1);
  repeat
   read (f,i);
   if i=255 then i:=0
   else  i:=i+1;
   write(f1,i);
   if eof(f) then halt;
   read (f,i);
   if i=0 then i:=255
   else  i:=i-1;
   write(f1,i);
  until eof(f);
  close(f);
  close(f1);
 end;
 if paramstr(2) ='e' then begin
  assign(fe1,paramstr(1));
  assign(fe,paramstr(1));
  reset(fe);
  reset(fe1);
  repeat
   read(fe1,i);
   if i=0 then i:=255
   else i:=i-1;
   write(fe,i);
   if eof(fe1) then halt;
   read (fe1,i);
   if i=255 then i:=0
   else i:=i+1;
   write(fe,i);
  until eof(fe1);
  close(fe1);
  close(fe);
 end;
end.