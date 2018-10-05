{*** Centronics-Interface-Test ***}
program testlpt;

uses crt;
const lpt = 888;  {888 bei lpt1}
var a:integer;

{*************  Ausgabe von Daten auf Port A und B *******************}

procedure porta(wert:integer);      (* Ausgabe an Port A *)
begin
  port[lpt+2]:=2;
  port[lpt]:=wert;
  port[lpt+2]:=3;
  port[lpt+2]:=2;
end;

procedure portb(wert:integer);      (* Ausgabe an Port B *)
begin
  port[lpt+2]:=0;
  port[lpt]:=wert;
  port[lpt+2]:=1;
  port[lpt+2]:=0;
end;

{***********  Einlesen von Daten aus den Ports C,D und E(=ungepuffert) ****}
function porte:integer;
begin
  porte:=port[lpt+1];
end;

function portd:integer;
begin
    port[lpt+2]:=3;
    port[lpt]:=255;(* Einlesen von Port D   *)
    delay(1);
    portd:=port[lpt];
end;

function portc:integer;
begin
    port[lpt+2]:=2  ; port[lpt]:=255;(* Einlesen von Port C   *)
             delay(1)        ; portc:=port[lpt];
end;

begin
 clrscr;
 a:=0;
 repeat         {Port A Pin 0 und B Pin 0 schalten blinkend 5V auf Masse 25mA}
    a:=1-a;     {"FlipFlop" fÅr a}
    porta(a);
    portb(a);
    gotoxy(10,10);
    writeln(a);
    delay(100)
 until keypressed;
                   {Hier mÅ·te eine Anweisung zur Lîschung des Tastaturpuffers
		    erfolgen, daher nun eine Endlosschleife}	
 repeat
    a:=portd;      {Lesen von Signalen an Port D}  
    gotoxy(10,10);
    writeln(a);
    delay(10);
 until false;

end.