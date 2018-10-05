Program TOS;
{Programmiert von nicht Triepstein}

uses dos, crt, dogs;
var Lauf : integer;
    F : Text;
Begin
 clrscr;
 highvideo;
 Textcolor (7);
 writeln ('OS Triep Warp 95 wird jetzt gestartet ...');
 Assign(F,'TOS.sys');
 ReWrite(F);
 WriteLn(F,'A');
 Close(F);
 delay (1024);
 writeln;
 writeln;
 writeln ('Die CONFIG.SYS wird jetzt gestartet');
 writeln;
 write ('LOWMEM testet den oberen Speicherunterbereich');
 delay (500);
 write ('.');
 delay (500);
 write ('.');
 delay (500);
 write ('.');
 delay (500);
 write ('. ');
 delay (600);
 writeln ('O.k.');
 delay (200);
 write ('');
 readln;
end.