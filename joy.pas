{ **************************************************************** }
{         ****** JOYSTICK.PAS   ********                           }
{ This program contains a pascal-routine to obtain the joystick    }
{ position and which buttons are pressed. It serves as an example, }
{ but it is too slow for high resolution. If you need a higher     }
{ resolution, use the FASTJOY.PAS, which uses TP inline code.      }
{                                                                  }
{ Original author:                                                 }
{                        Jack Baltus                               }
{                        Pres. Kennedystraat 20                    }
{                        6451 AV  Schinveld                        }
{                        Tel: 045-253729                           }
{                        The Netherlands                           }
{ **************************************************************** }

uses crt;

var  X, Y : integer;
     L, R : boolean;

procedure Joystick(StickNummer:integer;
                       var X,Y:integer;
                       var L,R:boolean);
{ **************************************************************** }
{                                                                  }
{ This procedure reads the X and Y coordinates and the position of }
{ the buttons                                                      }
{                                                                  }
{ StickNummer = 1 for  joystick 1                                  }
{               2 for  joystick 2                                  }
{                                                                  }
{ X = X-coordinate                                                 }
{ Y = Y-coordinate                                                 }
{                                                                  }
{ L = true if left button pressed                                  }
{ R = true if right button pressed                                 }
{                                                                  }
{ **************************************************************** }
const GamePort = $201;
      Dummy    = 0;
var   teller   : byte;
begin
 if StickNummer = 1 then
 begin
  teller := 0;
  Port[GamePort] := Dummy;
  repeat
   inc(teller);
  until (Port[GamePort] and 1) = 0;
  x := teller;
  repeat until (Port[GamePort] and 3) = 0;
  teller := 0;
  Port[GamePort] := Dummy;
  repeat
   inc(teller);
  until (Port[GamePort] and 2) = 0;
  y := teller;
  if Port[GamePort] and 16 = 0 then L := true else L := false;
  if Port[GamePort] and 32 = 0 then R := true else R := false;
 end
 else
 begin
  teller := 0;
  Port[GamePort] := Dummy;
  repeat
   inc(teller);
  until (Port[GamePort] and 4) = 0;
  x := teller;
  repeat until (Port[GamePort] and 12) = 0;
  teller := 0;
  Port[GamePort] := Dummy;
  repeat
   inc(teller);
  until (Port[GamePort] and 8) = 0;
  y := teller;
  if Port[GamePort] and 64 = 0 then L := true else L := false;
  if Port[GamePort] and 128 = 0 then R := true else R := false;
 end;
end;

begin
 clrscr;
 repeat
  Joystick(1,X,Y,L,R);
  gotoxy(1,1); write(x:5,y:5,L:8,R:8);
  delay(600);
 until keypressed;
end.
