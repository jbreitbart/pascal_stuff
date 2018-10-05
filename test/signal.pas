{ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
 บ                Das groแe Buch zu Turbo Pascal 7.0                บ
 บ                    Demoprogramm (Unit _Tools)                    บ
 บ                 Autor: Reiner Sch”lles, 01.08.92                 บ
 บ                                                                  บ
 ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ}
Program SignalTon; {Signal.pas}
uses Crt,_Tools;
begin
  ClrScr;
  _WarnTon:= true;                         {Falls ausgeschaltet}
  _TonDauer:= 500;
  _TonFrequenz:= 40;
  writeln('Tonleiter rauf...');
  while _TonFrequenz < 600 do
  begin
    Inc(_TonFrequenz,20);
    _SignalTon;
  end;
  writeln('...und wieder runter...');
  while _TonFrequenz > 60 do
  begin
    Dec(_TonFrequenz,20);
    _SignalTon;
  end;
  ClrScr;
end.