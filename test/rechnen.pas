{浜様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様融
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 把陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳超
 � Beispielunit zum Aufbau einer Unit.                              �
 藩様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様様夕}
Unit Rechnen;                                     {Datei: Rechnen.pas}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Interface (�ffentlicher Teil)陳}
Interface
uses Crt;                                {Bibliothek aus Turbo Pascal}

  function Plus(x1,x2: real): real;
  function Minus(x1,x2: real): real;

{陳陳陳陳陳陳陳陳陳陳陳陳陳Implementation (nicht-�ffentlicher Teil)陳}
Implementation
var Erg: real;                                       {Lokale Variable}

function Plus(x1,x2: real): real;
begin
  Erg:= x1 + x2;
  writeln('Ausgabe der Funktion PLUS:');
  writeln(x1:10:2,' + ',x2:10:2,' = ',Erg:10:2);
  writeln;
  Plus:= Erg;
end; {Plus}

function Minus(x1,x2: real): real;
begin
  Erg:= x1 - x2;
  writeln('Ausgabe der Funktion MINUS:');
  writeln(x1:10:2,' - ',x2:10:2,' = ',Erg:10:2);
  writeln;
  Minus:= Erg;
end; {Minus}

{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳Initialisierungsteil陳}
begin
  ClrScr;
  write('Jetzt im Initialisierungsteil ');
  writeln('der Unit RECHNEN!');
  writeln('-----------------------------------------------');
  writeln;
end.
{陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳陳�Ende der Unit Rechnen陳}
