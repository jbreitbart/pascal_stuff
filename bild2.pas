{$A-,B-,D+,E+,F-,G+,I+,L+,N-,O-,R+,S+,V+,X-}
{$M 16384,0,655360}
uses Dos,alles,graph;
var  grd, grm      : Integer;
begin
 grd:=vga;
 grd:=1;
 initgraph(grm,grd,'');
 SwapVectors;
 Exec('a:\picem.exe','/K /D /E a:\a.gif');
 SwapVectors;
 readln;
 mouseinit;
 mouseshow;
 readln;
 if DosError <> 0 then{ Error? }
   WriteLn('Dos error #', DosError);
 closegraph;
end.