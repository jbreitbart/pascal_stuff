program oje_oje;

var  x:pointer;

procedure jmpf:assembler;
asm
db $EA
dd x
end;

begin
x:=@jmpf;
end.