{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                    Demoprogramm (Unit _Tools)                    �
 �                 Autor: Reiner Sch�lles, 01.08.92                 �
 �                                                                  �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
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