Program HideLW;

uses dos;

var state,drive:String;
    n          :Byte;

procedure quit;

begin
 writeln('HideLW schaltet Laufwerk AUS/EIN.');
 writeln('Aufruf: HideLW [Dr:] [IT/NOT]');
 halt(1);
end;

procedure SetState(Dr:Byte;On:Boolean);

var Rg:Registers;

begin
 If on Then Begin
  with rg Do Begin
   ax:=$5f07;
   dl:=Dr;
   msdos(Rg);
   If(flags and 1 )=0 then Writeln('Laufwerk '+CHr(Dr+65)+': EIN');
  end;
 end
 else
 Begin
  with Rg DO Begin
   ax:=$5f08;
   dl:=dr;
   MsDos(Rg);
   if (Flags And 1)= 0 Then writeln('Laufwerk '+chr(Dr+65)+':AUS');
  end;
 end;
end;

Begin
 IF ParamCount <> 2 then Quit;
 drive:=ParamStr(1);
 State:=ParamStr(2);
 FOR n :=1 to length(state) DO State[n]:=Upcase(state[n]);
 if (State <> 'IT') and (State <> 'NOT') then quit;
 FOR n:=1 to Length(Drive) DO drive[n]:= Upcase(Drive[n]);
 IF (Pos(':',Drive) <> 2) and (NOT(Drive[1] in ['A'..'Z'])) then quit;
 setstate(Ord(Drive[1])-65,(State='NOT'));
end.