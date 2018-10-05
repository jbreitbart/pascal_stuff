{������������������������������������������������������������������ͻ
 �                Das gro�e Buch zu Turbo Pascal 7.0                �
 �                                                                  �
 �                 Autor: Reiner Sch�lles, 19.10.92                 �
 �                                                                  �
 ������������������������������������������������������������������Ķ
 � Beispielunit zum Aufbau einer Unit.                              �
 ������������������������������������������������������������������ͼ}
Unit Rechnen;                                     {Datei: Rechnen.pas}

{�������������������������������������Interface (�ffentlicher Teil)��}
Interface
uses Crt;                                {Bibliothek aus Turbo Pascal}

  function Plus(x1,x2: real): real;
  function Minus(x1,x2: real): real;

{��������������������������Implementation (nicht-�ffentlicher Teil)��}
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

{����������������������������������������������Initialisierungsteil��}
begin
  ClrScr;
  write('Jetzt im Initialisierungsteil ');
  writeln('der Unit RECHNEN!');
  writeln('-----------------------------------------------');
  writeln;
end.
{���������������������������������������������Ende der Unit Rechnen��}
