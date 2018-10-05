uses dos;

var ins,frei : LONGINT;
begin
 frei:=diskfree(0);
 ins:=disksize(0);
 writeln('Es sind von ',ins,' Bytes ',frei,' frei');
 frei:=frei div 1024;
 ins:=ins div 1024;
 writeln('Es sind von ',ins,' Kilobytes ',frei,' frei');
 frei:=frei div 1024;
 ins:=ins div 1024;
 writeln('Es sind von ',ins,' Megabytes ',frei,' frei');
 frei:=frei div 1024;
 ins:=ins div 1024;
 writeln('Es sind von ',ins,' Gigabytes ',frei,' frei');
end.