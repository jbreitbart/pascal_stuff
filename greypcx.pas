{$m 2048,0,0}
uses dos,crt;

var

Dat:file;
Tab:array [1..768] of byte;
Name:string;
Num,i,j,x,BLine:Word;
Info:searchrec;
Z:byte;
Pos:longint;

procedure Stop;begin writeln (#10#13'Aufruf mit GREYPCX <datei.pcx>');halt;end;

begin
if paramcount<>1 then Stop;

Name:=paramstr(1);assign (Dat,Name);

{$I-} reset (Dat,1); {$I+} if IOResult<>0 then stop;

findfirst (Name,archive,Info);

seek (Dat,66);
blockread (Dat,BLine,2);

if BLine=320 then begin Pos:=Info.size-768;Num:=256;end
   else begin Pos:=16;Num:=16;end;

seek (Dat,pos);
blockread (Dat,Tab,Num*3);
close (Dat);

SwapVectors;Exec(GetEnv('COMSPEC'),'/C '+'copy '+name+' grey'+name);
SwapVectors;if DosError <> 0 then
begin WriteLn('Could not execute COMMAND.COM');stop;end;

x:=1;
for i:= 1 to Num do begin
 z:= (30*tab[x] + 59*tab[x+1] + 11*tab[x+2]) div 100;
 for j:= 0 to 2 do tab[x+j]:=z;
 x:=x+3;
end;

assign (Dat,'grey'+Name);
reset (Dat,1);

seek (Dat,Pos);
blockwrite (Dat,Tab,Num*3);
close (Dat);
end.