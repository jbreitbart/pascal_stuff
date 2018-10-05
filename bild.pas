{$M $4000,0,0 }   { 16K stack, no heap }
uses Dos,alles,graph;
var  grd, grm      : Integer;
begin
 grd:=vga;
 grd:=1;
 initgraph(grm,grd,'');
 SwapVectors;
 Exec('c:\pascal\picem.exe','/K /D /E a.gif');
 SwapVectors;
 mouseinit;
 mouseshow;
 readln;
 if DosError <> 0 then{ Error? }
   WriteLn('Dos error #', DosError);
 closegraph;
end.