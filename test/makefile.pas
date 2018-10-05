{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                    Demoprogramm (Unit _Tools)                    บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program DateiErzeugen; {MakeFile.pas}
uses Crt,_Tools;
var Dateiname: _Str;
begin
  ClrScr;
  write('Gib Dateinamen ein: ');
  readln(Dateiname); writeln;
  if _FileExist(Dateiname) then
  begin
    _SignalTon;
    writeln('Datei existiert bereits! Anwendung von ');
    writeln('Rewrite zerst”rt die Datei.');
  end else
  begin
     if _FileMake(Dateiname)
      then writeln('Alles Ok! Datei kann ohne Fehler ' +
                   'erzeugt werden.')
      else
      begin
        _SignalTon;
        writeln('A C H T U N G! Datei kann nicht ' +
                'angelegt werden.');
        writeln('Dateinamen berprfen');
      end;
  end;
  readln;
end.