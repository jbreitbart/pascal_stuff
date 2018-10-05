{$M $4000,0,40000} 			{16k stack, no heap - adjust as needed }
program sinusoidal_scroll;

var
  dev,mix,stat,pro,loop : integer;
  md : string;

{$L MOD-obj.OBJ} 	        { Link in Object file }
{$F+} 				{ force calls to be 'far'}
procedure modvolume(v1,v2,v3,v4:integer); external ; {Can do while playing}
procedure moddevice(var device:integer); external ;
procedure modsetup(var status:integer;device,mixspeed,pro,loop:integer;var str:string); external ;
procedure modstop; external ;
procedure modinit; external;
{$F-}

var a : Integer;

begin
        modinit;
        dev:=7;
{	moddevice ( dev );}
        if dev<>255 then
        begin
          md:='C:\testpas\sinscr\universe.mod';
          mix := 8000;
          pro := 0;
          loop :=4;
   	  modsetup ( stat, dev, mix, pro, loop, md );
          modvolume (255,255,255,255);
        end;
        writeln(stat);
        readln;
  if dev<>255 then modstop;
end.